

import 'package:camera/camera.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';

import '../api/capture.dart';

class GeoCaptureHandle {
  late GeoCapture geoCapture;
  bool isOpen = true;
  Map<String, List<CameraImage>> frames = {};

  GeoCaptureHandle() {
    geoCapture = GeoCapture();
  }

  void addFrame(CameraImage frame, String identifier) {
    List<CameraImage> framesList;
    if (!frames.containsKey(identifier)) {
      framesList = List.empty(growable: true);
      frames[identifier] = framesList;
    } else {
      framesList = frames[identifier]!;
    }
    framesList.add(frame);
  }

  Future<GeoCapture> close() async {
    isOpen = false;
    for (var entry in frames.entries) {
      var identifier = entry.key;
      var framesList = entry.value;

    }
    return geoCapture;
  }

  // Future<void> zipToFile(String filePath) async{
  //   await zipGeoCapture(await close(), filePath);
  // }
}