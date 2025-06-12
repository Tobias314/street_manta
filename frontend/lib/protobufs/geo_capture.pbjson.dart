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

@$core.Deprecated('Use orientationReadingDescriptor instead')
const OrientationReading$json = {
  '1': 'OrientationReading',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'orientation', '3': 2, '4': 1, '5': 11, '6': '.street_manata.Orientation', '10': 'orientation'},
  ],
};

/// Descriptor for `OrientationReading`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orientationReadingDescriptor = $convert.base64Decode(
    'ChJPcmllbnRhdGlvblJlYWRpbmcSLgoTZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IRZXBvY2'
    'hNaWNyb1NlY29uZHMSPAoLb3JpZW50YXRpb24YAiABKAsyGi5zdHJlZXRfbWFuYXRhLk9yaWVu'
    'dGF0aW9uUgtvcmllbnRhdGlvbg==');

@$core.Deprecated('Use gpsReadingDescriptor instead')
const GpsReading$json = {
  '1': 'GpsReading',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.street_manata.GpsPosition', '10': 'position'},
  ],
};

/// Descriptor for `GpsReading`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsReadingDescriptor = $convert.base64Decode(
    'CgpHcHNSZWFkaW5nEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEWVwb2NoTWljcm9TZW'
    'NvbmRzEjYKCHBvc2l0aW9uGAIgASgLMhouc3RyZWV0X21hbmF0YS5HcHNQb3NpdGlvblIIcG9z'
    'aXRpb24=');

@$core.Deprecated('Use accelerationReadingDescriptor instead')
const AccelerationReading$json = {
  '1': 'AccelerationReading',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'acceleration', '3': 2, '4': 1, '5': 11, '6': '.street_manata.Acceleration', '10': 'acceleration'},
  ],
};

/// Descriptor for `AccelerationReading`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accelerationReadingDescriptor = $convert.base64Decode(
    'ChNBY2NlbGVyYXRpb25SZWFkaW5nEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEWVwb2'
    'NoTWljcm9TZWNvbmRzEj8KDGFjY2VsZXJhdGlvbhgCIAEoCzIbLnN0cmVldF9tYW5hdGEuQWNj'
    'ZWxlcmF0aW9uUgxhY2NlbGVyYXRpb24=');

@$core.Deprecated('Use angularVelocityReadingDescriptor instead')
const AngularVelocityReading$json = {
  '1': 'AngularVelocityReading',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'angular_velocity', '3': 2, '4': 1, '5': 11, '6': '.street_manata.AngularVelocity', '10': 'angularVelocity'},
  ],
};

/// Descriptor for `AngularVelocityReading`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List angularVelocityReadingDescriptor = $convert.base64Decode(
    'ChZBbmd1bGFyVmVsb2NpdHlSZWFkaW5nEi4KE2Vwb2NoX21pY3JvX3NlY29uZHMYASABKANSEW'
    'Vwb2NoTWljcm9TZWNvbmRzEkkKEGFuZ3VsYXJfdmVsb2NpdHkYAiABKAsyHi5zdHJlZXRfbWFu'
    'YXRhLkFuZ3VsYXJWZWxvY2l0eVIPYW5ndWxhclZlbG9jaXR5');

@$core.Deprecated('Use magneticFieldReadingDescriptor instead')
const MagneticFieldReading$json = {
  '1': 'MagneticFieldReading',
  '2': [
    {'1': 'epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'epochMicroSeconds'},
    {'1': 'magnetic_field', '3': 2, '4': 1, '5': 11, '6': '.street_manata.MagneticField', '10': 'magneticField'},
  ],
};

/// Descriptor for `MagneticFieldReading`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magneticFieldReadingDescriptor = $convert.base64Decode(
    'ChRNYWduZXRpY0ZpZWxkUmVhZGluZxIuChNlcG9jaF9taWNyb19zZWNvbmRzGAEgASgDUhFlcG'
    '9jaE1pY3JvU2Vjb25kcxJDCg5tYWduZXRpY19maWVsZBgCIAEoCzIcLnN0cmVldF9tYW5hdGEu'
    'TWFnbmV0aWNGaWVsZFINbWFnbmV0aWNGaWVsZA==');

