import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensors_plus/src/orientation_interface.dart' as sensors;
import 'package:street_manta_client/utils/device_info.dart';
import 'package:uuid/uuid.dart';
import '../globals.dart';
import 'geo_capture_handle.dart';
import 'file_uploader.dart';
import 'package:geolocator/geolocator.dart';
import '../protobufs/geo_capture.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:path/path.dart' as pathlib;
import 'package:camera_android/camera_android.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:sensors_plus/sensors_plus.dart' as sensors;

Logger logger = Logger();

class Recorder {
  Recorder();

  late Globals globals;

  //GeoCapture
  String? currentCaptureId;
  GeoCaptureHandle? currentGeoCaptureHandle;
  bool isRecording = false;
  String deviceModel = 'Unknown';
  Timer? continuousUploadTimer;
  FileUploader uploader = FileUploader();
  String traceIdentifier = Uuid().v4();
  int currentChunkIndex = 0;
  Queue<Future<void>> chunkQueue = Queue();
  late Directory tempDir;
  int currentCaptureStartEpoch = 0;

  //Camera
  CameraDescription? cameraDescriptor = null;
  CameraController? cameraController;
  late Directory uploadDirectory;
  String? videoEncoderTmpPath;
  String cameraIdentifier = 'cam0';
  late int videoBitrate;
  late int fps;
  late double exposureOffset;

  //IMU;
  OrientationReading? lastOrientationReading;

  Future<CameraController> initializeWithCamera(
      CameraDescription camera) async {
    cameraDescriptor = camera;
    globals = await Globals.getInstance();
    videoBitrate = globals.videoBitrate;
    fps = globals.videoFps;
    exposureOffset = globals.videoExposureOffset.toDouble();
    cameraController = CameraController(
        cameraDescriptor!, ResolutionPreset.high,
        fps: fps, videoBitrate: videoBitrate);
    tempDir = await (await getTemporaryDirectory()).createTemp();
    await cameraController!.initialize();
    if (!cameraController!.value.isInitialized) {
      throw 'Error initializing camera';
    }
    uploadDirectory = await uploader.getUploadDirectory();
    await _loadMotionSensors();
    deviceModel = await getDeviceModel();
    return cameraController!;
  }

  Future<void> initializeWithoutCamera() async {
    uploadDirectory = await uploader.getUploadDirectory();
    await _loadMotionSensors();
    deviceModel = await getDeviceModel();
  }

  String _generateCaptureIdentifier() {
    return Uuid().v4();
  }

  _initNewChunk() {
    logger.d("Initializing new chunk");
    currentChunkIndex += 1;
    currentGeoCaptureHandle = GeoCaptureHandle();
    currentGeoCaptureHandle!.geoCapture.identifier = currentCaptureId!;
    currentGeoCaptureHandle!.geoCapture.chunkIndex = Int64(currentChunkIndex);
    currentGeoCaptureHandle!.geoCapture.traceIdentifier = traceIdentifier;
    currentGeoCaptureHandle!.geoCapture.gps = GpsCapture();
    currentGeoCaptureHandle!.geoCapture.orientation = OrientationCapture();
    currentGeoCaptureHandle!.geoCapture.acceleration = AccelerationCapture();
    currentGeoCaptureHandle!.geoCapture.angularVelocity =
        AngularVelocityCapture();
    currentGeoCaptureHandle!.geoCapture.magneticField = MagneticFieldCapture();
    currentGeoCaptureHandle!.geoCapture.chunkIndex = Int64(currentChunkIndex);
  }

  void _chunkCurrentGeoCapture({bool isLast = false}) {
    logger.d('Chunking GeoCapture');
    var oldGeoCaptureHandle = currentGeoCaptureHandle;
    _initNewChunk();
    chunkQueue.add(_closeCurrentGeoCaptureHandle(oldGeoCaptureHandle!,
        pathlib.join(uploadDirectory.path, '${Uuid().v4()}.cap'),
        isLast: isLast));
  }

