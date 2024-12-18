import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:street_manta_client/utils/file_uploader.dart';
import 'package:street_manta_client/utils/recorder.dart';
import 'package:logger/logger.dart';

import '../globals.dart';
import '../widgets/footer.dart';


Logger logger = Logger();


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //final TextEditingController _serverUrlController = TextEditingController();
  bool waitingForApiCall = false;

  final Future<Globals> _globalsFuture = Globals.getInstance();
  late Globals globals;
  int filesQueuedForUpload = 0;
  bool imuCalibrationRunning = false;
  String imuCalibrationButtonText = 'Start IMU Calibration';

  @override
  void initState() {
    super.initState();
    FileUploader().registerCallback(widget, () {
      setState(() {
        filesQueuedForUpload = FileUploader().filesQueuedForUpload.length;
      });
    });
    FileUploader().reloadListOfQueuedFiles();
  }

  @override
  void dispose() {
    //_serverUrlController.dispose();
    FileUploader().unregisterCallback(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<Globals>(
            future: _globalsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                globals = snapshot.data!;
                return Column(children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 500, maxWidth: 1000),
                    child: Column(
                      children: [
                        //const Padding(
                        //    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        //    child: Text('Einstellungen',
                        //        style: TextStyle(fontSize: 40))),
                        TextField(
                          controller:
                              TextEditingController(text: globals.backendUrl),
                          decoration: const InputDecoration(
                            labelText: 'Server URL',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.computer),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (text) =>
                              globals.backendUrl = text.trim(),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: TextEditingController(
                              text: globals.videoExposureOffset.toString()),
                          decoration: const InputDecoration(
                            labelText: 'Video Exposure Offset (EV)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.video_camera_back_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (text) =>
                              globals.videoExposureOffset = double.parse(
                            text.trim(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: TextEditingController(
                              text: globals.videoFps.toString()),
                          decoration: const InputDecoration(
                            labelText: 'Video FPS',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.video_camera_back_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSubmitted: (text) => globals.videoFps = int.parse(
                            text.trim(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: TextEditingController(
                              text: globals.videoBitrate.toString()),
                          decoration: const InputDecoration(
                            labelText: 'Video Bitrate',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.video_camera_back_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSubmitted: (text) =>
                              globals.videoBitrate = int.parse(
                            text.trim(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: Text(
                              'Anzahl Dateien in Uploadwarteschlange: $filesQueuedForUpload'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FileUploader().triggerUpload();
                          },
                          child: const Text('Trigger Upload'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if(!imuCalibrationRunning) {
                                return imuCalibration;
                              }else{
                                return null;
                              }
                            }(),
                            child: Text(imuCalibrationButtonText)),
                      ],
                    ),
                  )),
                  const StandardPageFooter()
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }

  Future<void> imuCalibration() async {
    setState(() {
      imuCalibrationRunning = true;
    });
    var recorder = Recorder();
    await recorder.initializeWithoutCamera();
    int secondsRemaining = Globals.IMU_CALIBRATION_LENGTH_SECONDS.toInt();
    await recorder.startGeoCapture(Globals.IMU_CALIBRATION_CHUNK_LENGTH_SECONDS);
    logger.i('Started IMU Calibration');
    var timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsRemaining -= 1;
      logger.i('IMU Calibration in Progress: $secondsRemaining');
      setState(() {
        imuCalibrationButtonText =
            'IMU Calibration in Progress: ${secondsRemaining}s remaining';
      });
    });
    await Future.delayed(
        Duration(seconds: Globals.IMU_CALIBRATION_LENGTH_SECONDS.toInt()));
    timer.cancel();
    recorder.stopGeoCapture();
    logger.i('Done IMU Calibration');
    setState(() {
      imuCalibrationRunning = false;
      imuCalibrationButtonText = 'Start IMU Calibration';
    });
  }
}
