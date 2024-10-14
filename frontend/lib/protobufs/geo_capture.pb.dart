//
//  Generated code. Do not modify.
//  source: protobufs/geo_capture.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class GpsPosition extends $pb.GeneratedMessage {
  factory GpsPosition({
    $core.double? longitude,
    $core.double? latitude,
    $core.double? elevation,
  }) {
    final $result = create();
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (elevation != null) {
      $result.elevation = elevation;
    }
    return $result;
  }
  GpsPosition._() : super();
  factory GpsPosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GpsPosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsPosition', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'elevation', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GpsPosition clone() => GpsPosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GpsPosition copyWith(void Function(GpsPosition) updates) => super.copyWith((message) => updates(message as GpsPosition)) as GpsPosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsPosition create() => GpsPosition._();
  GpsPosition createEmptyInstance() => create();
  static $pb.PbList<GpsPosition> createRepeated() => $pb.PbList<GpsPosition>();
  @$core.pragma('dart2js:noInline')
  static GpsPosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsPosition>(create);
  static GpsPosition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get longitude => $_getN(0);
  @$pb.TagNumber(1)
  set longitude($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLongitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLongitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get latitude => $_getN(1);
  @$pb.TagNumber(2)
  set latitude($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get elevation => $_getN(2);
  @$pb.TagNumber(3)
  set elevation($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasElevation() => $_has(2);
  @$pb.TagNumber(3)
  void clearElevation() => clearField(3);
}

class Orientation extends $pb.GeneratedMessage {
  factory Orientation({
    $core.double? roll,
    $core.double? pitch,
    $core.double? yaw,
  }) {
    final $result = create();
    if (roll != null) {
      $result.roll = roll;
    }
    if (pitch != null) {
      $result.pitch = pitch;
    }
    if (yaw != null) {
      $result.yaw = yaw;
    }
    return $result;
  }
  Orientation._() : super();
  factory Orientation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Orientation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Orientation', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'roll', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'pitch', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'yaw', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Orientation clone() => Orientation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Orientation copyWith(void Function(Orientation) updates) => super.copyWith((message) => updates(message as Orientation)) as Orientation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Orientation create() => Orientation._();
  Orientation createEmptyInstance() => create();
  static $pb.PbList<Orientation> createRepeated() => $pb.PbList<Orientation>();
  @$core.pragma('dart2js:noInline')
  static Orientation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Orientation>(create);
  static Orientation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get roll => $_getN(0);
  @$pb.TagNumber(1)
  set roll($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoll() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoll() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get pitch => $_getN(1);
  @$pb.TagNumber(2)
  set pitch($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPitch() => $_has(1);
  @$pb.TagNumber(2)
  void clearPitch() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get yaw => $_getN(2);
  @$pb.TagNumber(3)
  set yaw($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasYaw() => $_has(2);
  @$pb.TagNumber(3)
  void clearYaw() => clearField(3);
}

class GpsCapture extends $pb.GeneratedMessage {
  factory GpsCapture({
    $fixnum.Int64? epochMicroSeconds,
    GpsPosition? position,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  GpsCapture._() : super();
  factory GpsCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GpsCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<GpsPosition>(2, _omitFieldNames ? '' : 'position', subBuilder: GpsPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GpsCapture clone() => GpsCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GpsCapture copyWith(void Function(GpsCapture) updates) => super.copyWith((message) => updates(message as GpsCapture)) as GpsCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsCapture create() => GpsCapture._();
  GpsCapture createEmptyInstance() => create();
  static $pb.PbList<GpsCapture> createRepeated() => $pb.PbList<GpsCapture>();
  @$core.pragma('dart2js:noInline')
  static GpsCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsCapture>(create);
  static GpsCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  GpsPosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(GpsPosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  GpsPosition ensurePosition() => $_ensure(1);
}

class ImuCapture extends $pb.GeneratedMessage {
  factory ImuCapture({
    $fixnum.Int64? epochMicroSeconds,
    $core.double? x,
    $core.double? y,
    $core.double? z,
    $core.double? w,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
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
  ImuCapture._() : super();
  factory ImuCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImuCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImuCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
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
  ImuCapture clone() => ImuCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImuCapture copyWith(void Function(ImuCapture) updates) => super.copyWith((message) => updates(message as ImuCapture)) as ImuCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImuCapture create() => ImuCapture._();
  ImuCapture createEmptyInstance() => create();
  static $pb.PbList<ImuCapture> createRepeated() => $pb.PbList<ImuCapture>();
  @$core.pragma('dart2js:noInline')
  static ImuCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImuCapture>(create);
  static ImuCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

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

class CameraSpecification extends $pb.GeneratedMessage {
  factory CameraSpecification({
    $core.int? cameraIndex,
    $core.double? focalLength,
    $core.double? exposureTime,
  }) {
    final $result = create();
    if (cameraIndex != null) {
      $result.cameraIndex = cameraIndex;
    }
    if (focalLength != null) {
      $result.focalLength = focalLength;
    }
    if (exposureTime != null) {
      $result.exposureTime = exposureTime;
    }
    return $result;
  }
  CameraSpecification._() : super();
  factory CameraSpecification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraSpecification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CameraSpecification', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'cameraIndex', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'focalLength', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'exposureTime', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraSpecification clone() => CameraSpecification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraSpecification copyWith(void Function(CameraSpecification) updates) => super.copyWith((message) => updates(message as CameraSpecification)) as CameraSpecification;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CameraSpecification create() => CameraSpecification._();
  CameraSpecification createEmptyInstance() => create();
  static $pb.PbList<CameraSpecification> createRepeated() => $pb.PbList<CameraSpecification>();
  @$core.pragma('dart2js:noInline')
  static CameraSpecification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraSpecification>(create);
  static CameraSpecification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get cameraIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set cameraIndex($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCameraIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearCameraIndex() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get focalLength => $_getN(1);
  @$pb.TagNumber(2)
  set focalLength($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFocalLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearFocalLength() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get exposureTime => $_getN(2);
  @$pb.TagNumber(3)
  set exposureTime($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExposureTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearExposureTime() => clearField(3);
}

class PhotoCapture extends $pb.GeneratedMessage {
  factory PhotoCapture({
    $fixnum.Int64? epochMicroSeconds,
    $core.String? file,
    CameraSpecification? cameraSpecification,
    GpsPosition? gpsPosition,
    Orientation? orientation,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (file != null) {
      $result.file = file;
    }
    if (cameraSpecification != null) {
      $result.cameraSpecification = cameraSpecification;
    }
    if (gpsPosition != null) {
      $result.gpsPosition = gpsPosition;
    }
    if (orientation != null) {
      $result.orientation = orientation;
    }
    return $result;
  }
  PhotoCapture._() : super();
  factory PhotoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PhotoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PhotoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOS(2, _omitFieldNames ? '' : 'file')
    ..aOM<CameraSpecification>(3, _omitFieldNames ? '' : 'cameraSpecification', subBuilder: CameraSpecification.create)
    ..aOM<GpsPosition>(4, _omitFieldNames ? '' : 'gpsPosition', subBuilder: GpsPosition.create)
    ..aOM<Orientation>(5, _omitFieldNames ? '' : 'orientation', subBuilder: Orientation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PhotoCapture clone() => PhotoCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PhotoCapture copyWith(void Function(PhotoCapture) updates) => super.copyWith((message) => updates(message as PhotoCapture)) as PhotoCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhotoCapture create() => PhotoCapture._();
  PhotoCapture createEmptyInstance() => create();
  static $pb.PbList<PhotoCapture> createRepeated() => $pb.PbList<PhotoCapture>();
  @$core.pragma('dart2js:noInline')
  static PhotoCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoCapture>(create);
  static PhotoCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get file => $_getSZ(1);
  @$pb.TagNumber(2)
  set file($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearFile() => clearField(2);

  @$pb.TagNumber(3)
  CameraSpecification get cameraSpecification => $_getN(2);
  @$pb.TagNumber(3)
  set cameraSpecification(CameraSpecification v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCameraSpecification() => $_has(2);
  @$pb.TagNumber(3)
  void clearCameraSpecification() => clearField(3);
  @$pb.TagNumber(3)
  CameraSpecification ensureCameraSpecification() => $_ensure(2);

  @$pb.TagNumber(4)
  GpsPosition get gpsPosition => $_getN(3);
  @$pb.TagNumber(4)
  set gpsPosition(GpsPosition v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGpsPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearGpsPosition() => clearField(4);
  @$pb.TagNumber(4)
  GpsPosition ensureGpsPosition() => $_ensure(3);

  @$pb.TagNumber(5)
  Orientation get orientation => $_getN(4);
  @$pb.TagNumber(5)
  set orientation(Orientation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrientation() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrientation() => clearField(5);
  @$pb.TagNumber(5)
  Orientation ensureOrientation() => $_ensure(4);
}

class VideoCapture extends $pb.GeneratedMessage {
  factory VideoCapture({
    $fixnum.Int64? startEpochMicroSeconds,
    $fixnum.Int64? endEpochMicroSeconds,
    $core.String? file,
    $fixnum.Int64? fps,
    CameraSpecification? cameraSpecification,
  }) {
    final $result = create();
    if (startEpochMicroSeconds != null) {
      $result.startEpochMicroSeconds = startEpochMicroSeconds;
    }
    if (endEpochMicroSeconds != null) {
      $result.endEpochMicroSeconds = endEpochMicroSeconds;
    }
    if (file != null) {
      $result.file = file;
    }
    if (fps != null) {
      $result.fps = fps;
    }
    if (cameraSpecification != null) {
      $result.cameraSpecification = cameraSpecification;
    }
    return $result;
  }
  VideoCapture._() : super();
  factory VideoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'startEpochMicroSeconds')
    ..aInt64(2, _omitFieldNames ? '' : 'endEpochMicroSeconds')
    ..aOS(3, _omitFieldNames ? '' : 'file')
    ..aInt64(4, _omitFieldNames ? '' : 'fps')
    ..aOM<CameraSpecification>(5, _omitFieldNames ? '' : 'cameraSpecification', subBuilder: CameraSpecification.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoCapture clone() => VideoCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoCapture copyWith(void Function(VideoCapture) updates) => super.copyWith((message) => updates(message as VideoCapture)) as VideoCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoCapture create() => VideoCapture._();
  VideoCapture createEmptyInstance() => create();
  static $pb.PbList<VideoCapture> createRepeated() => $pb.PbList<VideoCapture>();
  @$core.pragma('dart2js:noInline')
  static VideoCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoCapture>(create);
  static VideoCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get startEpochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set startEpochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get endEpochMicroSeconds => $_getI64(1);
  @$pb.TagNumber(2)
  set endEpochMicroSeconds($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndEpochMicroSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndEpochMicroSeconds() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get file => $_getSZ(2);
  @$pb.TagNumber(3)
  set file($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFile() => $_has(2);
  @$pb.TagNumber(3)
  void clearFile() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get fps => $_getI64(3);
  @$pb.TagNumber(4)
  set fps($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFps() => $_has(3);
  @$pb.TagNumber(4)
  void clearFps() => clearField(4);

  @$pb.TagNumber(5)
  CameraSpecification get cameraSpecification => $_getN(4);
  @$pb.TagNumber(5)
  set cameraSpecification(CameraSpecification v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCameraSpecification() => $_has(4);
  @$pb.TagNumber(5)
  void clearCameraSpecification() => clearField(5);
  @$pb.TagNumber(5)
  CameraSpecification ensureCameraSpecification() => $_ensure(4);
}

class GeoCapture extends $pb.GeneratedMessage {
  factory GeoCapture({
    $core.String? device,
    $core.Iterable<GpsCapture>? gps,
    $core.Iterable<ImuCapture>? imu,
    $core.Iterable<PhotoCapture>? photos,
    $core.Iterable<VideoCapture>? videos,
    $core.String? description,
    $core.Iterable<$core.String>? tags,
  }) {
    final $result = create();
    if (device != null) {
      $result.device = device;
    }
    if (gps != null) {
      $result.gps.addAll(gps);
    }
    if (imu != null) {
      $result.imu.addAll(imu);
    }
    if (photos != null) {
      $result.photos.addAll(photos);
    }
    if (videos != null) {
      $result.videos.addAll(videos);
    }
    if (description != null) {
      $result.description = description;
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    return $result;
  }
  GeoCapture._() : super();
  factory GeoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GeoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'device')
    ..pc<GpsCapture>(2, _omitFieldNames ? '' : 'gps', $pb.PbFieldType.PM, subBuilder: GpsCapture.create)
    ..pc<ImuCapture>(3, _omitFieldNames ? '' : 'imu', $pb.PbFieldType.PM, subBuilder: ImuCapture.create)
    ..pc<PhotoCapture>(4, _omitFieldNames ? '' : 'photos', $pb.PbFieldType.PM, subBuilder: PhotoCapture.create)
    ..pc<VideoCapture>(5, _omitFieldNames ? '' : 'videos', $pb.PbFieldType.PM, subBuilder: VideoCapture.create)
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..pPS(7, _omitFieldNames ? '' : 'tags')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeoCapture clone() => GeoCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeoCapture copyWith(void Function(GeoCapture) updates) => super.copyWith((message) => updates(message as GeoCapture)) as GeoCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeoCapture create() => GeoCapture._();
  GeoCapture createEmptyInstance() => create();
  static $pb.PbList<GeoCapture> createRepeated() => $pb.PbList<GeoCapture>();
  @$core.pragma('dart2js:noInline')
  static GeoCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeoCapture>(create);
  static GeoCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get device => $_getSZ(0);
  @$pb.TagNumber(1)
  set device($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDevice() => $_has(0);
  @$pb.TagNumber(1)
  void clearDevice() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<GpsCapture> get gps => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<ImuCapture> get imu => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<PhotoCapture> get photos => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<VideoCapture> get videos => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get tags => $_getList(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
