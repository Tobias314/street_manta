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
    {'1': 'position_accuracy', '3': 4, '4': 1, '5': 2, '9': 0, '10': 'positionAccuracy', '17': true},
    {'1': 'elevation_accuracy', '3': 5, '4': 1, '5': 2, '9': 1, '10': 'elevationAccuracy', '17': true},
    {'1': 'speed', '3': 6, '4': 1, '5': 2, '9': 2, '10': 'speed', '17': true},
    {'1': 'speed_accuracy', '3': 7, '4': 1, '5': 2, '9': 3, '10': 'speedAccuracy', '17': true},
    {'1': 'heading', '3': 8, '4': 1, '5': 2, '9': 4, '10': 'heading', '17': true},
    {'1': 'heading_accuracy', '3': 9, '4': 1, '5': 2, '9': 5, '10': 'headingAccuracy', '17': true},
  ],
  '8': [
    {'1': '_position_accuracy'},
    {'1': '_elevation_accuracy'},
    {'1': '_speed'},
    {'1': '_speed_accuracy'},
    {'1': '_heading'},
    {'1': '_heading_accuracy'},
  ],
};

/// Descriptor for `GpsPosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsPositionDescriptor = $convert.base64Decode(
    'CgtHcHNQb3NpdGlvbhIcCglsb25naXR1ZGUYASABKAJSCWxvbmdpdHVkZRIaCghsYXRpdHVkZR'
    'gCIAEoAlIIbGF0aXR1ZGUSHAoJZWxldmF0aW9uGAMgASgCUgllbGV2YXRpb24SMAoRcG9zaXRp'
    'b25fYWNjdXJhY3kYBCABKAJIAFIQcG9zaXRpb25BY2N1cmFjeYgBARIyChJlbGV2YXRpb25fYW'
    'NjdXJhY3kYBSABKAJIAVIRZWxldmF0aW9uQWNjdXJhY3mIAQESGQoFc3BlZWQYBiABKAJIAlIF'
    'c3BlZWSIAQESKgoOc3BlZWRfYWNjdXJhY3kYByABKAJIA1INc3BlZWRBY2N1cmFjeYgBARIdCg'
    'doZWFkaW5nGAggASgCSARSB2hlYWRpbmeIAQESLgoQaGVhZGluZ19hY2N1cmFjeRgJIAEoAkgF'
    'Ug9oZWFkaW5nQWNjdXJhY3mIAQFCFAoSX3Bvc2l0aW9uX2FjY3VyYWN5QhUKE19lbGV2YXRpb2'
    '5fYWNjdXJhY3lCCAoGX3NwZWVkQhEKD19zcGVlZF9hY2N1cmFjeUIKCghfaGVhZGluZ0ITChFf'
    'aGVhZGluZ19hY2N1cmFjeQ==');

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

@$core.Deprecated('Use accelerationDescriptor instead')
const Acceleration$json = {
  '1': 'Acceleration',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `Acceleration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accelerationDescriptor = $convert.base64Decode(
    'CgxBY2NlbGVyYXRpb24SDAoBeBgBIAEoAlIBeBIMCgF5GAIgASgCUgF5EgwKAXoYAyABKAJSAX'
    'o=');

@$core.Deprecated('Use angularVelocityDescriptor instead')
const AngularVelocity$json = {
  '1': 'AngularVelocity',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `AngularVelocity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List angularVelocityDescriptor = $convert.base64Decode(
    'Cg9Bbmd1bGFyVmVsb2NpdHkSDAoBeBgBIAEoAlIBeBIMCgF5GAIgASgCUgF5EgwKAXoYAyABKA'
    'JSAXo=');

@$core.Deprecated('Use magneticFieldDescriptor instead')
const MagneticField$json = {
  '1': 'MagneticField',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
  ],
};

/// Descriptor for `MagneticField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magneticFieldDescriptor = $convert.base64Decode(
    'Cg1NYWduZXRpY0ZpZWxkEgwKAXgYASABKAJSAXgSDAoBeRgCIAEoAlIBeRIMCgF6GAMgASgCUg'
    'F6');

