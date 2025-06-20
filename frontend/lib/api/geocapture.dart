import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import '../models/geocapture.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../globals.dart';
import 'authentication.dart';

// Future<String> uploadImage(String imagePath) async {
//   final globals = await Globals.getInstance();
//   var multipartFile = await http.MultipartFile.fromPath(
//     'image',
//     imagePath,
//     contentType: MediaType('image', 'png'),
//   );

//   var request = http.MultipartRequest(
//       "POST", Uri.parse('${globals.backendUrl}/api/geophoto/upload_image'));
//   request.files.add(multipartFile);
//   request.headers['Authorization'] = 'Bearer ${await getUserToken()}';
//   var streamedResponse = await request.send();
//   if (streamedResponse.statusCode != 200) {
//     throw Exception('Failed to upload image');
//   }
//   var imageResponse = await http.Response.fromStream(streamedResponse);
//   return json.decode(imageResponse.body);
// }

// Future<http.Response> uploadGeoPhoto(GeoPhotoUpload geoPhoto,
//     {int maxAttempts = 4, double initialBackoffSeconds = 0.25}) async {
//   final globals = await Globals.getInstance();
//   //var imageId = await uploadImage(geoPhoto.path);
//   Map<String, String> headers = {
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer ${await getUserToken()}',
//   };
//   var body = json.encode({
//     'image_id': imageId,
//     'latitude': geoPhoto.latitude,
//     'longitude': geoPhoto.longitude,
//     'elevation': geoPhoto.elevation,
//     'pitch': geoPhoto.pitch,
//     'roll': geoPhoto.roll,
//     'yaw': geoPhoto.yaw,
//     'description': geoPhoto.description,
//   });
//   http.Response geoPhotoResponse;
//   double backOff = initialBackoffSeconds;
//   int attempt = 0;
//   do {
//     if (attempt > 0) {
//       await Future.delayed(Duration(milliseconds: (backOff * 1000).toInt()));
//       backOff *= 2;
//     }
//     geoPhotoResponse = await http.post(
//       Uri.parse('${globals.backendUrl}/api/geophoto/create/{}'),
//       headers: headers,
//       body: body,
//     );
//     attempt++;
//   } while (geoPhotoResponse.statusCode != 200 && attempt >= maxAttempts);
//   return geoPhotoResponse;
// }

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

Future<Image> fetchImage(String imageUrl) async {
  final globals = await Globals.getInstance();
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'image/png',
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
  // Return the image as a widget
  return Image.memory(imageResponse.bodyBytes);
}
