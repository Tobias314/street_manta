import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../globals.dart';
import '../utils/recorder.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/continuous_capture.dart';
import '../widgets/single_photo.dart';

Logger logger = Logger();

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  late Future<Recorder> recorderFuture;
  //late Future<CameraController> _initializationFuture;
  bool _continuousMode = false;
  @override
  void initState() {
    super.initState();
    recorderFuture = _initializationFuture();
  }

  Future<Recorder> _initializationFuture() async {
    var availableCameraDescriptors = await availableCameras();
    var videoBitrate =
        await Globals.getInstance().then((value) => value.videoBitrate);
    var recorder = Recorder(CameraController(
        availableCameraDescriptors.first, ResolutionPreset.max,
        fps: 10, videoBitrate: videoBitrate));
    await recorder.initialize();
    return recorder;
  }

  @override
  void dispose() {
    // geoCameraFuture.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late var body = FutureBuilder<Recorder>(
        future: recorderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var recorder = snapshot.data!;
            if (!_continuousMode) {
              return SinglePhotoWidget(recorder: recorder);
            } else {
              return AutoPhotoWidget(recorder: recorder);
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
