import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';
import 'package:uuid/uuid.dart';
import '../models/geo_photo.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../globals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'authentication.dart';

Future<void> zipGeoCapture(GeoCapture geoCapture, String outputFilePath) async {
  var paths = List<String>.empty(growable: true);
  for (var photoCapture in geoCapture.photos) {
    paths.add(photoCapture.file);
  }
  for (var videoCapture in geoCapture.videos) {
    paths.add(videoCapture.file);
  }

  Directory tempDir = await (await getTemporaryDirectory()).createTemp();
  Directory inputDir = await Directory(tempDir.path + '/input').create();
  var zipPaths = List<String>.empty(growable: true);
  for (var path in paths) {
    zipPaths.add(
        (await File(path).rename(inputDir.path + '/' + basename(path))).path);
  }
  File file = File(inputDir.path + '/geo_capture.pb');
  file.writeAsBytes(geoCapture.writeToBuffer());
  zipPaths.add(file.path);

  var zipFile = File(tempDir.path + '/geo_capture.zip');
  await ZipFile.createFromFiles(
      sourceDir: inputDir,
      files: zipPaths.map((path) => File(path)).toList(),
      zipFile: zipFile);
  await zipFile.rename(outputFilePath);
}

Future<http.Response> uploadGeoCapture(GeoCapture geoCapture,
    {int maxAttempts = 4, double initialBackoffSeconds = 0.25}) async {
  String zipFilePath = p.join((await getTemporaryDirectory()).path, Uuid().v4());
  await zipGeoCapture(geoCapture, zipFilePath);
  return await uploadGeoCaptureZip(zipFilePath, maxAttempts: maxAttempts, initialBackoffSeconds: initialBackoffSeconds);
}

Future<http.Response> uploadGeoCaptureZip(String geoCaptureZipFilePath,
    {int maxAttempts = 4, double initialBackoffSeconds = 0.25}) async {
  http.Response geoCaptureResponse;
  double backOff = initialBackoffSeconds;
  int attempt = 0;
  final globals = await Globals.getInstance();

  do {
    if (attempt > 0) {
      await Future.delayed(Duration(milliseconds: (backOff * 1000).toInt()));
      backOff *= 2;
    }
    var multipartFile = await http.MultipartFile.fromPath(
      'geo_capture',
      geoCaptureZipFilePath,
      contentType: MediaType('application', 'zip'),
    );

    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            '${globals.backendUrl}/api/geo_capture/upload/${Uuid().v4()}'));
    request.files.add(multipartFile);
    request.headers['Authorization'] = 'Bearer ${await getUserToken()}';
    var streamedResponse = await request.send();
    geoCaptureResponse = await http.Response.fromStream(streamedResponse);
  } while (geoCaptureResponse.statusCode != 200 && attempt >= maxAttempts);
  return geoCaptureResponse;
}
