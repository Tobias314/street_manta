//
//  Generated code. Do not modify.
//  source: protobufs/sensors.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Gps extends $pb.GeneratedMessage {
  factory Gps({
    $fixnum.Int64? time,
    $core.double? longitude,
    $core.double? latitude,
    $core.double? height,
  }) {
    final $result = create();
    if (time != null) {
      $result.time = time;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  Gps._() : super();
  factory Gps.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Gps.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Gps', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'time')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Gps clone() => Gps()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Gps copyWith(void Function(Gps) updates) => super.copyWith((message) => updates(message as Gps)) as Gps;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Gps create() => Gps._();
  Gps createEmptyInstance() => create();
  static $pb.PbList<Gps> createRepeated() => $pb.PbList<Gps>();
  @$core.pragma('dart2js:noInline')
  static Gps getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Gps>(create);
  static Gps? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get time => $_getI64(0);
  @$pb.TagNumber(1)
  set time($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get latitude => $_getN(2);
  @$pb.TagNumber(3)
  set latitude($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLatitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLatitude() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get height => $_getN(3);
  @$pb.TagNumber(4)
  set height($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
}

class Imu extends $pb.GeneratedMessage {
  factory Imu({
    $fixnum.Int64? time,
    $core.double? x,
    $core.double? y,
    $core.double? z,
    $core.double? w,
  }) {
    final $result = create();
    if (time != null) {
      $result.time = time;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    if (w != null) {
      $result.w = w;
    }
    return $result;
  }
  Imu._() : super();
  factory Imu.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Imu.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Imu', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'time')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'w', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Imu clone() => Imu()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Imu copyWith(void Function(Imu) updates) => super.copyWith((message) => updates(message as Imu)) as Imu;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Imu create() => Imu._();
  Imu createEmptyInstance() => create();
  static $pb.PbList<Imu> createRepeated() => $pb.PbList<Imu>();
  @$core.pragma('dart2js:noInline')
  static Imu getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Imu>(create);
  static Imu? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get time => $_getI64(0);
  @$pb.TagNumber(1)
  set time($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get x => $_getN(1);
  @$pb.TagNumber(2)
  set x($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get y => $_getN(2);
  @$pb.TagNumber(3)
  set y($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get z => $_getN(3);
  @$pb.TagNumber(4)
  set z($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasZ() => $_has(3);
  @$pb.TagNumber(4)
  void clearZ() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get w => $_getN(4);
  @$pb.TagNumber(5)
  set w($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasW() => $_has(4);
  @$pb.TagNumber(5)
  void clearW() => clearField(5);
}

class Photo extends $pb.GeneratedMessage {
  factory Photo({
    $fixnum.Int64? time,
    $core.String? name,
  }) {
    final $result = create();
    if (time != null) {
      $result.time = time;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  Photo._() : super();
  factory Photo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Photo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Photo', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'time')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Photo clone() => Photo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Photo copyWith(void Function(Photo) updates) => super.copyWith((message) => updates(message as Photo)) as Photo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Photo create() => Photo._();
  Photo createEmptyInstance() => create();
  static $pb.PbList<Photo> createRepeated() => $pb.PbList<Photo>();
  @$core.pragma('dart2js:noInline')
  static Photo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Photo>(create);
  static Photo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get time => $_getI64(0);
  @$pb.TagNumber(1)
  set time($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class Video extends $pb.GeneratedMessage {
  factory Video({
    $fixnum.Int64? startTime,
    $fixnum.Int64? endTime,
    $fixnum.Int64? fps,
    $core.String? name,
  }) {
    final $result = create();
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (fps != null) {
      $result.fps = fps;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  Video._() : super();
  factory Video.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Video.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Video', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'startTime')
    ..aInt64(2, _omitFieldNames ? '' : 'endTime')
    ..aInt64(3, _omitFieldNames ? '' : 'fps')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Video clone() => Video()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Video copyWith(void Function(Video) updates) => super.copyWith((message) => updates(message as Video)) as Video;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Video create() => Video._();
  Video createEmptyInstance() => create();
  static $pb.PbList<Video> createRepeated() => $pb.PbList<Video>();
  @$core.pragma('dart2js:noInline')
  static Video getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Video>(create);
  static Video? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get startTime => $_getI64(0);
  @$pb.TagNumber(1)
  set startTime($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get endTime => $_getI64(1);
  @$pb.TagNumber(2)
  set endTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get fps => $_getI64(2);
  @$pb.TagNumber(3)
  set fps($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFps() => $_has(2);
  @$pb.TagNumber(3)
  void clearFps() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);
}

class SensorData extends $pb.GeneratedMessage {
  factory SensorData({
    $core.int? verion,
    $core.String? device,
    $core.Iterable<Gps>? gps,
    $core.Iterable<Imu>? imu,
    $core.int? cameraIndex,
    $core.Iterable<Photo>? photos,
    Video? video,
  }) {
    final $result = create();
    if (verion != null) {
      $result.verion = verion;
    }
    if (device != null) {
      $result.device = device;
    }
    if (gps != null) {
      $result.gps.addAll(gps);
    }
    if (imu != null) {
      $result.imu.addAll(imu);
    }
    if (cameraIndex != null) {
      $result.cameraIndex = cameraIndex;
    }
    if (photos != null) {
      $result.photos.addAll(photos);
    }
    if (video != null) {
      $result.video = video;
    }
    return $result;
  }
  SensorData._() : super();
  factory SensorData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SensorData', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'verion', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'device')
    ..pc<Gps>(3, _omitFieldNames ? '' : 'gps', $pb.PbFieldType.PM, subBuilder: Gps.create)
    ..pc<Imu>(4, _omitFieldNames ? '' : 'imu', $pb.PbFieldType.PM, subBuilder: Imu.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'cameraIndex', $pb.PbFieldType.O3)
    ..pc<Photo>(6, _omitFieldNames ? '' : 'photos', $pb.PbFieldType.PM, subBuilder: Photo.create)
    ..aOM<Video>(7, _omitFieldNames ? '' : 'video', subBuilder: Video.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorData clone() => SensorData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorData copyWith(void Function(SensorData) updates) => super.copyWith((message) => updates(message as SensorData)) as SensorData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorData create() => SensorData._();
  SensorData createEmptyInstance() => create();
  static $pb.PbList<SensorData> createRepeated() => $pb.PbList<SensorData>();
  @$core.pragma('dart2js:noInline')
  static SensorData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorData>(create);
  static SensorData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get verion => $_getIZ(0);
  @$pb.TagNumber(1)
  set verion($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVerion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get device => $_getSZ(1);
  @$pb.TagNumber(2)
  set device($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDevice() => $_has(1);
  @$pb.TagNumber(2)
  void clearDevice() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Gps> get gps => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Imu> get imu => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get cameraIndex => $_getIZ(4);
  @$pb.TagNumber(5)
  set cameraIndex($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCameraIndex() => $_has(4);
  @$pb.TagNumber(5)
  void clearCameraIndex() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<Photo> get photos => $_getList(5);

  @$pb.TagNumber(7)
  Video get video => $_getN(6);
  @$pb.TagNumber(7)
  set video(Video v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasVideo() => $_has(6);
  @$pb.TagNumber(7)
  void clearVideo() => clearField(7);
  @$pb.TagNumber(7)
  Video ensureVideo() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
