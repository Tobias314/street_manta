
class OrientationEvent {

  OrientationEvent(this.yaw, this.pitch, this.roll, this.timestamp);

  /// The yaw of the device in radians.
  final double yaw;

  /// The pitch of the device in radians.
  final double pitch;

  /// The roll of the device in radians.
  final double roll;

  /// timestamp of the event
  final DateTime timestamp;

  @override
  String toString() => '[Orientation (yaw: $yaw, pitch: $pitch, roll: $roll)]';
}
