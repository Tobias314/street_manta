import 'dart:convert';
import 'dart:io';
import '../utils/io.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as pathlib;

class GeoPhotoBase {
  final double latitude;
  final double longitude;
  final double elevation;
  final double pitch;
  final double roll;
  final double yaw;
  final String description;

  GeoPhotoBase(
      {required this.latitude,
      required this.longitude,
      required this.elevation,
      required this.pitch,
      required this.roll,
      required this.yaw,
      this.description = ''});

  GeoPhotoBase copyWith(
      {double? latitude,
      double? longitude,
      double? elevation,
      double? pitch,
      double? roll,
      double? yaw,
      String? description}) {
    return GeoPhotoBase(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
      pitch: pitch ?? this.pitch,
      roll: roll ?? this.roll,
      yaw: yaw ?? this.yaw,
      description: description ?? this.description,
    );
  }
}

class GeoPhotoUpload extends GeoPhotoBase {
  String path;

  GeoPhotoUpload(
      {required this.path,
      required super.latitude,
      required super.longitude,
      required super.elevation,
      required super.pitch,
      required super.roll,
      required super.yaw,
      super.description = ''});

  @override
  GeoPhotoUpload copyWith(
      {String? path,
      double? latitude,
      double? longitude,
      double? elevation,
      double? pitch,
      double? roll,
      double? yaw,
      String? description}) {
    return GeoPhotoUpload(
      path: path ?? this.path,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
      pitch: pitch ?? this.pitch,
      roll: roll ?? this.roll,
      yaw: yaw ?? this.yaw,
      description: description ?? this.description,
    );
  }

  String toJson() {
    return jsonEncode({
      'path': path,
      'latitude': latitude,
      'longitude': longitude,
      'elevation': elevation,
      'pitch': pitch,
      'roll': roll,
      'yaw': yaw,
      'description': description,
    });
  }

  static GeoPhotoUpload fromJson(String json) {
    var data = jsonDecode(json);
    return GeoPhotoUpload(
      path: data['path'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      elevation: data['elevation'],
      pitch: data['pitch'],
      roll: data['roll'],
      yaw: data['yaw'],
      description: data['description'],
    );
  }

  Future<void> saveToDirectory(Directory directory, {String? name}) async {
    name ??= const Uuid().v4();
    final jsonFile = File('${directory.path}/$name.json');
    String imagePath = '${directory.path}/$name${pathlib.extension(path)}';
    moveFile(File(path), imagePath);
    path = imagePath;
    await jsonFile.writeAsString(toJson());
  }
}

class GeoPhoto extends GeoPhotoBase {
  final String imageId;

  GeoPhoto(
      {required this.imageId,
      required super.latitude,
      required super.longitude,
      required super.elevation,
      required super.pitch,
      required super.roll,
      required super.yaw,
      super.description = ''});

  @override
  GeoPhoto copyWith(
      {String? imageId,
      double? latitude,
      double? longitude,
      double? elevation,
      double? pitch,
      double? roll,
      double? yaw,
      String? description}) {
    return GeoPhoto(
      imageId: imageId ?? this.imageId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
      pitch: pitch ?? this.pitch,
      roll: roll ?? this.roll,
      yaw: yaw ?? this.yaw,
      description: description ?? this.description,
    );
  }

  static GeoPhoto fromJson(Map<String, dynamic> json) {
    return GeoPhoto(
      imageId: json['image_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      pitch: json['pitch'],
      roll: json['roll'],
      yaw: json['yaw'],
      description: json['description'],
    );
  }
}
