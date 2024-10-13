//
//  Generated code. Do not modify.
//  source: protobufs/sensors.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gpsDescriptor instead')
const Gps$json = {
  '1': 'Gps',
  '2': [
    {'1': 'time', '3': 1, '4': 1, '5': 3, '10': 'time'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 2, '10': 'longitude'},
    {'1': 'latitude', '3': 3, '4': 1, '5': 2, '10': 'latitude'},
    {'1': 'height', '3': 4, '4': 1, '5': 2, '10': 'height'},
  ],
};

/// Descriptor for `Gps`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsDescriptor = $convert.base64Decode(
    'CgNHcHMSEgoEdGltZRgBIAEoA1IEdGltZRIcCglsb25naXR1ZGUYAiABKAJSCWxvbmdpdHVkZR'
    'IaCghsYXRpdHVkZRgDIAEoAlIIbGF0aXR1ZGUSFgoGaGVpZ2h0GAQgASgCUgZoZWlnaHQ=');

@$core.Deprecated('Use imuDescriptor instead')
const Imu$json = {
  '1': 'Imu',
  '2': [
    {'1': 'time', '3': 1, '4': 1, '5': 3, '10': 'time'},
    {'1': 'x', '3': 2, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 4, '4': 1, '5': 2, '10': 'z'},
    {'1': 'w', '3': 5, '4': 1, '5': 2, '10': 'w'},
  ],
};

/// Descriptor for `Imu`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imuDescriptor = $convert.base64Decode(
    'CgNJbXUSEgoEdGltZRgBIAEoA1IEdGltZRIMCgF4GAIgASgCUgF4EgwKAXkYAyABKAJSAXkSDA'
    'oBehgEIAEoAlIBehIMCgF3GAUgASgCUgF3');

@$core.Deprecated('Use photoDescriptor instead')
const Photo$json = {
  '1': 'Photo',
  '2': [
    {'1': 'time', '3': 1, '4': 1, '5': 3, '10': 'time'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Photo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoDescriptor = $convert.base64Decode(
    'CgVQaG90bxISCgR0aW1lGAEgASgDUgR0aW1lEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use videoDescriptor instead')
const Video$json = {
  '1': 'Video',
  '2': [
    {'1': 'start_time', '3': 1, '4': 1, '5': 3, '10': 'startTime'},
    {'1': 'end_time', '3': 2, '4': 1, '5': 3, '10': 'endTime'},
    {'1': 'fps', '3': 3, '4': 1, '5': 3, '10': 'fps'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Video`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDescriptor = $convert.base64Decode(
    'CgVWaWRlbxIdCgpzdGFydF90aW1lGAEgASgDUglzdGFydFRpbWUSGQoIZW5kX3RpbWUYAiABKA'
    'NSB2VuZFRpbWUSEAoDZnBzGAMgASgDUgNmcHMSEgoEbmFtZRgEIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use sensorDataDescriptor instead')
const SensorData$json = {
  '1': 'SensorData',
  '2': [
    {'1': 'verion', '3': 1, '4': 1, '5': 5, '10': 'verion'},
    {'1': 'device', '3': 2, '4': 1, '5': 9, '10': 'device'},
    {'1': 'gps', '3': 3, '4': 3, '5': 11, '6': '.street_manata.Gps', '10': 'gps'},
    {'1': 'imu', '3': 4, '4': 3, '5': 11, '6': '.street_manata.Imu', '10': 'imu'},
    {'1': 'camera_index', '3': 5, '4': 1, '5': 5, '10': 'cameraIndex'},
    {'1': 'photos', '3': 6, '4': 3, '5': 11, '6': '.street_manata.Photo', '10': 'photos'},
    {'1': 'video', '3': 7, '4': 1, '5': 11, '6': '.street_manata.Video', '10': 'video'},
  ],
};

/// Descriptor for `SensorData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorDataDescriptor = $convert.base64Decode(
    'CgpTZW5zb3JEYXRhEhYKBnZlcmlvbhgBIAEoBVIGdmVyaW9uEhYKBmRldmljZRgCIAEoCVIGZG'
    'V2aWNlEiQKA2dwcxgDIAMoCzISLnN0cmVldF9tYW5hdGEuR3BzUgNncHMSJAoDaW11GAQgAygL'
    'MhIuc3RyZWV0X21hbmF0YS5JbXVSA2ltdRIhCgxjYW1lcmFfaW5kZXgYBSABKAVSC2NhbWVyYU'
    'luZGV4EiwKBnBob3RvcxgGIAMoCzIULnN0cmVldF9tYW5hdGEuUGhvdG9SBnBob3RvcxIqCgV2'
    'aWRlbxgHIAEoCzIULnN0cmVldF9tYW5hdGEuVmlkZW9SBXZpZGVv');

