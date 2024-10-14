import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:logger/logger.dart';
import 'package:street_manta_client/utils/device_info.dart';
import 'package:uuid/uuid.dart';
import '../api/capture.dart';
import 'geo_capture_handle.dart';
import 'geo_photo_uploader.dart';
import '../models/geo_photo.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:geolocator/geolocator.dart';
import '../protobufs/geo_capture.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:path/path.dart' as pathlib;

const double MIN_CAPTURE_DISTANCE_METER = 10.0;

Future<VideoCapture> videoCaptureFutureFromVideoFileFuture(VideoCapture videoCapture, Future<XFile> videoFileFuture) async{
  videoCapture.endEpochMicroSeconds = Int64(DateTime.now().microsecondsSinceEpoch);
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
  Position? _last_updated_position;
  MotionSensors motionSensors = MotionSensors();
  ZipUploader uploader = ZipUploader();
  bool _isTakingPicture = false;
  bool isContinuousUploadEnabled = false;
  String deviceModel = 'Unknown';
  bool isRecording = false;
  bool isRecordingVideo = false;
  GeoCaptureHandle? currentGeoCaptureHandle;
  VideoCapture? currentVideoCapture;

  Future<CameraController> initialize() async {
    uploadDirectory = await uploader.getUploadDirectory();
    await _loadGeolocator();
    await cameraController.initialize();
    deviceModel = await getDeviceModel();
    if (!cameraController.value.isInitialized) {
      throw 'Error initializing camera';
    }
    return cameraController;
  }

  Future<void> startContinuousRecording() async{
    if(!isRecording){
      await startGeoCapture();
    }
    isRecording = true;
  }

  Future<void> stopContinuousRecording() async{
    if(isRecording){
      await _chunkAndZipCurrentGeoCapture(endCapture: true);
    }
    isRecording = false;
  }

  Future<void> startGeoCapture()async{
    currentGeoCaptureHandle = GeoCaptureHandle();
    await startVideoCapture();
  }

  Future<GeoCapture> endGeoCapture() async{
    if(currentGeoCaptureHandle != null){
      currentGeoCaptureHandle!.queueVideoCaptureFuture(endVideoCapture());
      var completeGeoCaptureHandle = currentGeoCaptureHandle;
      currentGeoCaptureHandle = null;
      return await completeGeoCaptureHandle!.getGeoCapture();
    }
    return Future.error('Not recording geo capture');
  }

  Future<void> _chunkAndZipCurrentGeoCapture({bool endCapture = false}) async{
    String zipFilePath = pathlib.join(uploadDirectory.path, Uuid().v4() + '.zip');
    await zipGeoCapture(await endGeoCapture(), zipFilePath);
    if(!endCapture){
      startGeoCapture();
    }
  }

  Future<void> startVideoCapture()async{
    if(!isRecordingVideo){
      currentVideoCapture = VideoCapture();
      currentVideoCapture!.startEpochMicroSeconds = Int64(DateTime.now().microsecondsSinceEpoch);
      await cameraController.startVideoRecording();
    }
    isRecordingVideo = true;
  }

  Future<VideoCapture> endVideoCapture() async{
    if(isRecordingVideo){
      var videoFile = await  cameraController.stopVideoRecording();
      currentVideoCapture!.endEpochMicroSeconds = Int64(DateTime.now().microsecondsSinceEpoch);
      currentVideoCapture!.file = videoFile.path;
    }
    isRecordingVideo = false;
    return Future.error('Not recording video');
  }



  void enableContiniousMode() {
    isContinuousUploadEnabled = true;
  }

  void disableContiniousMode() {
    isContinuousUploadEnabled = false;
  }

  void _handlePositionUpdate(Position position) {
    if (_last_updated_position == null) {
      _last_updated_position = position;
    } else {
      var dist = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          _last_updated_position!.latitude,
          _last_updated_position!.longitude);
      if (dist < MIN_CAPTURE_DISTANCE_METER) {
        return;
      }
      _last_updated_position = position;
    }
    if (isContinuousUploadEnabled && !_isTakingPicture) {
      takePictureRegisterForUpload();
    }
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
    _last_updated_position = await Geolocator.getCurrentPosition();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(_handlePositionUpdate);

    motionSensors.setSensorUpdateInterval(
        MotionSensors.TYPE_ABSOLUTE_ORIENTATION, 10000000);
    motionSensors.absoluteOrientation.listen((AbsoluteOrientationEvent event) {
      currentPitch = event.pitch;
      currentRoll = event.roll;
      currentYaw = event.yaw;
    });
  }

  void dispose() {
    disableContiniousMode();
    cameraController.dispose();
  }

  Future<PhotoCapture> takeSinglePhotoCapture() async {
    _isTakingPicture = true;
    final imageFile = await cameraController.takePicture();
    var gpsPosition = await Geolocator.getCurrentPosition();
    var gpsPositionProto = GpsPosition(latitude: gpsPosition.latitude, longitude: gpsPosition.longitude, elevation: gpsPosition.altitude);
    var orientation = Orientation(pitch: currentPitch, roll: currentRoll, yaw: currentYaw);
    var time = Int64(DateTime.now().microsecondsSinceEpoch);
    _isTakingPicture = false;
    var cameraSpecification = CameraSpecification(cameraIndex: cameraController.cameraId);
    var photoCapture = PhotoCapture(epochMicroSeconds: time, file: imageFile.path, cameraSpecification: cameraSpecification, gpsPosition: gpsPositionProto, orientation: orientation);
    return photoCapture;
  }

  Future<GeoPhotoUpload> takePicture() async {
    _isTakingPicture = true;
    final image = await cameraController.takePicture();
    var position = await Geolocator.getLastKnownPosition();
    _isTakingPicture = false;
    return GeoPhotoUpload(
      path: image.path,
      latitude: position?.latitude ?? 0,
      longitude: position?.longitude ?? 0,
      pitch: currentPitch,
      roll: currentRoll,
      yaw: currentYaw,
      elevation: position?.altitude ?? 0,
    );
  }

  Future<void> takePictureRegisterForUpload() async {
    _isTakingPicture = true;
    final image = await cameraController.takePicture();
    var position = _last_updated_position;
    if (position == null) {
      return;
    }
    logger.i(
        'Taking picture for upload at position: ${position.latitude}, ${position.longitude}');
    var geoPhotoToUpload = GeoPhotoUpload(
      path: image.path,
      latitude: position.latitude ?? 0,
      longitude: position.longitude ?? 0,
      pitch: currentPitch,
      roll: currentRoll,
      yaw: currentYaw,
      elevation: position.altitude ?? 0,
    );
    uploader.queueForUpload(geoPhotoToUpload);
    _isTakingPicture = false;
    logger.i('Registered for upload: ${geoPhotoToUpload.path}');
  }
}