@$core.Deprecated('Use orientationCaptureDescriptor instead')
const OrientationCapture$json = {
  '1': 'OrientationCapture',
  '2': [
    {'1': 'readings', '3': 1, '4': 3, '5': 11, '6': '.street_manata.OrientationReading', '10': 'readings'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_identifier'},
  ],
};

/// Descriptor for `OrientationCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List orientationCaptureDescriptor = $convert.base64Decode(
    'ChJPcmllbnRhdGlvbkNhcHR1cmUSPQoIcmVhZGluZ3MYASADKAsyIS5zdHJlZXRfbWFuYXRhLk'
    '9yaWVudGF0aW9uUmVhZGluZ1IIcmVhZGluZ3MSIwoKaWRlbnRpZmllchgCIAEoCUgAUgppZGVu'
    'dGlmaWVyiAEBQg0KC19pZGVudGlmaWVy');

@$core.Deprecated('Use gpsCaptureDescriptor instead')
const GpsCapture$json = {
  '1': 'GpsCapture',
  '2': [
    {'1': 'readings', '3': 1, '4': 3, '5': 11, '6': '.street_manata.GpsReading', '10': 'readings'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_identifier'},
  ],
};

/// Descriptor for `GpsCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gpsCaptureDescriptor = $convert.base64Decode(
    'CgpHcHNDYXB0dXJlEjUKCHJlYWRpbmdzGAEgAygLMhkuc3RyZWV0X21hbmF0YS5HcHNSZWFkaW'
    '5nUghyZWFkaW5ncxIjCgppZGVudGlmaWVyGAIgASgJSABSCmlkZW50aWZpZXKIAQFCDQoLX2lk'
    'ZW50aWZpZXI=');

@$core.Deprecated('Use accelerationCaptureDescriptor instead')
const AccelerationCapture$json = {
  '1': 'AccelerationCapture',
  '2': [
    {'1': 'readings', '3': 1, '4': 3, '5': 11, '6': '.street_manata.AccelerationReading', '10': 'readings'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_identifier'},
  ],
};

/// Descriptor for `AccelerationCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accelerationCaptureDescriptor = $convert.base64Decode(
    'ChNBY2NlbGVyYXRpb25DYXB0dXJlEj4KCHJlYWRpbmdzGAEgAygLMiIuc3RyZWV0X21hbmF0YS'
    '5BY2NlbGVyYXRpb25SZWFkaW5nUghyZWFkaW5ncxIjCgppZGVudGlmaWVyGAIgASgJSABSCmlk'
    'ZW50aWZpZXKIAQFCDQoLX2lkZW50aWZpZXI=');

@$core.Deprecated('Use angularVelocityCaptureDescriptor instead')
const AngularVelocityCapture$json = {
  '1': 'AngularVelocityCapture',
  '2': [
    {'1': 'readings', '3': 1, '4': 3, '5': 11, '6': '.street_manata.AngularVelocityReading', '10': 'readings'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_identifier'},
  ],
};

/// Descriptor for `AngularVelocityCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List angularVelocityCaptureDescriptor = $convert.base64Decode(
    'ChZBbmd1bGFyVmVsb2NpdHlDYXB0dXJlEkEKCHJlYWRpbmdzGAEgAygLMiUuc3RyZWV0X21hbm'
    'F0YS5Bbmd1bGFyVmVsb2NpdHlSZWFkaW5nUghyZWFkaW5ncxIjCgppZGVudGlmaWVyGAIgASgJ'
    'SABSCmlkZW50aWZpZXKIAQFCDQoLX2lkZW50aWZpZXI=');

