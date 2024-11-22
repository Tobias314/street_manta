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
    $core.double? positionAccuracy,
    $core.double? elevationAccuracy,
    $core.double? speed,
    $core.double? speedAccuracy,
    $core.double? heading,
    $core.double? headingAccuracy,
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
    if (positionAccuracy != null) {
      $result.positionAccuracy = positionAccuracy;
    }
    if (elevationAccuracy != null) {
      $result.elevationAccuracy = elevationAccuracy;
    }
    if (speed != null) {
      $result.speed = speed;
    }
    if (speedAccuracy != null) {
      $result.speedAccuracy = speedAccuracy;
    }
    if (heading != null) {
      $result.heading = heading;
    }
    if (headingAccuracy != null) {
      $result.headingAccuracy = headingAccuracy;
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
    ..a<$core.double>(4, _omitFieldNames ? '' : 'positionAccuracy', $pb.PbFieldType.OF)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'elevationAccuracy', $pb.PbFieldType.OF)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.OF)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'speedAccuracy', $pb.PbFieldType.OF)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'heading', $pb.PbFieldType.OF)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'headingAccuracy', $pb.PbFieldType.OF)
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

  @$pb.TagNumber(4)
  $core.double get positionAccuracy => $_getN(3);
  @$pb.TagNumber(4)
  set positionAccuracy($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPositionAccuracy() => $_has(3);
  @$pb.TagNumber(4)
  void clearPositionAccuracy() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get elevationAccuracy => $_getN(4);
  @$pb.TagNumber(5)
  set elevationAccuracy($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasElevationAccuracy() => $_has(4);
  @$pb.TagNumber(5)
  void clearElevationAccuracy() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get speed => $_getN(5);
  @$pb.TagNumber(6)
  set speed($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSpeed() => $_has(5);
  @$pb.TagNumber(6)
  void clearSpeed() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get speedAccuracy => $_getN(6);
  @$pb.TagNumber(7)
  set speedAccuracy($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSpeedAccuracy() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpeedAccuracy() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get heading => $_getN(7);
  @$pb.TagNumber(8)
  set heading($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHeading() => $_has(7);
  @$pb.TagNumber(8)
  void clearHeading() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get headingAccuracy => $_getN(8);
  @$pb.TagNumber(9)
  set headingAccuracy($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasHeadingAccuracy() => $_has(8);
  @$pb.TagNumber(9)
  void clearHeadingAccuracy() => clearField(9);
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

class Acceleration extends $pb.GeneratedMessage {
  factory Acceleration({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    return $result;
  }
  Acceleration._() : super();
  factory Acceleration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Acceleration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Acceleration', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Acceleration clone() => Acceleration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Acceleration copyWith(void Function(Acceleration) updates) => super.copyWith((message) => updates(message as Acceleration)) as Acceleration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Acceleration create() => Acceleration._();
  Acceleration createEmptyInstance() => create();
  static $pb.PbList<Acceleration> createRepeated() => $pb.PbList<Acceleration>();
  @$core.pragma('dart2js:noInline')
  static Acceleration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Acceleration>(create);
  static Acceleration? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => clearField(3);
}

class AngularVelocity extends $pb.GeneratedMessage {
  factory AngularVelocity({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    return $result;
  }
  AngularVelocity._() : super();
  factory AngularVelocity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AngularVelocity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocity', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AngularVelocity clone() => AngularVelocity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AngularVelocity copyWith(void Function(AngularVelocity) updates) => super.copyWith((message) => updates(message as AngularVelocity)) as AngularVelocity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocity create() => AngularVelocity._();
  AngularVelocity createEmptyInstance() => create();
  static $pb.PbList<AngularVelocity> createRepeated() => $pb.PbList<AngularVelocity>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocity>(create);
  static AngularVelocity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => clearField(3);
}

class MagneticField extends $pb.GeneratedMessage {
  factory MagneticField({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (z != null) {
      $result.z = z;
    }
    return $result;
  }
  MagneticField._() : super();
  factory MagneticField.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagneticField.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticField', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagneticField clone() => MagneticField()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagneticField copyWith(void Function(MagneticField) updates) => super.copyWith((message) => updates(message as MagneticField)) as MagneticField;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticField create() => MagneticField._();
  MagneticField createEmptyInstance() => create();
  static $pb.PbList<MagneticField> createRepeated() => $pb.PbList<MagneticField>();
  @$core.pragma('dart2js:noInline')
  static MagneticField getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticField>(create);
  static MagneticField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => clearField(3);
}

class OrientationReading extends $pb.GeneratedMessage {
  factory OrientationReading({
    $fixnum.Int64? epochMicroSeconds,
    Orientation? orientation,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (orientation != null) {
      $result.orientation = orientation;
    }
    return $result;
  }
  OrientationReading._() : super();
  factory OrientationReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrientationReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrientationReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<Orientation>(2, _omitFieldNames ? '' : 'orientation', subBuilder: Orientation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrientationReading clone() => OrientationReading()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrientationReading copyWith(void Function(OrientationReading) updates) => super.copyWith((message) => updates(message as OrientationReading)) as OrientationReading;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrientationReading create() => OrientationReading._();
  OrientationReading createEmptyInstance() => create();
  static $pb.PbList<OrientationReading> createRepeated() => $pb.PbList<OrientationReading>();
  @$core.pragma('dart2js:noInline')
  static OrientationReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrientationReading>(create);
  static OrientationReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  Orientation get orientation => $_getN(1);
  @$pb.TagNumber(2)
  set orientation(Orientation v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrientation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrientation() => clearField(2);
  @$pb.TagNumber(2)
  Orientation ensureOrientation() => $_ensure(1);
}

class GpsReading extends $pb.GeneratedMessage {
  factory GpsReading({
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
  GpsReading._() : super();
  factory GpsReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GpsReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<GpsPosition>(2, _omitFieldNames ? '' : 'position', subBuilder: GpsPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GpsReading clone() => GpsReading()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GpsReading copyWith(void Function(GpsReading) updates) => super.copyWith((message) => updates(message as GpsReading)) as GpsReading;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsReading create() => GpsReading._();
  GpsReading createEmptyInstance() => create();
  static $pb.PbList<GpsReading> createRepeated() => $pb.PbList<GpsReading>();
  @$core.pragma('dart2js:noInline')
  static GpsReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsReading>(create);
  static GpsReading? _defaultInstance;

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

class AccelerationReading extends $pb.GeneratedMessage {
  factory AccelerationReading({
    $fixnum.Int64? epochMicroSeconds,
    Acceleration? acceleration,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (acceleration != null) {
      $result.acceleration = acceleration;
    }
    return $result;
  }
  AccelerationReading._() : super();
  factory AccelerationReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccelerationReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccelerationReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<Acceleration>(2, _omitFieldNames ? '' : 'acceleration', subBuilder: Acceleration.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccelerationReading clone() => AccelerationReading()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccelerationReading copyWith(void Function(AccelerationReading) updates) => super.copyWith((message) => updates(message as AccelerationReading)) as AccelerationReading;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccelerationReading create() => AccelerationReading._();
  AccelerationReading createEmptyInstance() => create();
  static $pb.PbList<AccelerationReading> createRepeated() => $pb.PbList<AccelerationReading>();
  @$core.pragma('dart2js:noInline')
  static AccelerationReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccelerationReading>(create);
  static AccelerationReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  Acceleration get acceleration => $_getN(1);
  @$pb.TagNumber(2)
  set acceleration(Acceleration v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAcceleration() => $_has(1);
  @$pb.TagNumber(2)
  void clearAcceleration() => clearField(2);
  @$pb.TagNumber(2)
  Acceleration ensureAcceleration() => $_ensure(1);
}

class AngularVelocityReading extends $pb.GeneratedMessage {
  factory AngularVelocityReading({
    $fixnum.Int64? epochMicroSeconds,
    AngularVelocity? angularVelocity,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (angularVelocity != null) {
      $result.angularVelocity = angularVelocity;
    }
    return $result;
  }
  AngularVelocityReading._() : super();
  factory AngularVelocityReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AngularVelocityReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocityReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<AngularVelocity>(2, _omitFieldNames ? '' : 'angularVelocity', subBuilder: AngularVelocity.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AngularVelocityReading clone() => AngularVelocityReading()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AngularVelocityReading copyWith(void Function(AngularVelocityReading) updates) => super.copyWith((message) => updates(message as AngularVelocityReading)) as AngularVelocityReading;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocityReading create() => AngularVelocityReading._();
  AngularVelocityReading createEmptyInstance() => create();
  static $pb.PbList<AngularVelocityReading> createRepeated() => $pb.PbList<AngularVelocityReading>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocityReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocityReading>(create);
  static AngularVelocityReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  AngularVelocity get angularVelocity => $_getN(1);
  @$pb.TagNumber(2)
  set angularVelocity(AngularVelocity v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAngularVelocity() => $_has(1);
  @$pb.TagNumber(2)
  void clearAngularVelocity() => clearField(2);
  @$pb.TagNumber(2)
  AngularVelocity ensureAngularVelocity() => $_ensure(1);
}

class MagneticFieldReading extends $pb.GeneratedMessage {
  factory MagneticFieldReading({
    $fixnum.Int64? epochMicroSeconds,
    MagneticField? magneticField,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (magneticField != null) {
      $result.magneticField = magneticField;
    }
    return $result;
  }
  MagneticFieldReading._() : super();
  factory MagneticFieldReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagneticFieldReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticFieldReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<MagneticField>(2, _omitFieldNames ? '' : 'magneticField', subBuilder: MagneticField.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagneticFieldReading clone() => MagneticFieldReading()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagneticFieldReading copyWith(void Function(MagneticFieldReading) updates) => super.copyWith((message) => updates(message as MagneticFieldReading)) as MagneticFieldReading;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticFieldReading create() => MagneticFieldReading._();
  MagneticFieldReading createEmptyInstance() => create();
  static $pb.PbList<MagneticFieldReading> createRepeated() => $pb.PbList<MagneticFieldReading>();
  @$core.pragma('dart2js:noInline')
  static MagneticFieldReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticFieldReading>(create);
  static MagneticFieldReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => clearField(1);

  @$pb.TagNumber(2)
  MagneticField get magneticField => $_getN(1);
  @$pb.TagNumber(2)
  set magneticField(MagneticField v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMagneticField() => $_has(1);
  @$pb.TagNumber(2)
  void clearMagneticField() => clearField(2);
  @$pb.TagNumber(2)
  MagneticField ensureMagneticField() => $_ensure(1);
}

class OrientationCapture extends $pb.GeneratedMessage {
  factory OrientationCapture({
    $core.Iterable<OrientationReading>? readings,
    $core.String? identifier,
  }) {
    final $result = create();
    if (readings != null) {
      $result.readings.addAll(readings);
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  OrientationCapture._() : super();
  factory OrientationCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrientationCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrientationCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<OrientationReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: OrientationReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrientationCapture clone() => OrientationCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrientationCapture copyWith(void Function(OrientationCapture) updates) => super.copyWith((message) => updates(message as OrientationCapture)) as OrientationCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrientationCapture create() => OrientationCapture._();
  OrientationCapture createEmptyInstance() => create();
  static $pb.PbList<OrientationCapture> createRepeated() => $pb.PbList<OrientationCapture>();
  @$core.pragma('dart2js:noInline')
  static OrientationCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrientationCapture>(create);
  static OrientationCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OrientationReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => clearField(2);
}

class GpsCapture extends $pb.GeneratedMessage {
  factory GpsCapture({
    $core.Iterable<GpsReading>? readings,
    $core.String? identifier,
  }) {
    final $result = create();
    if (readings != null) {
      $result.readings.addAll(readings);
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  GpsCapture._() : super();
  factory GpsCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GpsCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<GpsReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: GpsReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
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
  $core.List<GpsReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => clearField(2);
}

class AccelerationCapture extends $pb.GeneratedMessage {
  factory AccelerationCapture({
    $core.Iterable<AccelerationReading>? readings,
    $core.String? identifier,
  }) {
    final $result = create();
    if (readings != null) {
      $result.readings.addAll(readings);
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  AccelerationCapture._() : super();
  factory AccelerationCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccelerationCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccelerationCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<AccelerationReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: AccelerationReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccelerationCapture clone() => AccelerationCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccelerationCapture copyWith(void Function(AccelerationCapture) updates) => super.copyWith((message) => updates(message as AccelerationCapture)) as AccelerationCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccelerationCapture create() => AccelerationCapture._();
  AccelerationCapture createEmptyInstance() => create();
  static $pb.PbList<AccelerationCapture> createRepeated() => $pb.PbList<AccelerationCapture>();
  @$core.pragma('dart2js:noInline')
  static AccelerationCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccelerationCapture>(create);
  static AccelerationCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AccelerationReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => clearField(2);
}

class AngularVelocityCapture extends $pb.GeneratedMessage {
  factory AngularVelocityCapture({
    $core.Iterable<AngularVelocityReading>? readings,
    $core.String? identifier,
  }) {
    final $result = create();
    if (readings != null) {
      $result.readings.addAll(readings);
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  AngularVelocityCapture._() : super();
  factory AngularVelocityCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AngularVelocityCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocityCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<AngularVelocityReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: AngularVelocityReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AngularVelocityCapture clone() => AngularVelocityCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AngularVelocityCapture copyWith(void Function(AngularVelocityCapture) updates) => super.copyWith((message) => updates(message as AngularVelocityCapture)) as AngularVelocityCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocityCapture create() => AngularVelocityCapture._();
  AngularVelocityCapture createEmptyInstance() => create();
  static $pb.PbList<AngularVelocityCapture> createRepeated() => $pb.PbList<AngularVelocityCapture>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocityCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocityCapture>(create);
  static AngularVelocityCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AngularVelocityReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => clearField(2);
}

class MagneticFieldCapture extends $pb.GeneratedMessage {
  factory MagneticFieldCapture({
    $core.Iterable<MagneticFieldReading>? readings,
    $core.String? identifier,
  }) {
    final $result = create();
    if (readings != null) {
      $result.readings.addAll(readings);
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  MagneticFieldCapture._() : super();
  factory MagneticFieldCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MagneticFieldCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticFieldCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<MagneticFieldReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: MagneticFieldReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MagneticFieldCapture clone() => MagneticFieldCapture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MagneticFieldCapture copyWith(void Function(MagneticFieldCapture) updates) => super.copyWith((message) => updates(message as MagneticFieldCapture)) as MagneticFieldCapture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticFieldCapture create() => MagneticFieldCapture._();
  MagneticFieldCapture createEmptyInstance() => create();
  static $pb.PbList<MagneticFieldCapture> createRepeated() => $pb.PbList<MagneticFieldCapture>();
  @$core.pragma('dart2js:noInline')
  static MagneticFieldCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticFieldCapture>(create);
  static MagneticFieldCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MagneticFieldReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => clearField(2);
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
    $core.String? format,
    $core.List<$core.int>? data,
    GpsReading? gps,
    OrientationReading? orientation,
    CameraSpecification? cameraSpecification,
    $core.String? identifier,
  }) {
    final $result = create();
    if (epochMicroSeconds != null) {
      $result.epochMicroSeconds = epochMicroSeconds;
    }
    if (format != null) {
      $result.format = format;
    }
    if (data != null) {
      $result.data = data;
    }
    if (gps != null) {
      $result.gps = gps;
    }
    if (orientation != null) {
      $result.orientation = orientation;
    }
    if (cameraSpecification != null) {
      $result.cameraSpecification = cameraSpecification;
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    return $result;
  }
  PhotoCapture._() : super();
  factory PhotoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PhotoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PhotoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOS(2, _omitFieldNames ? '' : 'format')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOM<GpsReading>(4, _omitFieldNames ? '' : 'gps', subBuilder: GpsReading.create)
    ..aOM<OrientationReading>(5, _omitFieldNames ? '' : 'orientation', subBuilder: OrientationReading.create)
    ..aOM<CameraSpecification>(6, _omitFieldNames ? '' : 'cameraSpecification', subBuilder: CameraSpecification.create)
    ..aOS(7, _omitFieldNames ? '' : 'identifier')
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
  $core.String get format => $_getSZ(1);
  @$pb.TagNumber(2)
  set format($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormat() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);

  @$pb.TagNumber(4)
  GpsReading get gps => $_getN(3);
  @$pb.TagNumber(4)
  set gps(GpsReading v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGps() => $_has(3);
  @$pb.TagNumber(4)
  void clearGps() => clearField(4);
  @$pb.TagNumber(4)
  GpsReading ensureGps() => $_ensure(3);

  @$pb.TagNumber(5)
  OrientationReading get orientation => $_getN(4);
  @$pb.TagNumber(5)
  set orientation(OrientationReading v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrientation() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrientation() => clearField(5);
  @$pb.TagNumber(5)
  OrientationReading ensureOrientation() => $_ensure(4);

  @$pb.TagNumber(6)
  CameraSpecification get cameraSpecification => $_getN(5);
  @$pb.TagNumber(6)
  set cameraSpecification(CameraSpecification v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCameraSpecification() => $_has(5);
  @$pb.TagNumber(6)
  void clearCameraSpecification() => clearField(6);
  @$pb.TagNumber(6)
  CameraSpecification ensureCameraSpecification() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get identifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set identifier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentifier() => clearField(7);
}

class VideoCapture extends $pb.GeneratedMessage {
  factory VideoCapture({
    $fixnum.Int64? startEpochMicroSeconds,
    $fixnum.Int64? endEpochMicroSeconds,
    $core.String? format,
    $core.List<$core.int>? data,
    $fixnum.Int64? fps,
    CameraSpecification? cameraSpecification,
    $core.String? identifier,
    $core.Iterable<$fixnum.Int64>? frameEpochsMicroSeconds,
  }) {
    final $result = create();
    if (startEpochMicroSeconds != null) {
      $result.startEpochMicroSeconds = startEpochMicroSeconds;
    }
    if (endEpochMicroSeconds != null) {
      $result.endEpochMicroSeconds = endEpochMicroSeconds;
    }
    if (format != null) {
      $result.format = format;
    }
    if (data != null) {
      $result.data = data;
    }
    if (fps != null) {
      $result.fps = fps;
    }
    if (cameraSpecification != null) {
      $result.cameraSpecification = cameraSpecification;
    }
    if (identifier != null) {
      $result.identifier = identifier;
    }
    if (frameEpochsMicroSeconds != null) {
      $result.frameEpochsMicroSeconds.addAll(frameEpochsMicroSeconds);
    }
    return $result;
  }
  VideoCapture._() : super();
  factory VideoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'startEpochMicroSeconds')
    ..aInt64(2, _omitFieldNames ? '' : 'endEpochMicroSeconds')
    ..aOS(3, _omitFieldNames ? '' : 'format')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aInt64(5, _omitFieldNames ? '' : 'fps')
    ..aOM<CameraSpecification>(6, _omitFieldNames ? '' : 'cameraSpecification', subBuilder: CameraSpecification.create)
    ..aOS(7, _omitFieldNames ? '' : 'identifier')
    ..p<$fixnum.Int64>(8, _omitFieldNames ? '' : 'frameEpochsMicroSeconds', $pb.PbFieldType.K6)
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
  $core.String get format => $_getSZ(2);
  @$pb.TagNumber(3)
  set format($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fps => $_getI64(4);
  @$pb.TagNumber(5)
  set fps($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFps() => $_has(4);
  @$pb.TagNumber(5)
  void clearFps() => clearField(5);

  @$pb.TagNumber(6)
  CameraSpecification get cameraSpecification => $_getN(5);
  @$pb.TagNumber(6)
  set cameraSpecification(CameraSpecification v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCameraSpecification() => $_has(5);
  @$pb.TagNumber(6)
  void clearCameraSpecification() => clearField(6);
  @$pb.TagNumber(6)
  CameraSpecification ensureCameraSpecification() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get identifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set identifier($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentifier() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$fixnum.Int64> get frameEpochsMicroSeconds => $_getList(7);
}

class GeoCapture extends $pb.GeneratedMessage {
  factory GeoCapture({
    $core.String? device,
    $core.Iterable<GpsCapture>? gps,
    $core.Iterable<OrientationCapture>? orientation,
    $core.Iterable<AccelerationCapture>? acceleration,
    $core.Iterable<AngularVelocityCapture>? angularVelocity,
    $core.Iterable<MagneticFieldCapture>? magneticField,
    $core.Iterable<PhotoCapture>? photos,
    $core.Iterable<VideoCapture>? videos,
    $core.String? description,
    $core.Iterable<$core.String>? tags,
    $core.String? traceIdentifier,
    $fixnum.Int64? timestampEpochMicroSeconds,
    $fixnum.Int64? chunkIndex,
    $core.bool? isLastChunk,
  }) {
    final $result = create();
    if (device != null) {
      $result.device = device;
    }
    if (gps != null) {
      $result.gps.addAll(gps);
    }
    if (orientation != null) {
      $result.orientation.addAll(orientation);
    }
    if (acceleration != null) {
      $result.acceleration.addAll(acceleration);
    }
    if (angularVelocity != null) {
      $result.angularVelocity.addAll(angularVelocity);
    }
    if (magneticField != null) {
      $result.magneticField.addAll(magneticField);
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
    if (traceIdentifier != null) {
      $result.traceIdentifier = traceIdentifier;
    }
    if (timestampEpochMicroSeconds != null) {
      $result.timestampEpochMicroSeconds = timestampEpochMicroSeconds;
    }
    if (chunkIndex != null) {
      $result.chunkIndex = chunkIndex;
    }
    if (isLastChunk != null) {
      $result.isLastChunk = isLastChunk;
    }
    return $result;
  }
  GeoCapture._() : super();
  factory GeoCapture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeoCapture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GeoCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'device')
    ..pc<GpsCapture>(2, _omitFieldNames ? '' : 'gps', $pb.PbFieldType.PM, subBuilder: GpsCapture.create)
    ..pc<OrientationCapture>(3, _omitFieldNames ? '' : 'orientation', $pb.PbFieldType.PM, subBuilder: OrientationCapture.create)
    ..pc<AccelerationCapture>(4, _omitFieldNames ? '' : 'acceleration', $pb.PbFieldType.PM, subBuilder: AccelerationCapture.create)
    ..pc<AngularVelocityCapture>(5, _omitFieldNames ? '' : 'angularVelocity', $pb.PbFieldType.PM, subBuilder: AngularVelocityCapture.create)
    ..pc<MagneticFieldCapture>(6, _omitFieldNames ? '' : 'magneticField', $pb.PbFieldType.PM, subBuilder: MagneticFieldCapture.create)
    ..pc<PhotoCapture>(7, _omitFieldNames ? '' : 'photos', $pb.PbFieldType.PM, subBuilder: PhotoCapture.create)
    ..pc<VideoCapture>(8, _omitFieldNames ? '' : 'videos', $pb.PbFieldType.PM, subBuilder: VideoCapture.create)
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..pPS(10, _omitFieldNames ? '' : 'tags')
    ..aOS(11, _omitFieldNames ? '' : 'traceIdentifier')
    ..aInt64(12, _omitFieldNames ? '' : 'timestampEpochMicroSeconds')
    ..aInt64(13, _omitFieldNames ? '' : 'chunkIndex')
    ..aOB(14, _omitFieldNames ? '' : 'isLastChunk')
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
  $core.List<OrientationCapture> get orientation => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<AccelerationCapture> get acceleration => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<AngularVelocityCapture> get angularVelocity => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<MagneticFieldCapture> get magneticField => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<PhotoCapture> get photos => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<VideoCapture> get videos => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get tags => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get traceIdentifier => $_getSZ(10);
  @$pb.TagNumber(11)
  set traceIdentifier($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTraceIdentifier() => $_has(10);
  @$pb.TagNumber(11)
  void clearTraceIdentifier() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get timestampEpochMicroSeconds => $_getI64(11);
  @$pb.TagNumber(12)
  set timestampEpochMicroSeconds($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTimestampEpochMicroSeconds() => $_has(11);
  @$pb.TagNumber(12)
  void clearTimestampEpochMicroSeconds() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get chunkIndex => $_getI64(12);
  @$pb.TagNumber(13)
  set chunkIndex($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasChunkIndex() => $_has(12);
  @$pb.TagNumber(13)
  void clearChunkIndex() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get isLastChunk => $_getBF(13);
  @$pb.TagNumber(14)
  set isLastChunk($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIsLastChunk() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsLastChunk() => clearField(14);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
