//
//  Generated code. Do not modify.
//  source: protobufs/geo_capture.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gpsPositionDescriptor instead')
const GpsPosition$json = {
  '1': 'GpsPosition',
  '2': [
    {'1': 'longitude', '3': 1, '4': 1, '5': 2, '10': 'longitude'},
    {'1': 'latitude', '3': 2, '4': 1, '5': 2, '10': 'latitude'},
    {'1': 'elevation', '3': 3, '4': 1, '5': 2, '10': 'elevation'},
  ],
};

/// Descriptor for `GpsPosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsPositionDescriptor = $convert.base64Decode(
    'CgtHcHNQb3NpdGlvbhIcCglsb25naXR1ZGUYASABKAJSCWxvbmdpdHVkZRIaCghsYXRpdHVkZR'
    'gCIAEoAlIIbGF0aXR1ZGUSHAoJZWxldmF0aW9uGAMgASgCUgllbGV2YXRpb24=');

@$core.Deprecated('Use orientationDescriptor instead')
const Orientation$json = {
  '1': 'Orientation',
  '2': [
    {'1': 'roll', '3': 1, '4': 1, '5': 2, '10': 'roll'},
    {'1': 'pitch', '3': 2, '4': 1, '5': 2, '10': 'pitch'},
    {'1': 'yaw', '3': 3, '4': 1, '5': 2, '10': 'yaw'},
  ],
};

/// Descriptor for `Orientation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orientationDescriptor = $convert.base64Decode(
    'CgtPcmllbnRhdGlvbhISCgRyb2xsGAEgASgCUgRyb2xsEhQKBXBpdGNoGAIgASgCUgVwaXRjaB'
    'IQCgN5YXcYAyABKAJSA3lhdw==');

@$core.Deprecated('Use gpsCaptureDescriptor instead')
const GpsCapture$json = {
  '1': 'GpsCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.street_manata.GpsPosition', '10': 'position'},
  ],
};

/// Descriptor for `GpsCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsCaptureDescriptor = $convert.base64Decode(
    'CgpHcHNDYXB0dXJlEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEWVwb2NoTWljcm9TZW'
    'NvbmRzEjYKCHBvc2l0aW9uGAIgASgLMhouc3RyZWV0X21hbmF0YS5HcHNQb3NpdGlvblIIcG9z'
    'aXRpb24=');

@$core.Deprecated('Use imuCaptureDescriptor instead')
const ImuCapture$json = {
  '1': 'ImuCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'x', '3': 2, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 4, '4': 1, '5': 2, '10': 'z'},
    {'1': 'w', '3': 5, '4': 1, '5': 2, '10': 'w'},
  ],
};

/// Descriptor for `ImuCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imuCaptureDescriptor = $convert.base64Decode(
    'CgpJbXVDYXB0dXJlEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEWVwb2NoTWljcm9TZW'
    'NvbmRzEgwKAXgYAiABKAJSAXgSDAoBeRgDIAEoAlIBeRIMCgF6GAQgASgCUgF6EgwKAXcYBSAB'
    'KAJSAXc=');

@$core.Deprecated('Use cameraSpecificationDescriptor instead')
const CameraSpecification$json = {
  '1': 'CameraSpecification',
  '2': [
    {'1': 'camera_index', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'cameraIndex', '17': true},
    {'1': 'focal_length', '3': 2, '4': 1, '5': 2, '9': 1, '10': 'focalLength', '17': true},
    {'1': 'exposure_time', '3': 3, '4': 1, '5': 2, '9': 2, '10': 'exposureTime', '17': true},
  ],
  '8': [
    {'1': '_camera_index'},
    {'1': '_focal_length'},
    {'1': '_exposure_time'},
  ],
};

/// Descriptor for `CameraSpecification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraSpecificationDescriptor = $convert.base64Decode(
    'ChNDYW1lcmFTcGVjaWZpY2F0aW9uEiYKDGNhbWVyYV9pbmRleBgBIAEoBUgAUgtjYW1lcmFJbm'
    'RleIgBARImCgxmb2NhbF9sZW5ndGgYAiABKAJIAVILZm9jYWxMZW5ndGiIAQESKAoNZXhwb3N1'
    'cmVfdGltZRgDIAEoAkgCUgxleHBvc3VyZVRpbWWIAQFCDwoNX2NhbWVyYV9pbmRleEIPCg1fZm'
    '9jYWxfbGVuZ3RoQhAKDl9leHBvc3VyZV90aW1l');

@$core.Deprecated('Use photoCaptureDescriptor instead')
const PhotoCapture$json = {
  '1': 'PhotoCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'file', '3': 2, '4': 1, '5': 9, '10': 'file'},
    {'1': 'camera_specification', '3': 3, '4': 1, '5': 11, '6': '.street_manata.CameraSpecification', '9': 0, '10': 'cameraSpecification', '17': true},
    {'1': 'gps_position', '3': 4, '4': 1, '5': 11, '6': '.street_manata.GpsPosition', '9': 1, '10': 'gpsPosition', '17': true},
    {'1': 'orientation', '3': 5, '4': 1, '5': 11, '6': '.street_manata.Orientation', '9': 2, '10': 'orientation', '17': true},
  ],
  '8': [
    {'1': '_camera_specification'},
    {'1': '_gps_position'},
    {'1': '_orientation'},
  ],
};

