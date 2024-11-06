import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quick_video_encoder/flutter_quick_video_encoder.dart';
import 'package:mutex/mutex.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';
import 'package:path/path.dart' as pathlib;
import 'package:uuid/uuid.dart';

import '../api/capture.dart';

final encoderMutex = Mutex();

class GeoCaptureHandle {
  late GeoCapture geoCapture;
  bool isOpen = true;
  Queue<CameraImage> frames = Queue();
  Queue<Future> pendingFutures = Queue();
  int? frameStartEpoch;
  int frameEndEpoch = 0;

  GeoCaptureHandle() {
    geoCapture = GeoCapture();
  }

  void addFrame(CameraImage frame) {
    if (frameStartEpoch == null) {
      frameStartEpoch = DateTime.now().millisecondsSinceEpoch;
    }
    frames.add(frame);
    frameEndEpoch = DateTime.now().millisecondsSinceEpoch;
  }

  Future<void> processFrames() async {
    String videoEncoderTmpPath =
        pathlib.join(Directory.systemTemp.path, '${Uuid().v4()}.mp4');
    bool isEncoderInitialized = false;
    while (isOpen && frames.isNotEmpty) {
      var frame = frames.removeFirst();
      if (!isEncoderInitialized) {
        await FlutterQuickVideoEncoder.setup(
          width: frame.width,
          height: frame.height,
          fps: 30, //TODO: get fps from camera controller
          videoBitrate: 1000000,
          audioChannels: 0,
          audioBitrate: 0,
          sampleRate: 0,
          filepath: videoEncoderTmpPath,
          profileLevel: ProfileLevel.any,
        );
      }
      FlutterQuickVideoEncoder.appendVideoFrame(frame.planes[0].bytes);
    }
    encoderMutex.release();
    var file = File(videoEncoderTmpPath);
    Uint8List bytes = await file.readAsBytes();
    geoCapture.videos.add(VideoCapture(startEpochMicroSeconds: Int64(frameStartEpoch!), endEpochMicroSeconds: Int64(frameEndEpoch), format: 'mp4', data: bytes, fps: Int64(30)));
    await file.delete();
  }

  Future<GeoCapture> close() async {
    isOpen = false;
    while (pendingFutures.isNotEmpty) {
      await pendingFutures.removeFirst();
    }
    return geoCapture;
  }

  // Future<void> zipToFile(String filePath) async{
  //   await zipGeoCapture(await close(), filePath);
  // }
}
