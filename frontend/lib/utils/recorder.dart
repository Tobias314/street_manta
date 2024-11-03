import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_quick_video_encoder/flutter_quick_video_encoder.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:street_manta_client/utils/device_info.dart';
import 'package:uuid/uuid.dart';
import '../api/capture.dart';
import '../globals.dart';
import 'geo_capture_handle.dart';
import 'video_encoder.dart';
import 'file_uploader.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:geolocator/geolocator.dart';
import '../protobufs/geo_capture.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:path/path.dart' as pathlib;

const double MIN_CAPTURE_DISTANCE_METER = 10.0;

// Future<VideoCapture> videoCaptureFutureFromVideoFileFuture(
//     VideoCapture videoCapture, Future<XFile> videoFileFuture) async {
//   videoCapture.endEpochMicroSeconds =
//       Int64(DateTime.now().microsecondsSinceEpoch);
//   videoCapture.file = (await videoFileFuture).path;
//   return videoCapture;
// }

Logger logger = Logger();

class Recorder {
  Recorder(this.cameraController);

  late Globals globals;

  //GeoCapture
  //GeoCaptureHandle? currentGeoCaptureHandle;
  GeoCapture? currentGeoCapture;
  bool isRecording = false;
  String deviceModel = 'Unknown';
  Timer? continuousUploadTimer;
  FileUploader uploader = FileUploader();
  int currentChunkIndex = 0;
  Queue<Future<void>> chunkQueue = Queue();

  //Camera
  final CameraController cameraController;
  late Directory uploadDirectory;
  bool _isTakingPicture = false;
  bool _isRecordingVideo = false;
  int currentVideoCaptureStartEpochMicroSeconds = 0;
  late FlutterQuickVideoEncoder videoEncoder;
  List<CameraImage> currentVideoFrames = List.empty(growable: true);

  //IMU
  MotionSensors motionSensors = MotionSensors();
  OrientationReading? lastOrientationReading;
  Position? _lastPhotoPosition;

  Future<CameraController> initialize() async {
    uploadDirectory = await uploader.getUploadDirectory();
    globals = await Globals.getInstance();
    await _loadGeolocator();
    await cameraController.initialize();
    deviceModel = await getDeviceModel();
    if (!cameraController.value.isInitialized) {
      throw 'Error initializing camera';
    }
    return cameraController;
  }

  _initNewChunk(){
      logger.d("Initializing new chunk");
      currentVideoCaptureStartEpochMicroSeconds = DateTime.now().microsecondsSinceEpoch;
      currentGeoCapture = GeoCapture();
      currentGeoCapture!.gps.add(GpsCapture());
      currentGeoCapture!.orientation.add(OrientationCapture());
      currentGeoCapture!.acceleration.add(AccelerationCapture());
      currentGeoCapture!.angularVelocity.add(AngularVelocityCapture());
      currentGeoCapture!.magneticField.add(MagneticFieldCapture());
      currentGeoCapture!.chunkIndex = Int64(currentChunkIndex);
      currentVideoFrames = List.empty(growable: true);
  }

  Future<void> startChunkedGeoCapture() async {
    if (!isRecording) {
      currentChunkIndex = 0;
      _initNewChunk();
      continuousUploadTimer = Timer.periodic(
          Duration(
              milliseconds: (globals.geoCaptureChunkLengthSeconds * 1000)
                  .toInt()), (timer) {
        _chunkCurrentGeoCapture();
      });
      //currentGeoCaptureHandle = GeoCaptureHandle();
      cameraController.setExposureMode(ExposureMode.locked);
      await cameraController.startImageStream((cameraImage) {
        logger.d('Adding frame to current video capture');
       currentVideoFrames.add(cameraImage);
      });
      logger.i('Started continuous recording');
    }else{
      logger.i('Cannot start continuous recording, already running!');
    }
    isRecording = true;
  }

  Future<void> stopChunkedGeoCapture() async {
    if (isRecording) {
      continuousUploadTimer!.cancel();
      _chunkCurrentGeoCapture();
      await cameraController.stopImageStream();
      logger.i('Stopped continuous recording');
      for(var chunkFuture in chunkQueue){
        await chunkFuture;
      }
      await uploader.triggerUpload();
    }else{
      logger.i('Cannot stop continuous recording, not running!');
    }
    isRecording = false;
  }

