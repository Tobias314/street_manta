import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../utils/recorder.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/auto_photo.dart';
import '../widgets/single_photo.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  late Future<Recorder> geoCameraFuture;
  //late Future<CameraController> _initializationFuture;
  bool _continuousMode = false;
  @override
  void initState() {
    super.initState();
    geoCameraFuture = _initializationFuture();
  }

  Future<Recorder> _initializationFuture() async {
    var availableCameraDescriptors = await availableCameras();
    var geoCamera = Recorder(availableCameraDescriptors.first);
    await geoCamera.initialize();
    return geoCamera;
  }

  @override
  void dispose() {
    // geoCameraFuture.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late var body = FutureBuilder<Recorder>(
        future: geoCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var geoCamera = snapshot.data!;
            if (!_continuousMode) {
              return SinglePhotoWidget(recorder: geoCamera);
            } else {
              return AutoPhotoWidget(geoCamera: geoCamera);
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });

    return Scaffold(
      appBar: AppBar(
        title: Text(
            _continuousMode ? 'Kontinuierliche Aufnahme' : 'Einzelaufnahme'),
      ),
      drawer: MenuDrawer(hide: const {"Aufnahme"}),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Constants.isMobileApp
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _continuousMode = !_continuousMode;
                });
              },
              child: Icon(_continuousMode
                  ? Icons.switch_camera_outlined
                  : Icons.switch_video_outlined),
            )
          : null,
    );
  }
}