  Future<void> startGeoCapture(double geoCaptureChunkLengthSeconds) async {
    if (!isRecording) {
      currentChunkIndex = -1; // Start at -1 so that the first chunk is 0
      currentGeoCaptureHandle = GeoCaptureHandle();
      currentCaptureId = _generateCaptureIdentifier();
      traceIdentifier = Uuid().v4();
      _initNewChunk();
      continuousUploadTimer = Timer.periodic(
          Duration(milliseconds: (geoCaptureChunkLengthSeconds * 1000).toInt()),
          (timer) {
        _chunkCurrentGeoCapture();
      });
      if (cameraController != null) {
        await cameraController!.setExposureMode(ExposureMode.locked);
        await cameraController!.setExposureOffset(exposureOffset);
        var cameraPlatform = CameraPlatform.instance as AndroidCamera;
        cameraPlatform.startChunkableVideoRecording(cameraController!.cameraId);
      }
      currentCaptureStartEpoch = DateTime.now().microsecondsSinceEpoch;
      logger.i('Started continuous recording');
    } else {
      logger.i('Cannot start continuous recording, already running!');
    }
    isRecording = true;
  }

  Future<void> stopGeoCapture() async {
    if (isRecording) {
      continuousUploadTimer!.cancel();
      _chunkCurrentGeoCapture(isLast: true);
      if (cameraController != null) {
        (CameraPlatform.instance as AndroidCamera)
            .stopChunkableVideoRecording(cameraController!.cameraId);
      }
      logger.i('Stopped continuous recording');
      while (chunkQueue.isNotEmpty) {
        await chunkQueue.removeFirst();
      }
    } else {
      logger.i('Cannot stop continuous recording, not running!');
    }
    isRecording = false;
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = File.fromUri(myUri);
    Uint8List? bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
    });
    return bytes!;
  }

  Future<void> _closeCurrentGeoCaptureHandle(
      GeoCaptureHandle geoCaptureHandle, String outputFilePath,
      {bool isLast = false}) async {
    logger.d('Finishing off GeoCapture chunk...');
    if (cameraController != null) {
      var cameraPlatform = CameraPlatform.instance as AndroidCamera;
      var videoChunk =
          await cameraPlatform.chunkVideoRecording(cameraController!.cameraId);
      var videoFile = File(videoChunk.path);
      Uint8List bytes = await videoFile.readAsBytes();
      geoCaptureHandle.geoCapture.video = VideoCapture(
          startEpochMicroSeconds: Int64(videoChunk.timestamps.first),
          endEpochMicroSeconds: Int64(videoChunk.timestamps.last),
          frameEpochsMicroSeconds:
              videoChunk.timestamps.map((e) => Int64(e)).toList(),
          format: 'mp4',
          identifier: cameraIdentifier,
          data: bytes,
          fps: Int64(fps));
      await File(videoFile.path).delete();
    }
    if (isLast) {
      geoCaptureHandle.geoCapture.isLastChunk = true;
    } else {
      geoCaptureHandle.geoCapture.isLastChunk = false;
    }
    logger.d('Writing new GeoCapture chunk...');
    logger.d('Closing GeoCapture handle (Encoding video)...');
    await geoCaptureHandle.close();
    logger.d('Done closing...');
    File file = File(outputFilePath);
    await file.writeAsBytes(geoCaptureHandle.geoCapture.writeToBuffer());
    await uploader.triggerUpload();
  }

  void dispose() {
    stopGeoCapture();
    cameraController?.dispose();
  }

  Future<GeoCaptureChunk> takeSinglePhotoCapture() async {
    if (cameraController == null) {
      throw 'Camera not initialized';
    }
    logger.i('Taking photo capture');
    final imageFile = await cameraController!.takePicture();
    var gpsPositionProto =
        _gpsPositionsToProtobuf(await Geolocator.getCurrentPosition());
    var time = Int64(DateTime.now().microsecondsSinceEpoch);
    var cameraSpecification =
        CameraSpecification(cameraIndex: cameraController!.cameraId);
    var photoCapture = PhotoCapture(
        epochMicroSeconds: time,
        cameraSpecification: cameraSpecification,
        identifier: cameraIdentifier,
        format: "jpeg",
        data: await imageFile.readAsBytes(),
        gps: GpsReading(epochMicroSeconds: time, position: gpsPositionProto),
        orientation: lastOrientationReading!);
    var capture = GeoCaptureChunk();
    capture.identifier = _generateCaptureIdentifier();
    capture.photos.add(photoCapture);
    capture.chunkIndex = Int64(0);
    capture.isLastChunk = true;
    capture.version = Int64(globals.geoCaptureFormatVersion);
    logger.i('Done taking single photo capture');
    return capture;
  }

  void _handlePositionUpdate(Position position) {
    if (isRecording) {
      var gpsPosition = GpsPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          elevation: position.altitude);
      var gpsCaptures = GpsReading(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          position: gpsPosition);
      currentGeoCaptureHandle!.geoCapture.gps.readings.add(gpsCaptures);
    }
  }

  GpsPosition _gpsPositionsToProtobuf(Position position) {
    return GpsPosition(
      latitude: position.latitude,
      longitude: position.longitude,
      elevation: position.altitude,
      positionAccuracy: position.accuracy,
      elevationAccuracy: position.altitudeAccuracy,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      heading: position.heading,
      headingAccuracy: position.headingAccuracy,
    );
  }

  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> _loadMotionSensors() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(_handlePositionUpdate);

    sensors.accelerometerEventStream().listen(
      (sensors.AccelerometerEvent event) {
        if (isRecording) {
          var acceleration = Acceleration(x: event.x, y: event.y, z: event.z);
          var accelerationReading = AccelerationReading(
              epochMicroSeconds: Int64(event.timestamp.microsecondsSinceEpoch),
              acceleration: acceleration);
          currentGeoCaptureHandle!.geoCapture.acceleration.readings
              .add(accelerationReading);
        }
      },
      onError: (error) {
        logger.e('Accelerations Sensor Error: $error');
      },
      cancelOnError: true,
    );
    sensors.gyroscopeEventStream().listen(
      (sensors.GyroscopeEvent event) {
        if (isRecording) {
          var angularVelocity =
              AngularVelocity(x: event.x, y: event.y, z: event.z);
          var angularVelocityCapture = AngularVelocityReading(
              epochMicroSeconds: Int64(event.timestamp.microsecondsSinceEpoch),
              angularVelocity: angularVelocity);
          currentGeoCaptureHandle!.geoCapture.angularVelocity.readings
              .add(angularVelocityCapture);
        }
      },
      onError: (error) {
        logger.e('Gyroscope Error: $error');
      },
      cancelOnError: true,
    );
    sensors.magnetometerEventStream().listen(
      (sensors.MagnetometerEvent event) {
        if (isRecording) {
          var magneticField = MagneticField(x: event.x, y: event.y, z: event.z);
          var magneticFieldCapture = MagneticFieldReading(
              epochMicroSeconds: Int64(event.timestamp.microsecondsSinceEpoch),
              magneticField: magneticField);
          currentGeoCaptureHandle!.geoCapture.magneticField.readings
              .add(magneticFieldCapture);
        }
      },
      onError: (error) {
        logger.e('Magnetometer Error: $error');
      },
      cancelOnError: true,
    );

    sensors.orientationEventStream().listen(
      (sensors.OrientationEvent event) {
        var orientation =
            Orientation(pitch: event.pitch, roll: event.roll, yaw: event.yaw);
        var orientationReading = OrientationReading(
            epochMicroSeconds: Int64(event.timestamp.microsecondsSinceEpoch),
            orientation: orientation);
        lastOrientationReading = orientationReading;
        if (isRecording) {
          currentGeoCaptureHandle!.geoCapture.orientation.readings
              .add(orientationReading);
        }
      },
      onError: (error) {
        logger.e('Orientation Error: $error');
      },
      cancelOnError: true,
    );
  }
}
