import 'dart:convert';
import 'dart:io';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';

import '../utils/io.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as pathlib;

class GeoPosition {
  final double latitude;
  final double longitude;
  final double elevation;

  GeoPosition({
    required this.latitude,
    required this.longitude,
    required this.elevation,
  });

  GeoPosition copyWith({
    double? latitude,
    double? longitude,
    double? elevation,
  }) {
    return GeoPosition(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
    );
  }

  static GeoPosition fromJson(Map<String, dynamic> json) {
    return GeoPosition(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
    );
  }
}

class GeoCaptureDescriptor {
  final String captureId;
  final GeoPosition bboxMin;
  final GeoPosition bboxMax;
  final List<GeoPosition> positions;
  final List<GeoPosition> waypoints;
  final String description;

  GeoCaptureDescriptor(
      {required this.captureId,
      required this.bboxMin,
      required this.bboxMax,
      this.positions = const [],
      this.waypoints = const [],
      this.description = ''});

  static GeoCaptureDescriptor fromJson(String json) {
    var data = jsonDecode(json);
    return GeoCaptureDescriptor(
      captureId: data['path'],
      bboxMin: GeoPosition.fromJson(data['bbox_min']),
      bboxMax: GeoPosition.fromJson(data['bbox_max']),
      positions: (data['positions'] as List)
          .map((pos) => GeoPosition.fromJson(pos))
          .toList(),
      waypoints: (data['waypoints'] as List)
          .map((pos) => GeoPosition.fromJson(pos))
          .toList(),
      description: data['description'],
    );
  }
}

// class GeoPhotoUpload extends GeoPhotoBase {
//   String path;

//   GeoPhotoUpload(
//       {required this.path,
//       required super.latitude,
//       required super.longitude,
//       required super.elevation,
//       required super.pitch,
//       required super.roll,
//       required super.yaw,
//       super.description = ''});

//   @override
//   GeoPhotoUpload copyWith(
//       {String? path,
//       double? latitude,
//       double? longitude,
//       double? elevation,
//       double? pitch,
//       double? roll,
//       double? yaw,
//       String? description}) {
//     return GeoPhotoUpload(
//       path: path ?? this.path,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       elevation: elevation ?? this.elevation,
//       pitch: pitch ?? this.pitch,
//       roll: roll ?? this.roll,
//       yaw: yaw ?? this.yaw,
//       description: description ?? this.description,
//     );
//   }

//   String toJson() {
//     return jsonEncode({
//       'path': path,
//       'latitude': latitude,
//       'longitude': longitude,
//       'elevation': elevation,
//       'pitch': pitch,
//       'roll': roll,
//       'yaw': yaw,
//       'description': description,
//     });
//   }

//   static GeoPhotoUpload fromJson(String json) {
//     var data = jsonDecode(json);
//     return GeoPhotoUpload(
//       path: data['path'],
//       latitude: data['latitude'],
//       longitude: data['longitude'],
//       elevation: data['elevation'],
//       pitch: data['pitch'],
//       roll: data['roll'],
//       yaw: data['yaw'],
//       description: data['description'],
//     );
//   }

//   Future<void> saveToDirectory(Directory directory, {String? name}) async {
//     name ??= const Uuid().v4();
//     final jsonFile = File('${directory.path}/$name.json');
//     String imagePath = '${directory.path}/$name${pathlib.extension(path)}';
//     moveFile(File(path), imagePath);
//     path = imagePath;
//     await jsonFile.writeAsString(toJson());
//   }
// }

// class GeoPhoto extends GeoPhotoBase {
//   final String captureId;

//   GeoPhoto(
//       {required this.captureId,
//       required super.latitude,
//       required super.longitude,
//       required super.elevation,
//       required super.pitch,
//       required super.roll,
//       required super.yaw,
//       super.description = ''});

//   @override
//   GeoPhoto copyWith(
//       {String? imageId,
//       double? latitude,
//       double? longitude,
//       double? elevation,
//       double? pitch,
//       double? roll,
//       double? yaw,
//       String? description}) {
//     return GeoPhoto(
//       imageId: imageId ?? this.imageId,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       elevation: elevation ?? this.elevation,
//       pitch: pitch ?? this.pitch,
//       roll: roll ?? this.roll,
//       yaw: yaw ?? this.yaw,
//       description: description ?? this.description,
//     );
//   }

//   static GeoPhoto fromJson(Map<String, dynamic> json) {
//     return GeoPhoto(
//       imageId: json['image_id'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       elevation: json['elevation'],
//       pitch: json['pitch'],
//       roll: json['roll'],
//       yaw: json['yaw'],
//       description: json['description'],
//     );
//   }
// }