/// Descriptor for `PhotoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoCaptureDescriptor = $convert.base64Decode(
    'CgxQaG90b0NhcHR1cmUSLgoTZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IRZXBvY2hNaWNyb1'
    'NlY29uZHMSEgoEZmlsZRgCIAEoCVIEZmlsZRJaChRjYW1lcmFfc3BlY2lmaWNhdGlvbhgDIAEo'
    'CzIiLnN0cmVldF9tYW5hdGEuQ2FtZXJhU3BlY2lmaWNhdGlvbkgAUhNjYW1lcmFTcGVjaWZpY2'
    'F0aW9uiAEBEkIKDGdwc19wb3NpdGlvbhgEIAEoCzIaLnN0cmVldF9tYW5hdGEuR3BzUG9zaXRp'
    'b25IAVILZ3BzUG9zaXRpb26IAQESQQoLb3JpZW50YXRpb24YBSABKAsyGi5zdHJlZXRfbWFuYX'
    'RhLk9yaWVudGF0aW9uSAJSC29yaWVudGF0aW9uiAEBQhcKFV9jYW1lcmFfc3BlY2lmaWNhdGlv'
    'bkIPCg1fZ3BzX3Bvc2l0aW9uQg4KDF9vcmllbnRhdGlvbg==');

@$core.Deprecated('Use videoCaptureDescriptor instead')
const VideoCapture$json = {
  '1': 'VideoCapture',
  '2': [
    {'1': 'start_epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'startEpochMicroSeconds'},
    {'1': 'end_epoch_micro_seconds', '3': 2, '4': 1, '5': 3, '10': 'endEpochMicroSeconds'},
    {'1': 'fps', '3': 3, '4': 1, '5': 3, '10': 'fps'},
    {'1': 'file', '3': 4, '4': 1, '5': 9, '10': 'file'},
    {'1': 'camera_specification', '3': 5, '4': 1, '5': 11, '6': '.street_manata.CameraSpecification', '10': 'cameraSpecification'},
  ],
};

/// Descriptor for `VideoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoCaptureDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NhcHR1cmUSOQoZc3RhcnRfZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IWc3Rhcn'
    'RFcG9jaE1pY3JvU2Vjb25kcxI1ChdlbmRfZXBvY2hfbWljcm9fc2Vjb25kcxgCIAEoA1IUZW5k'
    'RXBvY2hNaWNyb1NlY29uZHMSEAoDZnBzGAMgASgDUgNmcHMSEgoEZmlsZRgEIAEoCVIEZmlsZR'
    'JVChRjYW1lcmFfc3BlY2lmaWNhdGlvbhgFIAEoCzIiLnN0cmVldF9tYW5hdGEuQ2FtZXJhU3Bl'
    'Y2lmaWNhdGlvblITY2FtZXJhU3BlY2lmaWNhdGlvbg==');

@$core.Deprecated('Use geoCaptureDescriptor instead')
const GeoCapture$json = {
  '1': 'GeoCapture',
  '2': [
    {'1': 'device', '3': 1, '4': 1, '5': 9, '10': 'device'},
    {'1': 'gps', '3': 2, '4': 3, '5': 11, '6': '.street_manata.GpsCapture', '10': 'gps'},
    {'1': 'imu', '3': 3, '4': 3, '5': 11, '6': '.street_manata.ImuCapture', '10': 'imu'},
    {'1': 'photos', '3': 4, '4': 3, '5': 11, '6': '.street_manata.PhotoCapture', '10': 'photos'},
    {'1': 'videos', '3': 5, '4': 3, '5': 11, '6': '.street_manata.VideoCapture', '10': 'videos'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
    {'1': 'tags', '3': 7, '4': 3, '5': 9, '10': 'tags'},
  ],
  '8': [
    {'1': '_description'},
  ],
};

/// Descriptor for `GeoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geoCaptureDescriptor = $convert.base64Decode(
    'CgpHZW9DYXB0dXJlEhYKBmRldmljZRgBIAEoCVIGZGV2aWNlEisKA2dwcxgCIAMoCzIZLnN0cm'
    'VldF9tYW5hdGEuR3BzQ2FwdHVyZVIDZ3BzEisKA2ltdRgDIAMoCzIZLnN0cmVldF9tYW5hdGEu'
    'SW11Q2FwdHVyZVIDaW11EjMKBnBob3RvcxgEIAMoCzIbLnN0cmVldF9tYW5hdGEuUGhvdG9DYX'
    'B0dXJlUgZwaG90b3MSMwoGdmlkZW9zGAUgAygLMhsuc3RyZWV0X21hbmF0YS5WaWRlb0NhcHR1'
    'cmVSBnZpZGVvcxIlCgtkZXNjcmlwdGlvbhgGIAEoCUgAUgtkZXNjcmlwdGlvbogBARISCgR0YW'
    'dzGAcgAygJUgR0YWdzQg4KDF9kZXNjcmlwdGlvbg==');

