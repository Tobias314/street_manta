

import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter_quick_video_encoder/flutter_quick_video_encoder.dart';
import 'package:mutex/mutex.dart';

final encoderMutex = Mutex();

Future<void> encodeVideo(List<CameraImage> frames, String outputPath, {int width = 1920, int height = 1080, int fps = 60, int videoBitrate = 2500000, int sampleRate = 44100}) async {
    await encoderMutex.acquire();
    await FlutterQuickVideoEncoder.setup(
      width: width,
      height: height,
      fps: fps,
      videoBitrate: videoBitrate,
      audioChannels: 0,
      audioBitrate: 64000,
      sampleRate: sampleRate,
      filepath: outputPath,
      profileLevel: ProfileLevel.any,
    );
    for (var frame in frames) {
      assert(frame.planes.length == 1);
      await FlutterQuickVideoEncoder.appendVideoFrame(frame.planes[0].bytes);
    }
    encoderMutex.release();
}