@$core.Deprecated('Use magneticFieldCaptureDescriptor instead')
const MagneticFieldCapture$json = {
  '1': 'MagneticFieldCapture',
  '2': [
    {'1': 'readings', '3': 1, '4': 3, '5': 11, '6': '.street_manata.MagneticFieldReading', '10': 'readings'},
    {'1': 'identifier', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_identifier'},
  ],
};

/// Descriptor for `MagneticFieldCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List magneticFieldCaptureDescriptor = $convert.base64Decode(
    'ChRNYWduZXRpY0ZpZWxkQ2FwdHVyZRI/CghyZWFkaW5ncxgBIAMoCzIjLnN0cmVldF9tYW5hdG'
    'EuTWFnbmV0aWNGaWVsZFJlYWRpbmdSCHJlYWRpbmdzEiMKCmlkZW50aWZpZXIYAiABKAlIAFIK'
    'aWRlbnRpZmllcogBAUINCgtfaWRlbnRpZmllcg==');

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
    {'1': 'format', '3': 2, '4': 1, '5': 9, '10': 'format'},
    {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
    {'1': 'gps', '3': 4, '4': 1, '5': 11, '6': '.street_manata.GpsReading', '10': 'gps'},
    {'1': 'orientation', '3': 5, '4': 1, '5': 11, '6': '.street_manata.OrientationReading', '10': 'orientation'},
    {'1': 'camera_specification', '3': 6, '4': 1, '5': 11, '6': '.street_manata.CameraSpecification', '9': 0, '10': 'cameraSpecification', '17': true},
    {'1': 'identifier', '3': 7, '4': 1, '5': 9, '9': 1, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_camera_specification'},
    {'1': '_identifier'},
  ],
};

/// Descriptor for `PhotoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoCaptureDescriptor = $convert.base64Decode(
    'CgxQaG90b0NhcHR1cmUSLgoTZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IRZXBvY2hNaWNyb1'
    'NlY29uZHMSFgoGZm9ybWF0GAIgASgJUgZmb3JtYXQSEgoEZGF0YRgDIAEoDFIEZGF0YRIrCgNn'
    'cHMYBCABKAsyGS5zdHJlZXRfbWFuYXRhLkdwc1JlYWRpbmdSA2dwcxJDCgtvcmllbnRhdGlvbh'
    'gFIAEoCzIhLnN0cmVldF9tYW5hdGEuT3JpZW50YXRpb25SZWFkaW5nUgtvcmllbnRhdGlvbhJa'
    'ChRjYW1lcmFfc3BlY2lmaWNhdGlvbhgGIAEoCzIiLnN0cmVldF9tYW5hdGEuQ2FtZXJhU3BlY2'
    'lmaWNhdGlvbkgAUhNjYW1lcmFTcGVjaWZpY2F0aW9uiAEBEiMKCmlkZW50aWZpZXIYByABKAlI'
    'AVIKaWRlbnRpZmllcogBAUIXChVfY2FtZXJhX3NwZWNpZmljYXRpb25CDQoLX2lkZW50aWZpZX'
    'I=');

@$core.Deprecated('Use videoCaptureDescriptor instead')
const VideoCapture$json = {
  '1': 'VideoCapture',
  '2': [
    {'1': 'start_epoch_micro_seconds', '3': 1, '4': 1, '5': 3, '10': 'startEpochMicroSeconds'},
    {'1': 'format', '3': 3, '4': 1, '5': 9, '10': 'format'},
    {'1': 'data', '3': 4, '4': 1, '5': 12, '10': 'data'},
    {'1': 'fps', '3': 5, '4': 1, '5': 3, '9': 0, '10': 'fps', '17': true},
    {'1': 'end_epoch_micro_seconds', '3': 2, '4': 1, '5': 3, '9': 1, '10': 'endEpochMicroSeconds', '17': true},
    {'1': 'frame_epochs_micro_seconds', '3': 8, '4': 3, '5': 3, '10': 'frameEpochsMicroSeconds'},
    {'1': 'camera_specification', '3': 6, '4': 1, '5': 11, '6': '.street_manata.CameraSpecification', '9': 2, '10': 'cameraSpecification', '17': true},
    {'1': 'identifier', '3': 7, '4': 1, '5': 9, '9': 3, '10': 'identifier', '17': true},
  ],
  '8': [
    {'1': '_fps'},
    {'1': '_end_epoch_micro_seconds'},
    {'1': '_camera_specification'},
    {'1': '_identifier'},
  ],
};

