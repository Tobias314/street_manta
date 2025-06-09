import 'package:sensors_plus/src/orientation_interface.dart';
import 'package:sensors_plus_platform_interface/sensors_plus_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

/// The Sensors implementation.
class Sensors extends SensorsPlatform {
  /// Constructs a singleton instance of [Sensors].
  ///
  /// [Sensors] is designed to work as a singleton.
  factory Sensors() => _singleton ??= Sensors._();

  Sensors._();

  static Sensors? _singleton;

  static SensorsPlatform get _platform => SensorsPlatform.instance;

  final Logger logger = Logger("Sensors");
  static const MethodChannel _methodChannel =
      MethodChannel('dev.fluttercommunity.plus/sensors/method');
  static const EventChannel _orientationEventChannel =
      EventChannel('dev.fluttercommunity.plus/sensors/orientation');
  Stream<OrientationEvent>? _orientationEvents;

  /// Returns a broadcast stream of events from the device accelerometer at the
  /// given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  @override
  Stream<AccelerometerEvent> accelerometerEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    return _platform.accelerometerEventStream(samplingPeriod: samplingPeriod);
  }

  /// Returns a broadcast stream of events from the device gyroscope at the
  /// given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  @override
  Stream<GyroscopeEvent> gyroscopeEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    return _platform.gyroscopeEventStream(samplingPeriod: samplingPeriod);
  }

  /// Returns a broadcast stream of events from the device accelerometer with
  /// gravity removed at the given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  @override
  Stream<UserAccelerometerEvent> userAccelerometerEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    return _platform.userAccelerometerEventStream(
        samplingPeriod: samplingPeriod);
  }

  /// Returns a broadcast stream of events from the device magnetometer at the
  /// given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  @override
  Stream<MagnetometerEvent> magnetometerEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    return _platform.magnetometerEventStream(samplingPeriod: samplingPeriod);
  }

  /// Returns a broadcast stream of events from the device barometer at the
  /// given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  @override
  Stream<BarometerEvent> barometerEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    return _platform.barometerEventStream(samplingPeriod: samplingPeriod);
  }

  /// Returns a broadcast stream of orientation events at the
  /// given sampling frequency.
  ///
  /// This method always returning the same stream. If this method is called
  /// again, the sampling period of the stream will be update. All previous
  /// listener will also be affected.
  Stream<OrientationEvent> orientationEventStream({
    Duration samplingPeriod = SensorInterval.normalInterval,
  }) {
    var microseconds = samplingPeriod.inMicroseconds;
    _methodChannel.invokeMethod('setOrientationSamplingPeriod', microseconds);
    if (microseconds >= 1 && microseconds <= 3) {
      logger.warning('The SamplingPeriod is currently set to $microsecondsμs, '
          'which is a reserved value in Android. Please consider changing it '
          'to either 0 or 4μs. See https://developer.android.com/reference/'
          'android/hardware/SensorManager#registerListener(android.hardware.'
          'SensorEventListener,%20android.hardware.Sensor,%20int) for more '
          'information');
      microseconds = 0;
    }
    _methodChannel.invokeMethod('setOrientationSamplingPeriod', microseconds);
    _orientationEvents ??=
        _orientationEventChannel.receiveBroadcastStream().map((dynamic event) {
      final list = event.cast<double>();
      return OrientationEvent(
        list[0]!,
        list[1]!,
        list[2]!,
        DateTime.fromMicrosecondsSinceEpoch(list[3]!.toInt()),
      );
    });
    return _orientationEvents!;
  }
}