@$core.Deprecated('Use orientationCaptureDescriptor instead')
const OrientationCapture$json = {
  '1': 'OrientationCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'orientation', '3': 2, '4': 1, '5': 11, '6': '.street_manata.Orientation', '10': 'orientation'},
  ],
};

/// Descriptor for `OrientationCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orientationCaptureDescriptor = $convert.base64Decode(
    'ChJPcmllbnRhdGlvbkNhcHR1cmUSLgoTZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IRZXBvY2'
    'hNaWNyb1NlY29uZHMSPAoLb3JpZW50YXRpb24YAiABKAsyGi5zdHJlZXRfbWFuYXRhLk9yaWVu'
    'dGF0aW9uUgtvcmllbnRhdGlvbg==');

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

@$core.Deprecated('Use accelerationCaptureDescriptor instead')
const AccelerationCapture$json = {
  '1': 'AccelerationCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'acceleration', '3': 2, '4': 1, '5': 11, '6': '.street_manata.Acceleration', '10': 'acceleration'},
  ],
};

/// Descriptor for `AccelerationCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accelerationCaptureDescriptor = $convert.base64Decode(
    'ChNBY2NlbGVyYXRpb25DYXB0dXJlEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEWVwb2'
    'NoTWljcm9TZWNvbmRzEj8KDGFjY2VsZXJhdGlvbhgCIAEoCzIbLnN0cmVldF9tYW5hdGEuQWNj'
    'ZWxlcmF0aW9uUgxhY2NlbGVyYXRpb24=');

@$core.Deprecated('Use angularVelocityCaptureDescriptor instead')
const AngularVelocityCapture$json = {
  '1': 'AngularVelocityCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'angular_velocity', '3': 2, '4': 1, '5': 11, '6': '.street_manata.AngularVelocity', '10': 'angularVelocity'},
  ],
};

/// Descriptor for `AngularVelocityCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List angularVelocityCaptureDescriptor = $convert.base64Decode(
    'ChZBbmd1bGFyVmVsb2NpdHlDYXB0dXJlEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEW'
    'Vwb2NoTWljcm9TZWNvbmRzEkkKEGFuZ3VsYXJfdmVsb2NpdHkYAiABKAsyHi5zdHJlZXRfbWFu'
    'YXRhLkFuZ3VsYXJWZWxvY2l0eVIPYW5ndWxhclZlbG9jaXR5');

@$core.Deprecated('Use magneticFieldCaptureDescriptor instead')
const MagneticFieldCapture$json = {
  '1': 'MagneticFieldCapture',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'magnetic_field', '3': 2, '4': 1, '5': 11, '6': '.street_manata.MagneticField', '10': 'magneticField'},
  ],
};

/// Descriptor for `MagneticFieldCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magneticFieldCaptureDescriptor = $convert.base64Decode(
    'ChRNYWduZXRpY0ZpZWxkQ2FwdHVyZRIuChNlcG9jaF9taWNyb19zZWNvbmRzGAEgASgDUhFlcG'
    '9jaE1pY3JvU2Vjb25kcxJDCg5tYWduZXRpY19maWVsZBgCIAEoCzIcLnN0cmVldF9tYW5hdGEu'
    'TWFnbmV0aWNGaWVsZFINbWFnbmV0aWNGaWVsZA==');

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
    {'1': 'file', '3': 3, '4': 1, '5': 9, '10': 'file'},
    {'1': 'fps', '3': 4, '4': 1, '5': 3, '9': 0, '10': 'fps', '17': true},
    {'1': 'camera_specification', '3': 5, '4': 1, '5': 11, '6': '.street_manata.CameraSpecification', '9': 1, '10': 'cameraSpecification', '17': true},
  ],
  '8': [
    {'1': '_fps'},
    {'1': '_camera_specification'},
  ],
};

