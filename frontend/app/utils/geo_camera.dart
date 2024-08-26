import 'dart:async';

import 'package:camera/camera.dart';
import 'geo_photo_uploader.dart';
import '../models/geo_photo.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:geolocator/geolocator.dart';

class GeoCamera {
  GeoCamera(CameraDescription cameraDescription)
      : cameraController =
            CameraController(cameraDescription, ResolutionPreset.max);

  final CameraController cameraController;

  double currentPitch = 0;
  double currentRoll = 0;
  double currentYaw = 0;
  MotionSensors ms = MotionSensors();
  GeoPhotoUploader uploader = GeoPhotoUploader();
  bool _isTakingPicture = false;
  bool isContiniousUploadEnabled = false;

  void enableContiniousMode() {
    isContiniousUploadEnabled = true;
  }

  void disableContiniousMode() {
    isContiniousUploadEnabled = false;
  }

  void _handlePositionUpdate(Position position) {
    if (isContiniousUploadEnabled && !_isTakingPicture) {
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
    await Geolocator.getCurrentPosition();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(_handlePositionUpdate);

    ms.setSensorUpdateInterval(
        MotionSensors.TYPE_ABSOLUTE_ORIENTATION, 10000000);
    ms.absoluteOrientation.listen((AbsoluteOrientationEvent event) {
      currentPitch = event.pitch;
      currentRoll = event.roll;
      currentYaw = event.yaw;
    });
  }

  Future<CameraController> initialize() async {
    await _loadGeolocator();
    await cameraController.initialize();
    if (!cameraController.value.isInitialized) {
      throw 'Error initializing camera';
    }
    return cameraController;
  }

  void dispose() {
    disableContiniousMode();
    cameraController.dispose();
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
    var position = await Geolocator.getLastKnownPosition();
    var geoPhotoToUpload = GeoPhotoUpload(
      path: image.path,
      latitude: position?.latitude ?? 0,
      longitude: position?.longitude ?? 0,
      pitch: currentPitch,
      roll: currentRoll,
      yaw: currentYaw,
      elevation: position?.altitude ?? 0,
    );
    uploader.registerForUpload(geoPhotoToUpload);
    _isTakingPicture = false;
    logger.i('Registered for upload: ${geoPhotoToUpload.path}');
  }
}
