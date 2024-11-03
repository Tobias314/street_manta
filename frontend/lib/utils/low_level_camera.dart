import 'package:flutter/services.dart';

//TODO: delete if not needed
class LowLevelCamera{
  static const platform = MethodChannel('street_manta.redpielabs.com/helloWorld');

  Future<String> helloWorld() async {
  String callResult;
  try {
    final result = await platform.invokeMethod<String>('helloWorld');
    callResult = result!;
  } on PlatformException catch (e) {
    callResult = "Failed method invocation ${e.message}";
  }

  return callResult;
  }
}