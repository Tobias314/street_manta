

import 'package:street_manta_client/protobufs/geo_capture.pb.dart';

import '../api/capture.dart';

class GeoCaptureHandle {
  late GeoCapture geoCapture;
  bool isOpen = true;

  var photoCaptureFutures = List<Future<PhotoCapture>>.empty(growable: true);
  var VideoCaptureFutures = List<Future<VideoCapture>>.empty(growable: true);

  GeoCaptureHandle() {
    geoCapture = GeoCapture();
  }


  void queuePhotoCaptureFuture(Future<PhotoCapture> future) {
    photoCaptureFutures.add(future);
  }

  void queueVideoCaptureFuture(Future<VideoCapture> future) {
    VideoCaptureFutures.add(future);
  }

  Future<GeoCapture> getGeoCapture() async {
    for (var photCaptureFuture in photoCaptureFutures) {
      var photoCapture = await photCaptureFuture;
      geoCapture.photos.add(photoCapture);
    }
    for (var videoCaptureFuture in VideoCaptureFutures) {
      var videoCapture = await videoCaptureFuture;
      geoCapture.videos.add(videoCapture);
    }
    return geoCapture;
  }

  Future<void> zipToFile(String filePath) async{
    await zipGeoCapture(await getGeoCapture(), filePath);
  }
}