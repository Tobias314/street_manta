import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quick_video_encoder/flutter_quick_video_encoder.dart';
import 'package:logger/logger.dart';
import 'package:mutex/mutex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';
import 'package:path/path.dart' as pathlib;
import 'package:uuid/uuid.dart';

import '../api/capture.dart';

Logger logger = Logger();

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

  // void addFrame(CameraImage frame) {
  //   if (frameStartEpoch == null) {
  //     frameStartEpoch = DateTime.now().millisecondsSinceEpoch;
  //   }
  //   frames.add(frame);
  //   frameEndEpoch = DateTime.now().millisecondsSinceEpoch;
  // }

  // Future<void> processFrames() async {
  //   encoderMutex.acquire();
  //   var tempDir = await getTemporaryDirectory();
  //   String videoEncoderTmpPath =
  //       pathlib.join(tempDir.path, '${Uuid().v4()}.mp4');
  //   bool isEncoderInitialized = false;
  //   while (isOpen || frames.isNotEmpty) {
  //     if (frames.isEmpty) {
  //       await Future.delayed(Duration(milliseconds: 100));
  //       continue;
  //     }
  //     var frame = frames.removeFirst();
  //     if (!isEncoderInitialized) {
  //       await FlutterQuickVideoEncoder.setup(
  //         width: frame.width,
  //         height: frame.height,
  //         fps: 30, //TODO: get fps from camera controller
  //         videoBitrate: 1000000,
  //         audioChannels: 0,
  //         audioBitrate: 0,
  //         sampleRate: 0,
  //         filepath: videoEncoderTmpPath,
  //         profileLevel: ProfileLevel.any,
  //       );
  //       isEncoderInitialized = true;
  //     }
  //     assert(frame.planes.length == 3);
  //     assert(frame.format.group == ImageFormatGroup.yuv420);
  //     var y = frame.planes[0].bytes;
  //     int u_v_size = frame.width * frame.height ~/ 4;
  //     //var u = Uint8List(u_v_size);
  //     //var current_plane = frame.planes[1].bytes;
  //     //for (int i = 0; i < u_v_size; i++) {
  //     //  u[i] = current_plane[i * 2];
  //     //}
  //     //var v = Uint8List(u_v_size);
  //     //current_plane = frame.planes[2].bytes;
  //     //for (int i = 0; i < u_v_size; i++) {
  //     //  v[i] = current_plane[i * 2];
  //     //}
  //     await FlutterQuickVideoEncoder.appendVideoFrameYuv420(y, frame.planes[0].bytes, frame.planes[0].bytes);
  //   }
  //   await FlutterQuickVideoEncoder.finish();
  //   encoderMutex.release();
  //   var file = File(videoEncoderTmpPath);
  //   Uint8List bytes = await file.readAsBytes();
  //   geoCapture.videos.add(VideoCapture(
  //       startEpochMicroSeconds: Int64(frameStartEpoch!),
  //       endEpochMicroSeconds: Int64(frameEndEpoch),
  //       format: 'mp4',
  //       data: bytes,
  //       fps: Int64(30)));
  //   await file.delete();
  // }

  Future<GeoCapture> close() async {
    logger.d('Closing GeoCaptureHandle');
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
