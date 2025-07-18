import 'dart:convert';

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

class GeoCapturePhoto {
  final String photoId;
  final GeoPosition position;
  final String url;

  GeoCapturePhoto({
    required this.photoId,
    required this.position,
    required this.url,
  });

  static GeoCapturePhoto fromJson(Map<String, dynamic> json) {
    return GeoCapturePhoto(
      photoId: json['photo_id'],
      position: GeoPosition.fromJson(json['position']),
      url: json['url'],
    );
  }
}

class GeoCaptureVideo {
  final String videoId;
  final List<GeoPosition> waypoints;
  final String url;

  GeoCaptureVideo({
    required this.videoId,
    required this.waypoints,
    required this.url,
  });

  static GeoCaptureVideo fromJson(Map<String, dynamic> json) {
    return GeoCaptureVideo(
      videoId: json['video_id'],
      waypoints: (json['waypoints'] as List)
          .map((waypoint) => GeoPosition.fromJson(waypoint))
          .toList(),
      url: json['url'],
    );
  }
}

class GeoCaptureDescriptor {
  final String captureId;
  final GeoPosition bboxMin;
  final GeoPosition bboxMax;
  final List<GeoCapturePhoto> photos;
  final GeoCaptureVideo? video;
  final String description;
  final String? thumbnailUrl;

  GeoPosition get bboxCenter => GeoPosition(
        latitude: (bboxMin.latitude + bboxMax.latitude) / 2,
        longitude: (bboxMin.longitude + bboxMax.longitude) / 2,
        elevation: (bboxMin.elevation + bboxMax.elevation) / 2,
      );

  GeoCaptureDescriptor(
      {required this.captureId,
      required this.bboxMin,
      required this.bboxMax,
      this.photos = const [],
      this.video,
      this.thumbnailUrl,
      this.description = ''});

  static GeoCaptureDescriptor fromJson(String json) {
    return GeoCaptureDescriptor.fromJsonMap(jsonDecode(json));
  }

  static GeoCaptureDescriptor fromJsonMap(Map<String, dynamic> json) {
    return GeoCaptureDescriptor(
      captureId: json['capture_id'],
      bboxMin: GeoPosition.fromJson(json['bbox_min']),
      bboxMax: GeoPosition.fromJson(json['bbox_max']),
      photos: (json['photos'] as List)
          .map((photo) => GeoCapturePhoto.fromJson(photo))
          .toList(),
      video: json['video'] != null
          ? GeoCaptureVideo.fromJson(json['video'])
          : null,
      thumbnailUrl: json['thumbnail_url'],
      description: json['description'] ?? '',
    );
  }
}