  // Future<GeoCapture> endGeoCapture() async {
  //   if (currentGeoCaptureHandle != null) {
  //     currentGeoCaptureHandle!.queueVideoCaptureFuture(endVideoCapture());
  //     var completeGeoCaptureHandle = currentGeoCaptureHandle;
  //     currentGeoCaptureHandle = null;
  //     return await completeGeoCaptureHandle!.getGeoCapture();
  //   }
  //   return Future.error('Not recording geo capture');
  // }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List? bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value); 
    });
    return bytes!;
}

  Future<void> _writeGeoCaptureChunk(GeoCapture geoCapture, List<CameraImage> videoFrames, String outputFilePath) async {
    logger.d('Writing new GeoCapture chunk...');
    //Encode the video frames and write to the capture
    Directory tempDir = await getTemporaryDirectory();
    String tempVideoPath = pathlib.join(tempDir.path, Uuid().v4());
    logger.d('Encoding video...');
    await encodeVideo(videoFrames, tempVideoPath);
    logger.d('Done encoding video...');
    var videoBytes = await _readFileByte(tempVideoPath);
    geoCapture.videos.add(VideoCapture(format: '.mp4', data: videoBytes));
    //Write the geo capture to a file
    var geoCaptureBytes = geoCapture.writeToBuffer();
    File file = File(outputFilePath);
    await file.writeAsBytes(geoCapture.writeToBuffer());
  }

  void _chunkCurrentGeoCapture() {
    logger.d('Trigger Chunking...');
    if (currentGeoCapture != null) {
      logger.d('Chunking current GeoCapture');
      var geoCaptureToEncode = currentGeoCapture!;
      var videoFramesToEncode = currentVideoFrames;
      currentChunkIndex++;
      _initNewChunk();
      chunkQueue.add(_writeGeoCaptureChunk(geoCaptureToEncode, videoFramesToEncode, pathlib.join(uploadDirectory.path, '${Uuid().v4()}.cap')));
      //String zipFilePath =
      //    pathlib.join(uploadDirectory.path, '${Uuid().v4()}.zip');
      //await zipGeoCapture(await endGeoCapture(), zipFilePath);
     
    }
  }

  // Future<void> _startVideoCapture() async {
  //   if (!isRecordingVideo) {
  //     currentVideoCapture = VideoCapture();
  //     currentVideoCapture!.startEpochMicroSeconds =
  //         Int64(DateTime.now().microsecondsSinceEpoch);
  //     cameraController.setExposureMode(ExposureMode.locked);
  //     cameraController.startImageStream((cameraImage) {
  //       currentVideoFrames.add(cameraImage);
  //     });
  //     await cameraController.startVideoRecording();
  //     logger.i('Started video recording');
  //     isRecordingVideo = true;
  //   } else {
  //     return Future.error('Already recording video');
  //   }
  // }

  // Future<VideoCapture> endVideoCapture() async {
  //   if (isRecordingVideo) {
  //     var videoFile = await cameraController.stopVideoRecording();
  //     logger.i('Stopped video recording');
  //     currentVideoCapture!.endEpochMicroSeconds =
  //         Int64(DateTime.now().microsecondsSinceEpoch);
  //     currentVideoCapture!.file = videoFile.path;
  //     isRecordingVideo = false;
  //     return currentVideoCapture!;
  //   } else {
  //     return Future.error('Not recording video');
  //   }
  // }

  void dispose() {
    stopChunkedGeoCapture();
    cameraController.dispose();
  }

  Future<GeoCapture> takeSinglePhotoCapture() async {
    logger.i('Taking photo capture');
    _isTakingPicture = true;
    final imageFile = await cameraController.takePicture();
    var gpsPositionProto =
        _gpsPositionsToProtobuf(await Geolocator.getCurrentPosition());
    var time = Int64(DateTime.now().microsecondsSinceEpoch);
    _isTakingPicture = false;
    var cameraSpecification =
        CameraSpecification(cameraIndex: cameraController.cameraId);
    //TODO: adapt to new GeoCapture format
    var photoCapture = PhotoCapture(
        epochMicroSeconds: time,
        //file: imageFile.path,
        cameraSpecification: cameraSpecification,
        format: "jpeg",
        data: await imageFile.readAsBytes(),
        gps: GpsReading(epochMicroSeconds: time, position: gpsPositionProto),
        orientation: lastOrientationReading!);
    var capture = GeoCapture();
    capture.photos.add(photoCapture);
    capture.chunkIndex = Int64(0);
    capture.isLastChunk = true;
    logger.i('Done taking single photo capture');
    return capture;
  }

  // Future<void> addPictureToCurrentGeoCapture() async {
  //   _isTakingPicture = true;
  //   var photoCapture = takeSinglePhotoCapture();
  //   if (currentGeoCapture != null) {
  //     currentGeoCapture!.queuePhotoCaptureFuture(photoCapture);
  //   }
  //   _isTakingPicture = false;
  // }

  void _handlePositionUpdate(Position position) {
    if (isRecording) {
      var gpsPosition = GpsPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          elevation: position.altitude);
      var gpsCaptures = GpsReading(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          position: gpsPosition);
      currentGeoCapture!.gps.first.readings.add(gpsCaptures);
    }
    if (_lastPhotoPosition == null) {
      _lastPhotoPosition = position;
    } else {
      var dist = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          _lastPhotoPosition!.latitude,
          _lastPhotoPosition!.longitude);
      if (dist >= MIN_CAPTURE_DISTANCE_METER) {
        if (isRecording && !_isTakingPicture) {
          //TODO: adapt to new GeoCapture format
          //addPictureToCurrentGeoCapture();
          _lastPhotoPosition = position;
        }
      }
    }
  }

  void _handleAbsoluteOrientationEvent(AbsoluteOrientationEvent event) {
    lastOrientationReading = OrientationReading(
        epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
        orientation: Orientation(
            pitch: event.pitch, roll: event.roll, yaw: event.yaw));
    if (isRecording) {
      currentGeoCapture?.orientation.first.readings.add(lastOrientationReading!);
    }
  }

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    if (isRecording) {
      var acceleration = Acceleration(x: event.x, y: event.y, z: event.z);
      var accelerationReading = AccelerationReading(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          acceleration: acceleration);
      currentGeoCapture?.acceleration.first.readings.add(accelerationReading);
    }
  }

  void _handleGyroscopeEvent(GyroscopeEvent event) {
    if (isRecording) {
      var angularVelocity = AngularVelocity(x: event.x, y: event.y, z: event.z);
      var angularVelocityCapture = AngularVelocityReading(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          angularVelocity: angularVelocity);
      currentGeoCapture?.angularVelocity.first.readings
          .add(angularVelocityCapture);
    }
  }

  void _handleMagnetometerEvent(MagnetometerEvent event) {
    if (isRecording) {
      var magneticField = MagneticField(x: event.x, y: event.y, z: event.z);
      var magneticFieldCapture = MagneticFieldReading(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          magneticField: magneticField);
      currentGeoCapture?.magneticField.first.readings
          .add(magneticFieldCapture);
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
  Future<void> _loadGeolocator() async {
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
    _lastPhotoPosition = await Geolocator.getCurrentPosition();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(_handlePositionUpdate);

    motionSensors.setSensorUpdateInterval(
        MotionSensors.TYPE_ABSOLUTE_ORIENTATION, 1000);
    motionSensors.absoluteOrientation.listen(_handleAbsoluteOrientationEvent);
    motionSensors.setSensorUpdateInterval(
        MotionSensors.TYPE_ACCELEROMETER, 1000);
    motionSensors.accelerometer.listen((_handleAccelerometerEvent));
    motionSensors.setSensorUpdateInterval(MotionSensors.TYPE_GYROSCOPE, 1000);
    motionSensors.gyroscope.listen((_handleGyroscopeEvent));
    motionSensors.setSensorUpdateInterval(
        MotionSensors.TYPE_MAGNETIC_FIELD, 1000);
    motionSensors.magnetometer.listen((_handleMagnetometerEvent));
  }
}
