import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:street_manta_client/utils/device_info.dart';
import 'package:uuid/uuid.dart';
import '../api/capture.dart';
import '../globals.dart';
import 'geo_capture_handle.dart';
import 'zip_uploader.dart';
import '../models/geo_photo.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:geolocator/geolocator.dart';
import '../protobufs/geo_capture.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:path/path.dart' as pathlib;

const double MIN_CAPTURE_DISTANCE_METER = 10.0;

Future<VideoCapture> videoCaptureFutureFromVideoFileFuture(
    VideoCapture videoCapture, Future<XFile> videoFileFuture) async {
  videoCapture.endEpochMicroSeconds =
      Int64(DateTime.now().microsecondsSinceEpoch);
  videoCapture.file = (await videoFileFuture).path;
  return videoCapture;
}

Logger logger = Logger();

class Recorder {
  Recorder(CameraDescription cameraDescription)
      : cameraController =
            CameraController(cameraDescription, ResolutionPreset.max);

  final CameraController cameraController;
  late Directory uploadDirectory;

  double currentPitch = 0;
  double currentRoll = 0;
  double currentYaw = 0;
  Position? _lastPhotoPosition;
  MotionSensors motionSensors = MotionSensors();
  ZipUploader uploader = ZipUploader();
  bool _isTakingPicture = false;
  //bool isContinuousUploadEnabled = false;
  String deviceModel = 'Unknown';
  bool isRecording = false;
  bool isRecordingVideo = false;
  GeoCaptureHandle? currentGeoCaptureHandle;
  VideoCapture? currentVideoCapture;
  late Globals globals;
  Timer? continuousUploadTimer;

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

  Future<void> startContinuousRecording() async {
    if (!isRecording) {
      continuousUploadTimer = Timer.periodic(
          Duration(
              milliseconds: (globals.geoCaptureChunkLengthSeconds * 1000)
                  .toInt()), (timer) {
        _chunkAndZipCurrentGeoCapture(endCapture: false);
      });
      await startGeoCapture();
      logger.i('Started continuous recording');
    }
    isRecording = true;
  }

  Future<void> stopContinuousRecording() async {
    if (isRecording) {
      await _chunkAndZipCurrentGeoCapture(endCapture: true);
      continuousUploadTimer!.cancel();
      logger.i('Stopped continuous recording');
      await uploader.triggerUpload();
    }
    isRecording = false;
  }

  Future<void> startGeoCapture() async {
    currentGeoCaptureHandle = GeoCaptureHandle();
    await startVideoCapture();
  }

  Future<GeoCapture> endGeoCapture() async {
    if (currentGeoCaptureHandle != null) {
      currentGeoCaptureHandle!.queueVideoCaptureFuture(endVideoCapture());
      var completeGeoCaptureHandle = currentGeoCaptureHandle;
      currentGeoCaptureHandle = null;
      return await completeGeoCaptureHandle!.getGeoCapture();
    }
    return Future.error('Not recording geo capture');
  }

  Future<void> _chunkAndZipCurrentGeoCapture({bool endCapture = false}) async {
    logger.i('Chunking and zipping current geo capture');
    String zipFilePath =
        pathlib.join(uploadDirectory.path, '${Uuid().v4()}.zip');
    await zipGeoCapture(await endGeoCapture(), zipFilePath);
    if (!endCapture) {
      startGeoCapture();
    }
  }

  Future<void> startVideoCapture() async {
    if (!isRecordingVideo) {
      currentVideoCapture = VideoCapture();
      currentVideoCapture!.startEpochMicroSeconds =
          Int64(DateTime.now().microsecondsSinceEpoch);
      cameraController.setExposureMode(ExposureMode.locked);
      await cameraController.startVideoRecording();
      logger.i('Started video recording');
      isRecordingVideo = true;
    } else {
      return Future.error('Already recording video');
    }
  }

