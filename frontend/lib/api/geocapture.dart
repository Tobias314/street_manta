import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:universal_html/html.dart' as html;
import '../models/geocapture.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import 'authentication.dart';
import 'package:universal_html/html.dart';

Future<List<GeoCaptureDescriptor>> fetchGeoCapturesForRegion(
    LatLngBounds bounds) async {
  final globals = await Globals.getInstance();
  String route =
      '/api/geocaptures_for_region/${bounds.south},${bounds.west},${bounds.north},${bounds.east}';
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${await getUserToken()}',
  };
  var geoPhotoResponse = await http.get(
    Uri.parse(globals.backendUrl + route),
    headers: headers,
  );
  if (geoPhotoResponse.statusCode == 200) {
    var geoCapturesJson = json.decode(geoPhotoResponse.body) as List;
    return geoCapturesJson.map((geoCaptureJson) {
      return GeoCaptureDescriptor.fromJsonMap(geoCaptureJson);
    }).toList();
  } else {
    throw Exception('Failed to load geo photos');
  }
}

Future<Uint8List> fetchImageBytes(String imageUrl) async {
  final globals = await Globals.getInstance();
  Map<String, String> headers = {
    'Authorization': 'Bearer ${await getUserToken()}',
  };
  Uri uri = Uri.parse(imageUrl);
  var imageResponse = await http.get(
    uri,
    headers: headers,
  );
  if (imageResponse.statusCode != 200) {
    throw Exception('Failed to load image from $imageUrl');
  }
  // Return the image bytes
  return imageResponse.bodyBytes;
}

Future<Image> fetchImage(String imageUrl) async {
  var imageBytes = await fetchImageBytes(imageUrl);
  return Image.memory(imageBytes);
}

Future<void> downloadGeoCapture(String captureId) async {
  final globals = await Globals.getInstance();
  String userToken = await getUserToken();
  String route = '/api/geocaptures/$captureId/download';
  var uri = globals.backendUrl + route;

  var headers = {'Authorization': 'Bearer $userToken'};

  if (kIsWeb) {
    // For web, we use Dio to download the file and create a Blob for download
    // var dio = Dio();
    // var response = await dio.download(uri, '${captureId}.zip',
    //     options: Options(headers: headers));
    html.AnchorElement anchorElement =
        new html.AnchorElement(href: uri + '?user_token=' + userToken);
    anchorElement.download = uri;
    html.document.body?.append(anchorElement);
    anchorElement.click();
    anchorElement.remove();
  } else {
    if (!FlutterDownloader.initialized) {
      await FlutterDownloader.initialize(
          debug:
              true, // optional: set to false to disable printing logs to console (default: true)
          ignoreSsl:
              true // option: set to false to disable working with http links (default: false)
          );
    }
    await FlutterDownloader.enqueue(
        url: uri,
        savedDir: '/sdcard/download',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
        headers: headers);
  }
}