/// Descriptor for `VideoCapture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoCaptureDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NhcHR1cmUSOQoZc3RhcnRfZXBvY2hfbWljcm9fc2Vjb25kcxgBIAEoA1IWc3Rhcn'
    'RFcG9jaE1pY3JvU2Vjb25kcxIWCgZmb3JtYXQYAyABKAlSBmZvcm1hdBISCgRkYXRhGAQgASgM'
    'UgRkYXRhEhUKA2ZwcxgFIAEoA0gAUgNmcHOIAQESOgoXZW5kX2Vwb2NoX21pY3JvX3NlY29uZH'
    'MYAiABKANIAVIUZW5kRXBvY2hNaWNyb1NlY29uZHOIAQESOwoaZnJhbWVfZXBvY2hzX21pY3Jv'
    'X3NlY29uZHMYCCADKANSF2ZyYW1lRXBvY2hzTWljcm9TZWNvbmRzEloKFGNhbWVyYV9zcGVjaW'
    'ZpY2F0aW9uGAYgASgLMiIuc3RyZWV0X21hbmF0YS5DYW1lcmFTcGVjaWZpY2F0aW9uSAJSE2Nh'
    'bWVyYVNwZWNpZmljYXRpb26IAQESIwoKaWRlbnRpZmllchgHIAEoCUgDUgppZGVudGlmaWVyiA'
    'EBQgYKBF9mcHNCGgoYX2VuZF9lcG9jaF9taWNyb19zZWNvbmRzQhcKFV9jYW1lcmFfc3BlY2lm'
    'aWNhdGlvbkINCgtfaWRlbnRpZmllcg==');

@$core.Deprecated('Use geoCaptureChunkDescriptor instead')
const GeoCaptureChunk$json = {
  '1': 'GeoCaptureChunk',
  '2': [
    {'1': 'device', '3': 1, '4': 1, '5': 9, '10': 'device'},
    {'1': 'gps', '3': 2, '4': 1, '5': 11, '6': '.street_manata.GpsCapture', '9': 0, '10': 'gps', '17': true},
    {'1': 'orientation', '3': 3, '4': 1, '5': 11, '6': '.street_manata.OrientationCapture', '9': 1, '10': 'orientation', '17': true},
    {'1': 'acceleration', '3': 4, '4': 1, '5': 11, '6': '.street_manata.AccelerationCapture', '9': 2, '10': 'acceleration', '17': true},
    {'1': 'angular_velocity', '3': 5, '4': 1, '5': 11, '6': '.street_manata.AngularVelocityCapture', '9': 3, '10': 'angularVelocity', '17': true},
    {'1': 'magnetic_field', '3': 6, '4': 1, '5': 11, '6': '.street_manata.MagneticFieldCapture', '9': 4, '10': 'magneticField', '17': true},
    {'1': 'photos', '3': 7, '4': 3, '5': 11, '6': '.street_manata.PhotoCapture', '10': 'photos'},
    {'1': 'video', '3': 8, '4': 1, '5': 11, '6': '.street_manata.VideoCapture', '9': 5, '10': 'video', '17': true},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '9': 6, '10': 'description', '17': true},
    {'1': 'tags', '3': 10, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'trace_identifier', '3': 11, '4': 1, '5': 9, '10': 'traceIdentifier'},
    {'1': 'timestamp_epoch_micro_seconds', '3': 12, '4': 1, '5': 3, '10': 'timestampEpochMicroSeconds'},
    {'1': 'chunk_index', '3': 13, '4': 1, '5': 3, '10': 'chunkIndex'},
    {'1': 'is_last_chunk', '3': 14, '4': 1, '5': 8, '10': 'isLastChunk'},
    {'1': 'version', '3': 15, '4': 1, '5': 3, '10': 'version'},
  ],
  '8': [
    {'1': '_gps'},
    {'1': '_orientation'},
    {'1': '_acceleration'},
    {'1': '_angular_velocity'},
    {'1': '_magnetic_field'},
    {'1': '_video'},
    {'1': '_description'},
  ],
};