/// Descriptor for `VideoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoCaptureDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NhcHR1cmUSOQoZc3RhcnRfZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IWc3Rhcn'
    'RFcG9jaE1pY3JvU2Vjb25kcxI1ChdlbmRfZXBvY2hfbWljcm9fc2Vjb25kcxgCIAEoA1IUZW5k'
    'RXBvY2hNaWNyb1NlY29uZHMSEgoEZmlsZRgDIAEoCVIEZmlsZRIVCgNmcHMYBCABKANIAFIDZn'
    'BziAEBEloKFGNhbWVyYV9zcGVjaWZpY2F0aW9uGAUgASgLMiIuc3RyZWV0X21hbmF0YS5DYW1l'
    'cmFTcGVjaWZpY2F0aW9uSAFSE2NhbWVyYVNwZWNpZmljYXRpb26IAQFCBgoEX2Zwc0IXChVfY2'
    'FtZXJhX3NwZWNpZmljYXRpb24=');

@$core.Deprecated('Use geoCaptureDescriptor instead')
const GeoCapture$json = {
  '1': 'GeoCapture',
  '2': [
    {'1': 'device', '3': 1, '4': 1, '5': 9, '10': 'device'},
    {'1': 'gps', '3': 2, '4': 3, '5': 11, '6': '.street_manata.GpsCapture', '10': 'gps'},
    {'1': 'orientation', '3': 3, '4': 3, '5': 11, '6': '.street_manata.OrientationCapture', '10': 'orientation'},
    {'1': 'acceleration', '3': 4, '4': 3, '5': 11, '6': '.street_manata.AccelerationCapture', '10': 'acceleration'},
    {'1': 'angular_velocity', '3': 5, '4': 3, '5': 11, '6': '.street_manata.AngularVelocityCapture', '10': 'angularVelocity'},
    {'1': 'magnetic_field', '3': 6, '4': 3, '5': 11, '6': '.street_manata.MagneticFieldCapture', '10': 'magneticField'},
    {'1': 'photos', '3': 7, '4': 3, '5': 11, '6': '.street_manata.PhotoCapture', '10': 'photos'},
    {'1': 'videos', '3': 8, '4': 3, '5': 11, '6': '.street_manata.VideoCapture', '10': 'videos'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
    {'1': 'tags', '3': 10, '4': 3, '5': 9, '10': 'tags'},
  ],
  '8': [
    {'1': '_description'},
  ],
};

/// Descriptor for `GeoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geoCaptureDescriptor = $convert.base64Decode(
    'CgpHZW9DYXB0dXJlEhYKBmRldmljZRgBIAEoCVIGZGV2aWNlEisKA2dwcxgCIAMoCzIZLnN0cm'
    'VldF9tYW5hdGEuR3BzQ2FwdHVyZVIDZ3BzEkMKC29yaWVudGF0aW9uGAMgAygLMiEuc3RyZWV0'
    'X21hbmF0YS5PcmllbnRhdGlvbkNhcHR1cmVSC29yaWVudGF0aW9uEkYKDGFjY2VsZXJhdGlvbh'
    'gEIAMoCzIiLnN0cmVldF9tYW5hdGEuQWNjZWxlcmF0aW9uQ2FwdHVyZVIMYWNjZWxlcmF0aW9u'
    'ElAKEGFuZ3VsYXJfdmVsb2NpdHkYBSADKAsyJS5zdHJlZXRfbWFuYXRhLkFuZ3VsYXJWZWxvY2'
    'l0eUNhcHR1cmVSD2FuZ3VsYXJWZWxvY2l0eRJKCg5tYWduZXRpY19maWVsZBgGIAMoCzIjLnN0'
    'cmVldF9tYW5hdGEuTWFnbmV0aWNGaWVsZENhcHR1cmVSDW1hZ25ldGljRmllbGQSMwoGcGhvdG'
    '9zGAcgAygLMhsuc3RyZWV0X21hbmF0YS5QaG90b0NhcHR1cmVSBnBob3RvcxIzCgZ2aWRlb3MY'
    'CCADKAsyGy5zdHJlZXRfbWFuYXRhLlZpZGVvQ2FwdHVyZVIGdmlkZW9zEiUKC2Rlc2NyaXB0aW'
    '9uGAkgASgJSABSC2Rlc2NyaXB0aW9uiAEBEhIKBHRhZ3MYCiADKAlSBHRhZ3NCDgoMX2Rlc2Ny'
    'aXB0aW9u');

