//
//  Generated code. Do not modify.
//  source: protobufs/geo_capture.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

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
    final result = create();
    if (longitude != null) result.longitude = longitude;
    if (latitude != null) result.latitude = latitude;
    if (elevation != null) result.elevation = elevation;
    if (positionAccuracy != null) result.positionAccuracy = positionAccuracy;
    if (elevationAccuracy != null) result.elevationAccuracy = elevationAccuracy;
    if (speed != null) result.speed = speed;
    if (speedAccuracy != null) result.speedAccuracy = speedAccuracy;
    if (heading != null) result.heading = heading;
    if (headingAccuracy != null) result.headingAccuracy = headingAccuracy;
    return result;
  }

  GpsPosition._();

  factory GpsPosition.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GpsPosition.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

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

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsPosition clone() => GpsPosition()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsPosition copyWith(void Function(GpsPosition) updates) => super.copyWith((message) => updates(message as GpsPosition)) as GpsPosition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsPosition create() => GpsPosition._();
  @$core.override
  GpsPosition createEmptyInstance() => create();
  static $pb.PbList<GpsPosition> createRepeated() => $pb.PbList<GpsPosition>();
  @$core.pragma('dart2js:noInline')
  static GpsPosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsPosition>(create);
  static GpsPosition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get longitude => $_getN(0);
  @$pb.TagNumber(1)
  set longitude($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLongitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLongitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get latitude => $_getN(1);
  @$pb.TagNumber(2)
  set latitude($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLatitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatitude() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get elevation => $_getN(2);
  @$pb.TagNumber(3)
  set elevation($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasElevation() => $_has(2);
  @$pb.TagNumber(3)
  void clearElevation() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get positionAccuracy => $_getN(3);
  @$pb.TagNumber(4)
  set positionAccuracy($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPositionAccuracy() => $_has(3);
  @$pb.TagNumber(4)
  void clearPositionAccuracy() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get elevationAccuracy => $_getN(4);
  @$pb.TagNumber(5)
  set elevationAccuracy($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasElevationAccuracy() => $_has(4);
  @$pb.TagNumber(5)
  void clearElevationAccuracy() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get speed => $_getN(5);
  @$pb.TagNumber(6)
  set speed($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSpeed() => $_has(5);
  @$pb.TagNumber(6)
  void clearSpeed() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get speedAccuracy => $_getN(6);
  @$pb.TagNumber(7)
  set speedAccuracy($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSpeedAccuracy() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpeedAccuracy() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get heading => $_getN(7);
  @$pb.TagNumber(8)
  set heading($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasHeading() => $_has(7);
  @$pb.TagNumber(8)
  void clearHeading() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get headingAccuracy => $_getN(8);
  @$pb.TagNumber(9)
  set headingAccuracy($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasHeadingAccuracy() => $_has(8);
  @$pb.TagNumber(9)
  void clearHeadingAccuracy() => $_clearField(9);
}

class Orientation extends $pb.GeneratedMessage {
  factory Orientation({
    $core.double? roll,
    $core.double? pitch,
    $core.double? yaw,
  }) {
    final result = create();
    if (roll != null) result.roll = roll;
    if (pitch != null) result.pitch = pitch;
    if (yaw != null) result.yaw = yaw;
    return result;
  }

  Orientation._();

  factory Orientation.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Orientation.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Orientation', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'roll', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'pitch', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'yaw', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Orientation clone() => Orientation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Orientation copyWith(void Function(Orientation) updates) => super.copyWith((message) => updates(message as Orientation)) as Orientation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Orientation create() => Orientation._();
  @$core.override
  Orientation createEmptyInstance() => create();
  static $pb.PbList<Orientation> createRepeated() => $pb.PbList<Orientation>();
  @$core.pragma('dart2js:noInline')
  static Orientation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Orientation>(create);
  static Orientation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get roll => $_getN(0);
  @$pb.TagNumber(1)
  set roll($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoll() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoll() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get pitch => $_getN(1);
  @$pb.TagNumber(2)
  set pitch($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPitch() => $_has(1);
  @$pb.TagNumber(2)
  void clearPitch() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get yaw => $_getN(2);
  @$pb.TagNumber(3)
  set yaw($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasYaw() => $_has(2);
  @$pb.TagNumber(3)
  void clearYaw() => $_clearField(3);
}

class Acceleration extends $pb.GeneratedMessage {
  factory Acceleration({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    if (z != null) result.z = z;
    return result;
  }

  Acceleration._();

  factory Acceleration.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Acceleration.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Acceleration', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Acceleration clone() => Acceleration()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Acceleration copyWith(void Function(Acceleration) updates) => super.copyWith((message) => updates(message as Acceleration)) as Acceleration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Acceleration create() => Acceleration._();
  @$core.override
  Acceleration createEmptyInstance() => create();
  static $pb.PbList<Acceleration> createRepeated() => $pb.PbList<Acceleration>();
  @$core.pragma('dart2js:noInline')
  static Acceleration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Acceleration>(create);
  static Acceleration? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => $_clearField(3);
}

class AngularVelocity extends $pb.GeneratedMessage {
  factory AngularVelocity({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    if (z != null) result.z = z;
    return result;
  }

  AngularVelocity._();

  factory AngularVelocity.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AngularVelocity.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocity', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocity clone() => AngularVelocity()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocity copyWith(void Function(AngularVelocity) updates) => super.copyWith((message) => updates(message as AngularVelocity)) as AngularVelocity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocity create() => AngularVelocity._();
  @$core.override
  AngularVelocity createEmptyInstance() => create();
  static $pb.PbList<AngularVelocity> createRepeated() => $pb.PbList<AngularVelocity>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocity>(create);
  static AngularVelocity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => $_clearField(3);
}

class MagneticField extends $pb.GeneratedMessage {
  factory MagneticField({
    $core.double? x,
    $core.double? y,
    $core.double? z,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    if (z != null) result.z = z;
    return result;
  }

  MagneticField._();

  factory MagneticField.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MagneticField.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticField', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'z', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticField clone() => MagneticField()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticField copyWith(void Function(MagneticField) updates) => super.copyWith((message) => updates(message as MagneticField)) as MagneticField;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticField create() => MagneticField._();
  @$core.override
  MagneticField createEmptyInstance() => create();
  static $pb.PbList<MagneticField> createRepeated() => $pb.PbList<MagneticField>();
  @$core.pragma('dart2js:noInline')
  static MagneticField getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticField>(create);
  static MagneticField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => $_clearField(3);
}

class OrientationReading extends $pb.GeneratedMessage {
  factory OrientationReading({
    $fixnum.Int64? epochMicroSeconds,
    Orientation? orientation,
  }) {
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (orientation != null) result.orientation = orientation;
    return result;
  }

  OrientationReading._();

  factory OrientationReading.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OrientationReading.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrientationReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<Orientation>(2, _omitFieldNames ? '' : 'orientation', subBuilder: Orientation.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrientationReading clone() => OrientationReading()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrientationReading copyWith(void Function(OrientationReading) updates) => super.copyWith((message) => updates(message as OrientationReading)) as OrientationReading;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrientationReading create() => OrientationReading._();
  @$core.override
  OrientationReading createEmptyInstance() => create();
  static $pb.PbList<OrientationReading> createRepeated() => $pb.PbList<OrientationReading>();
  @$core.pragma('dart2js:noInline')
  static OrientationReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrientationReading>(create);
  static OrientationReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  Orientation get orientation => $_getN(1);
  @$pb.TagNumber(2)
  set orientation(Orientation value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOrientation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrientation() => $_clearField(2);
  @$pb.TagNumber(2)
  Orientation ensureOrientation() => $_ensure(1);
}

class GpsReading extends $pb.GeneratedMessage {
  factory GpsReading({
    $fixnum.Int64? epochMicroSeconds,
    GpsPosition? position,
  }) {
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (position != null) result.position = position;
    return result;
  }

  GpsReading._();

  factory GpsReading.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GpsReading.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<GpsPosition>(2, _omitFieldNames ? '' : 'position', subBuilder: GpsPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsReading clone() => GpsReading()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsReading copyWith(void Function(GpsReading) updates) => super.copyWith((message) => updates(message as GpsReading)) as GpsReading;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsReading create() => GpsReading._();
  @$core.override
  GpsReading createEmptyInstance() => create();
  static $pb.PbList<GpsReading> createRepeated() => $pb.PbList<GpsReading>();
  @$core.pragma('dart2js:noInline')
  static GpsReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsReading>(create);
  static GpsReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  GpsPosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(GpsPosition value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  GpsPosition ensurePosition() => $_ensure(1);
}

class AccelerationReading extends $pb.GeneratedMessage {
  factory AccelerationReading({
    $fixnum.Int64? epochMicroSeconds,
    Acceleration? acceleration,
  }) {
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (acceleration != null) result.acceleration = acceleration;
    return result;
  }

  AccelerationReading._();

  factory AccelerationReading.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AccelerationReading.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccelerationReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<Acceleration>(2, _omitFieldNames ? '' : 'acceleration', subBuilder: Acceleration.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccelerationReading clone() => AccelerationReading()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccelerationReading copyWith(void Function(AccelerationReading) updates) => super.copyWith((message) => updates(message as AccelerationReading)) as AccelerationReading;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccelerationReading create() => AccelerationReading._();
  @$core.override
  AccelerationReading createEmptyInstance() => create();
  static $pb.PbList<AccelerationReading> createRepeated() => $pb.PbList<AccelerationReading>();
  @$core.pragma('dart2js:noInline')
  static AccelerationReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccelerationReading>(create);
  static AccelerationReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  Acceleration get acceleration => $_getN(1);
  @$pb.TagNumber(2)
  set acceleration(Acceleration value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAcceleration() => $_has(1);
  @$pb.TagNumber(2)
  void clearAcceleration() => $_clearField(2);
  @$pb.TagNumber(2)
  Acceleration ensureAcceleration() => $_ensure(1);
}

class AngularVelocityReading extends $pb.GeneratedMessage {
  factory AngularVelocityReading({
    $fixnum.Int64? epochMicroSeconds,
    AngularVelocity? angularVelocity,
  }) {
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (angularVelocity != null) result.angularVelocity = angularVelocity;
    return result;
  }

  AngularVelocityReading._();

  factory AngularVelocityReading.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AngularVelocityReading.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocityReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<AngularVelocity>(2, _omitFieldNames ? '' : 'angularVelocity', subBuilder: AngularVelocity.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocityReading clone() => AngularVelocityReading()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocityReading copyWith(void Function(AngularVelocityReading) updates) => super.copyWith((message) => updates(message as AngularVelocityReading)) as AngularVelocityReading;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocityReading create() => AngularVelocityReading._();
  @$core.override
  AngularVelocityReading createEmptyInstance() => create();
  static $pb.PbList<AngularVelocityReading> createRepeated() => $pb.PbList<AngularVelocityReading>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocityReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocityReading>(create);
  static AngularVelocityReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  AngularVelocity get angularVelocity => $_getN(1);
  @$pb.TagNumber(2)
  set angularVelocity(AngularVelocity value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAngularVelocity() => $_has(1);
  @$pb.TagNumber(2)
  void clearAngularVelocity() => $_clearField(2);
  @$pb.TagNumber(2)
  AngularVelocity ensureAngularVelocity() => $_ensure(1);
}

class MagneticFieldReading extends $pb.GeneratedMessage {
  factory MagneticFieldReading({
    $fixnum.Int64? epochMicroSeconds,
    MagneticField? magneticField,
  }) {
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (magneticField != null) result.magneticField = magneticField;
    return result;
  }

  MagneticFieldReading._();

  factory MagneticFieldReading.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MagneticFieldReading.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticFieldReading', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'epochMicroSeconds')
    ..aOM<MagneticField>(2, _omitFieldNames ? '' : 'magneticField', subBuilder: MagneticField.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticFieldReading clone() => MagneticFieldReading()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticFieldReading copyWith(void Function(MagneticFieldReading) updates) => super.copyWith((message) => updates(message as MagneticFieldReading)) as MagneticFieldReading;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticFieldReading create() => MagneticFieldReading._();
  @$core.override
  MagneticFieldReading createEmptyInstance() => create();
  static $pb.PbList<MagneticFieldReading> createRepeated() => $pb.PbList<MagneticFieldReading>();
  @$core.pragma('dart2js:noInline')
  static MagneticFieldReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticFieldReading>(create);
  static MagneticFieldReading? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  MagneticField get magneticField => $_getN(1);
  @$pb.TagNumber(2)
  set magneticField(MagneticField value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMagneticField() => $_has(1);
  @$pb.TagNumber(2)
  void clearMagneticField() => $_clearField(2);
  @$pb.TagNumber(2)
  MagneticField ensureMagneticField() => $_ensure(1);
}

class OrientationCapture extends $pb.GeneratedMessage {
  factory OrientationCapture({
    $core.Iterable<OrientationReading>? readings,
    $core.String? identifier,
  }) {
    final result = create();
    if (readings != null) result.readings.addAll(readings);
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  OrientationCapture._();

  factory OrientationCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OrientationCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrientationCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<OrientationReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: OrientationReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrientationCapture clone() => OrientationCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrientationCapture copyWith(void Function(OrientationCapture) updates) => super.copyWith((message) => updates(message as OrientationCapture)) as OrientationCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrientationCapture create() => OrientationCapture._();
  @$core.override
  OrientationCapture createEmptyInstance() => create();
  static $pb.PbList<OrientationCapture> createRepeated() => $pb.PbList<OrientationCapture>();
  @$core.pragma('dart2js:noInline')
  static OrientationCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrientationCapture>(create);
  static OrientationCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<OrientationReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class GpsCapture extends $pb.GeneratedMessage {
  factory GpsCapture({
    $core.Iterable<GpsReading>? readings,
    $core.String? identifier,
  }) {
    final result = create();
    if (readings != null) result.readings.addAll(readings);
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  GpsCapture._();

  factory GpsCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GpsCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GpsCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<GpsReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: GpsReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsCapture clone() => GpsCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GpsCapture copyWith(void Function(GpsCapture) updates) => super.copyWith((message) => updates(message as GpsCapture)) as GpsCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GpsCapture create() => GpsCapture._();
  @$core.override
  GpsCapture createEmptyInstance() => create();
  static $pb.PbList<GpsCapture> createRepeated() => $pb.PbList<GpsCapture>();
  @$core.pragma('dart2js:noInline')
  static GpsCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GpsCapture>(create);
  static GpsCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GpsReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class AccelerationCapture extends $pb.GeneratedMessage {
  factory AccelerationCapture({
    $core.Iterable<AccelerationReading>? readings,
    $core.String? identifier,
  }) {
    final result = create();
    if (readings != null) result.readings.addAll(readings);
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  AccelerationCapture._();

  factory AccelerationCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AccelerationCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccelerationCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<AccelerationReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: AccelerationReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccelerationCapture clone() => AccelerationCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccelerationCapture copyWith(void Function(AccelerationCapture) updates) => super.copyWith((message) => updates(message as AccelerationCapture)) as AccelerationCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccelerationCapture create() => AccelerationCapture._();
  @$core.override
  AccelerationCapture createEmptyInstance() => create();
  static $pb.PbList<AccelerationCapture> createRepeated() => $pb.PbList<AccelerationCapture>();
  @$core.pragma('dart2js:noInline')
  static AccelerationCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccelerationCapture>(create);
  static AccelerationCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AccelerationReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class AngularVelocityCapture extends $pb.GeneratedMessage {
  factory AngularVelocityCapture({
    $core.Iterable<AngularVelocityReading>? readings,
    $core.String? identifier,
  }) {
    final result = create();
    if (readings != null) result.readings.addAll(readings);
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  AngularVelocityCapture._();

  factory AngularVelocityCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AngularVelocityCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AngularVelocityCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<AngularVelocityReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: AngularVelocityReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocityCapture clone() => AngularVelocityCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AngularVelocityCapture copyWith(void Function(AngularVelocityCapture) updates) => super.copyWith((message) => updates(message as AngularVelocityCapture)) as AngularVelocityCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AngularVelocityCapture create() => AngularVelocityCapture._();
  @$core.override
  AngularVelocityCapture createEmptyInstance() => create();
  static $pb.PbList<AngularVelocityCapture> createRepeated() => $pb.PbList<AngularVelocityCapture>();
  @$core.pragma('dart2js:noInline')
  static AngularVelocityCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AngularVelocityCapture>(create);
  static AngularVelocityCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AngularVelocityReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class MagneticFieldCapture extends $pb.GeneratedMessage {
  factory MagneticFieldCapture({
    $core.Iterable<MagneticFieldReading>? readings,
    $core.String? identifier,
  }) {
    final result = create();
    if (readings != null) result.readings.addAll(readings);
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  MagneticFieldCapture._();

  factory MagneticFieldCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MagneticFieldCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MagneticFieldCapture', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..pc<MagneticFieldReading>(1, _omitFieldNames ? '' : 'readings', $pb.PbFieldType.PM, subBuilder: MagneticFieldReading.create)
    ..aOS(2, _omitFieldNames ? '' : 'identifier')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticFieldCapture clone() => MagneticFieldCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MagneticFieldCapture copyWith(void Function(MagneticFieldCapture) updates) => super.copyWith((message) => updates(message as MagneticFieldCapture)) as MagneticFieldCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MagneticFieldCapture create() => MagneticFieldCapture._();
  @$core.override
  MagneticFieldCapture createEmptyInstance() => create();
  static $pb.PbList<MagneticFieldCapture> createRepeated() => $pb.PbList<MagneticFieldCapture>();
  @$core.pragma('dart2js:noInline')
  static MagneticFieldCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MagneticFieldCapture>(create);
  static MagneticFieldCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MagneticFieldReading> get readings => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identifier => $_getSZ(1);
  @$pb.TagNumber(2)
  set identifier($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentifier() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField(2);
}

class CameraSpecification extends $pb.GeneratedMessage {
  factory CameraSpecification({
    $core.int? cameraIndex,
    $core.double? focalLength,
    $core.double? exposureTime,
  }) {
    final result = create();
    if (cameraIndex != null) result.cameraIndex = cameraIndex;
    if (focalLength != null) result.focalLength = focalLength;
    if (exposureTime != null) result.exposureTime = exposureTime;
    return result;
  }

  CameraSpecification._();

  factory CameraSpecification.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CameraSpecification.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CameraSpecification', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'cameraIndex', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'focalLength', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'exposureTime', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CameraSpecification clone() => CameraSpecification()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CameraSpecification copyWith(void Function(CameraSpecification) updates) => super.copyWith((message) => updates(message as CameraSpecification)) as CameraSpecification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CameraSpecification create() => CameraSpecification._();
  @$core.override
  CameraSpecification createEmptyInstance() => create();
  static $pb.PbList<CameraSpecification> createRepeated() => $pb.PbList<CameraSpecification>();
  @$core.pragma('dart2js:noInline')
  static CameraSpecification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraSpecification>(create);
  static CameraSpecification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get cameraIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set cameraIndex($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCameraIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearCameraIndex() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get focalLength => $_getN(1);
  @$pb.TagNumber(2)
  set focalLength($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFocalLength() => $_has(1);
  @$pb.TagNumber(2)
  void clearFocalLength() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get exposureTime => $_getN(2);
  @$pb.TagNumber(3)
  set exposureTime($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExposureTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearExposureTime() => $_clearField(3);
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
    final result = create();
    if (epochMicroSeconds != null) result.epochMicroSeconds = epochMicroSeconds;
    if (format != null) result.format = format;
    if (data != null) result.data = data;
    if (gps != null) result.gps = gps;
    if (orientation != null) result.orientation = orientation;
    if (cameraSpecification != null) result.cameraSpecification = cameraSpecification;
    if (identifier != null) result.identifier = identifier;
    return result;
  }

  PhotoCapture._();

  factory PhotoCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PhotoCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

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

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhotoCapture clone() => PhotoCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhotoCapture copyWith(void Function(PhotoCapture) updates) => super.copyWith((message) => updates(message as PhotoCapture)) as PhotoCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhotoCapture create() => PhotoCapture._();
  @$core.override
  PhotoCapture createEmptyInstance() => create();
  static $pb.PbList<PhotoCapture> createRepeated() => $pb.PbList<PhotoCapture>();
  @$core.pragma('dart2js:noInline')
  static PhotoCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoCapture>(create);
  static PhotoCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get format => $_getSZ(1);
  @$pb.TagNumber(2)
  set format($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFormat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFormat() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);

  @$pb.TagNumber(4)
  GpsReading get gps => $_getN(3);
  @$pb.TagNumber(4)
  set gps(GpsReading value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasGps() => $_has(3);
  @$pb.TagNumber(4)
  void clearGps() => $_clearField(4);
  @$pb.TagNumber(4)
  GpsReading ensureGps() => $_ensure(3);

  @$pb.TagNumber(5)
  OrientationReading get orientation => $_getN(4);
  @$pb.TagNumber(5)
  set orientation(OrientationReading value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOrientation() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrientation() => $_clearField(5);
  @$pb.TagNumber(5)
  OrientationReading ensureOrientation() => $_ensure(4);

  @$pb.TagNumber(6)
  CameraSpecification get cameraSpecification => $_getN(5);
  @$pb.TagNumber(6)
  set cameraSpecification(CameraSpecification value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCameraSpecification() => $_has(5);
  @$pb.TagNumber(6)
  void clearCameraSpecification() => $_clearField(6);
  @$pb.TagNumber(6)
  CameraSpecification ensureCameraSpecification() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get identifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set identifier($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentifier() => $_clearField(7);
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
    final result = create();
    if (startEpochMicroSeconds != null) result.startEpochMicroSeconds = startEpochMicroSeconds;
    if (endEpochMicroSeconds != null) result.endEpochMicroSeconds = endEpochMicroSeconds;
    if (format != null) result.format = format;
    if (data != null) result.data = data;
    if (fps != null) result.fps = fps;
    if (cameraSpecification != null) result.cameraSpecification = cameraSpecification;
    if (identifier != null) result.identifier = identifier;
    if (frameEpochsMicroSeconds != null) result.frameEpochsMicroSeconds.addAll(frameEpochsMicroSeconds);
    return result;
  }

  VideoCapture._();

  factory VideoCapture.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory VideoCapture.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

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

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCapture clone() => VideoCapture()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoCapture copyWith(void Function(VideoCapture) updates) => super.copyWith((message) => updates(message as VideoCapture)) as VideoCapture;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoCapture create() => VideoCapture._();
  @$core.override
  VideoCapture createEmptyInstance() => create();
  static $pb.PbList<VideoCapture> createRepeated() => $pb.PbList<VideoCapture>();
  @$core.pragma('dart2js:noInline')
  static VideoCapture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoCapture>(create);
  static VideoCapture? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get startEpochMicroSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set startEpochMicroSeconds($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartEpochMicroSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartEpochMicroSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get endEpochMicroSeconds => $_getI64(1);
  @$pb.TagNumber(2)
  set endEpochMicroSeconds($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndEpochMicroSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndEpochMicroSeconds() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get format => $_getSZ(2);
  @$pb.TagNumber(3)
  set format($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFormat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFormat() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fps => $_getI64(4);
  @$pb.TagNumber(5)
  set fps($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFps() => $_has(4);
  @$pb.TagNumber(5)
  void clearFps() => $_clearField(5);

  @$pb.TagNumber(6)
  CameraSpecification get cameraSpecification => $_getN(5);
  @$pb.TagNumber(6)
  set cameraSpecification(CameraSpecification value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCameraSpecification() => $_has(5);
  @$pb.TagNumber(6)
  void clearCameraSpecification() => $_clearField(6);
  @$pb.TagNumber(6)
  CameraSpecification ensureCameraSpecification() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get identifier => $_getSZ(6);
  @$pb.TagNumber(7)
  set identifier($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdentifier() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdentifier() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$fixnum.Int64> get frameEpochsMicroSeconds => $_getList(7);
}

class GeoCaptureChunk extends $pb.GeneratedMessage {
  factory GeoCaptureChunk({
    $core.String? device,
    GpsCapture? gps,
    OrientationCapture? orientation,
    AccelerationCapture? acceleration,
    AngularVelocityCapture? angularVelocity,
    MagneticFieldCapture? magneticField,
    $core.Iterable<PhotoCapture>? photos,
    VideoCapture? video,
    $core.String? description,
    $core.Iterable<$core.String>? tags,
    $core.String? traceIdentifier,
    $fixnum.Int64? timestampEpochMicroSeconds,
    $fixnum.Int64? chunkIndex,
    $core.bool? isLastChunk,
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (device != null) result.device = device;
    if (gps != null) result.gps = gps;
    if (orientation != null) result.orientation = orientation;
    if (acceleration != null) result.acceleration = acceleration;
    if (angularVelocity != null) result.angularVelocity = angularVelocity;
    if (magneticField != null) result.magneticField = magneticField;
    if (photos != null) result.photos.addAll(photos);
    if (video != null) result.video = video;
    if (description != null) result.description = description;
    if (tags != null) result.tags.addAll(tags);
    if (traceIdentifier != null) result.traceIdentifier = traceIdentifier;
    if (timestampEpochMicroSeconds != null) result.timestampEpochMicroSeconds = timestampEpochMicroSeconds;
    if (chunkIndex != null) result.chunkIndex = chunkIndex;
    if (isLastChunk != null) result.isLastChunk = isLastChunk;
    if (version != null) result.version = version;
    return result;
  }

  GeoCaptureChunk._();

  factory GeoCaptureChunk.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GeoCaptureChunk.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GeoCaptureChunk', package: const $pb.PackageName(_omitMessageNames ? '' : 'street_manata'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'device')
    ..aOM<GpsCapture>(2, _omitFieldNames ? '' : 'gps', subBuilder: GpsCapture.create)
    ..aOM<OrientationCapture>(3, _omitFieldNames ? '' : 'orientation', subBuilder: OrientationCapture.create)
    ..aOM<AccelerationCapture>(4, _omitFieldNames ? '' : 'acceleration', subBuilder: AccelerationCapture.create)
    ..aOM<AngularVelocityCapture>(5, _omitFieldNames ? '' : 'angularVelocity', subBuilder: AngularVelocityCapture.create)
    ..aOM<MagneticFieldCapture>(6, _omitFieldNames ? '' : 'magneticField', subBuilder: MagneticFieldCapture.create)
    ..pc<PhotoCapture>(7, _omitFieldNames ? '' : 'photos', $pb.PbFieldType.PM, subBuilder: PhotoCapture.create)
    ..aOM<VideoCapture>(8, _omitFieldNames ? '' : 'video', subBuilder: VideoCapture.create)
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..pPS(10, _omitFieldNames ? '' : 'tags')
    ..aOS(11, _omitFieldNames ? '' : 'traceIdentifier')
    ..aInt64(12, _omitFieldNames ? '' : 'timestampEpochMicroSeconds')
    ..aInt64(13, _omitFieldNames ? '' : 'chunkIndex')
    ..aOB(14, _omitFieldNames ? '' : 'isLastChunk')
    ..aInt64(15, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoCaptureChunk clone() => GeoCaptureChunk()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoCaptureChunk copyWith(void Function(GeoCaptureChunk) updates) => super.copyWith((message) => updates(message as GeoCaptureChunk)) as GeoCaptureChunk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeoCaptureChunk create() => GeoCaptureChunk._();
  @$core.override
  GeoCaptureChunk createEmptyInstance() => create();
  static $pb.PbList<GeoCaptureChunk> createRepeated() => $pb.PbList<GeoCaptureChunk>();
  @$core.pragma('dart2js:noInline')
  static GeoCaptureChunk getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeoCaptureChunk>(create);
  static GeoCaptureChunk? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get device => $_getSZ(0);
  @$pb.TagNumber(1)
  set device($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDevice() => $_has(0);
  @$pb.TagNumber(1)
  void clearDevice() => $_clearField(1);

  @$pb.TagNumber(2)
  GpsCapture get gps => $_getN(1);
  @$pb.TagNumber(2)
  set gps(GpsCapture value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasGps() => $_has(1);
  @$pb.TagNumber(2)
  void clearGps() => $_clearField(2);
  @$pb.TagNumber(2)
  GpsCapture ensureGps() => $_ensure(1);

  @$pb.TagNumber(3)
  OrientationCapture get orientation => $_getN(2);
  @$pb.TagNumber(3)
  set orientation(OrientationCapture value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOrientation() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrientation() => $_clearField(3);
  @$pb.TagNumber(3)
  OrientationCapture ensureOrientation() => $_ensure(2);

  @$pb.TagNumber(4)
  AccelerationCapture get acceleration => $_getN(3);
  @$pb.TagNumber(4)
  set acceleration(AccelerationCapture value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAcceleration() => $_has(3);
  @$pb.TagNumber(4)
  void clearAcceleration() => $_clearField(4);
  @$pb.TagNumber(4)
  AccelerationCapture ensureAcceleration() => $_ensure(3);

  @$pb.TagNumber(5)
  AngularVelocityCapture get angularVelocity => $_getN(4);
  @$pb.TagNumber(5)
  set angularVelocity(AngularVelocityCapture value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAngularVelocity() => $_has(4);
  @$pb.TagNumber(5)
  void clearAngularVelocity() => $_clearField(5);
  @$pb.TagNumber(5)
  AngularVelocityCapture ensureAngularVelocity() => $_ensure(4);

  @$pb.TagNumber(6)
  MagneticFieldCapture get magneticField => $_getN(5);
  @$pb.TagNumber(6)
  set magneticField(MagneticFieldCapture value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasMagneticField() => $_has(5);
  @$pb.TagNumber(6)
  void clearMagneticField() => $_clearField(6);
  @$pb.TagNumber(6)
  MagneticFieldCapture ensureMagneticField() => $_ensure(5);

  @$pb.TagNumber(7)
  $pb.PbList<PhotoCapture> get photos => $_getList(6);

  @$pb.TagNumber(8)
  VideoCapture get video => $_getN(7);
  @$pb.TagNumber(8)
  set video(VideoCapture value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasVideo() => $_has(7);
  @$pb.TagNumber(8)
  void clearVideo() => $_clearField(8);
  @$pb.TagNumber(8)
  VideoCapture ensureVideo() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get tags => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get traceIdentifier => $_getSZ(10);
  @$pb.TagNumber(11)
  set traceIdentifier($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTraceIdentifier() => $_has(10);
  @$pb.TagNumber(11)
  void clearTraceIdentifier() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get timestampEpochMicroSeconds => $_getI64(11);
  @$pb.TagNumber(12)
  set timestampEpochMicroSeconds($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTimestampEpochMicroSeconds() => $_has(11);
  @$pb.TagNumber(12)
  void clearTimestampEpochMicroSeconds() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get chunkIndex => $_getI64(12);
  @$pb.TagNumber(13)
  set chunkIndex($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasChunkIndex() => $_has(12);
  @$pb.TagNumber(13)
  void clearChunkIndex() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get isLastChunk => $_getBF(13);
  @$pb.TagNumber(14)
  set isLastChunk($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsLastChunk() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsLastChunk() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get version => $_getI64(14);
  @$pb.TagNumber(15)
  set version($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasVersion() => $_has(14);
  @$pb.TagNumber(15)
  void clearVersion() => $_clearField(15);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