/// Descriptor for `GeoCaptureChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geoCaptureChunkDescriptor = $convert.base64Decode(
    'Cg9HZW9DYXB0dXJlQ2h1bmsSFgoGZGV2aWNlGAEgASgJUgZkZXZpY2USMAoDZ3BzGAIgASgLMh'
    'kuc3RyZWV0X21hbmF0YS5HcHNDYXB0dXJlSABSA2dwc4gBARJICgtvcmllbnRhdGlvbhgDIAEo'
    'CzIhLnN0cmVldF9tYW5hdGEuT3JpZW50YXRpb25DYXB0dXJlSAFSC29yaWVudGF0aW9uiAEBEk'
    'sKDGFjY2VsZXJhdGlvbhgEIAEoCzIiLnN0cmVldF9tYW5hdGEuQWNjZWxlcmF0aW9uQ2FwdHVy'
    'ZUgCUgxhY2NlbGVyYXRpb26IAQESVQoQYW5ndWxhcl92ZWxvY2l0eRgFIAEoCzIlLnN0cmVldF'
    '9tYW5hdGEuQW5ndWxhclZlbG9jaXR5Q2FwdHVyZUgDUg9hbmd1bGFyVmVsb2NpdHmIAQESTwoO'
    'bWFnbmV0aWNfZmllbGQYBiABKAsyIy5zdHJlZXRfbWFuYXRhLk1hZ25ldGljRmllbGRDYXB0dX'
    'JlSARSDW1hZ25ldGljRmllbGSIAQESMwoGcGhvdG9zGAcgAygLMhsuc3RyZWV0X21hbmF0YS5Q'
    'aG90b0NhcHR1cmVSBnBob3RvcxI2CgV2aWRlbxgIIAEoCzIbLnN0cmVldF9tYW5hdGEuVmlkZW'
    '9DYXB0dXJlSAVSBXZpZGVviAEBEiUKC2Rlc2NyaXB0aW9uGAkgASgJSAZSC2Rlc2NyaXB0aW9u'
    'iAEBEhIKBHRhZ3MYCiADKAlSBHRhZ3MSKQoQdHJhY2VfaWRlbnRpZmllchgLIAEoCVIPdHJhY2'
    'VJZGVudGlmaWVyEkEKHXRpbWVzdGFtcF9lcG9jaF9taWNyb19zZWNvbmRzGAwgASgDUhp0aW1l'
    'c3RhbXBFcG9jaE1pY3JvU2Vjb25kcxIfCgtjaHVua19pbmRleBgNIAEoA1IKY2h1bmtJbmRleB'
    'IiCg1pc19sYXN0X2NodW5rGA4gASgIUgtpc0xhc3RDaHVuaxIYCgd2ZXJzaW9uGA8gASgDUgd2'
    'ZXJzaW9uQgYKBF9ncHNCDgoMX29yaWVudGF0aW9uQg8KDV9hY2NlbGVyYXRpb25CEwoRX2FuZ3'
    'VsYXJfdmVsb2NpdHlCEQoPX21hZ25ldGljX2ZpZWxkQggKBl92aWRlb0IOCgxfZGVzY3JpcHRp'
    'b24=');