  Future<VideoCapture> endVideoCapture() async {
    if (isRecordingVideo) {
      var videoFile = await cameraController.stopVideoRecording();
      logger.i('Stopped video recording');
      currentVideoCapture!.endEpochMicroSeconds =
          Int64(DateTime.now().microsecondsSinceEpoch);
      currentVideoCapture!.file = videoFile.path;
      isRecordingVideo = false;
      return currentVideoCapture!;
    } else {
      return Future.error('Not recording video');
    }
  }

  void dispose() {
    stopContinuousRecording();
    cameraController.dispose();
  }

  Future<PhotoCapture> takeSinglePhotoCapture() async {
    logger.i('Taking photo capture');
    _isTakingPicture = true;
    final imageFile = await cameraController.takePicture();
    var gpsPositionProto =
        _gpsPositionsToProtobuf(await Geolocator.getCurrentPosition());
    var orientation =
        Orientation(pitch: currentPitch, roll: currentRoll, yaw: currentYaw);
    var time = Int64(DateTime.now().microsecondsSinceEpoch);
    _isTakingPicture = false;
    var cameraSpecification =
        CameraSpecification(cameraIndex: cameraController.cameraId);
    var photoCapture = PhotoCapture(
        epochMicroSeconds: time,
        file: imageFile.path,
        cameraSpecification: cameraSpecification,
        gpsPosition: gpsPositionProto,
        orientation: orientation);
    logger.i('Done taking photo capture');
    return photoCapture;
  }

  Future<void> addPictureToCurrentGeoCapture() async {
    _isTakingPicture = true;
    var photoCapture = takeSinglePhotoCapture();
    if (currentGeoCaptureHandle != null) {
      currentGeoCaptureHandle!.queuePhotoCaptureFuture(photoCapture);
    }
    _isTakingPicture = false;
  }

  void _handlePositionUpdate(Position position) {
    if (isRecording) {
      var gpsPosition = GpsPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          elevation: position.altitude);
      var gpsCaptures = GpsCapture(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          position: gpsPosition);
      currentGeoCaptureHandle?.geoCapture.gps.add(gpsCaptures);
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
          addPictureToCurrentGeoCapture();
          _lastPhotoPosition = position;
        }
      }
    }
  }

  void _handleAbsoluteOrientationEvent(AbsoluteOrientationEvent event) {
    currentPitch = event.pitch;
    currentRoll = event.roll;
    currentYaw = event.yaw;
    if (isRecording) {
      logger.d("Adding orientation to capture");
      var orientation =
          Orientation(pitch: currentPitch, roll: currentRoll, yaw: currentYaw);
      var orientationCapture = OrientationCapture(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          orientation: orientation);
      currentGeoCaptureHandle?.geoCapture.orientation.add(orientationCapture);
    }
  }

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    if (isRecording) {
      var acceleration = Acceleration(x: event.x, y: event.y, z: event.z);
      var accelerationCapture = AccelerationCapture(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          acceleration: acceleration);
      currentGeoCaptureHandle?.geoCapture.acceleration.add(accelerationCapture);
    }
  }

  void _handleGyroscopeEvent(GyroscopeEvent event) {
    if (isRecording) {
      var angularVelocity = AngularVelocity(x: event.x, y: event.y, z: event.z);
      var angularVelocityCapture = AngularVelocityCapture(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          angularVelocity: angularVelocity);
      currentGeoCaptureHandle?.geoCapture.angularVelocity
          .add(angularVelocityCapture);
    }
  }

  void _handleMagnetometerEvent(MagnetometerEvent event) {
    if (isRecording) {
      var magneticField = MagneticField(x: event.x, y: event.y, z: event.z);
      var magneticFieldCapture = MagneticFieldCapture(
          epochMicroSeconds: Int64(DateTime.now().microsecondsSinceEpoch),
          magneticField: magneticField);
      currentGeoCaptureHandle?.geoCapture.magneticField
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
    motionSensors.setSensorUpdateInterval(MotionSensors.TYPE_MAGNETIC_FIELD, 1000);
    motionSensors.magnetometer.listen((_handleMagnetometerEvent));
  }
}
