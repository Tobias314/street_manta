import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Constants {
  //const String BACKEND_URL = "10.0.2.2:8000";
  //final String BACKEND_URL = "127.0.0.1:8000";
  static const int IN_APP_UPLOAD_PERIOD_SECONDS = 60;

  static bool get isMobileApp {
    if (kIsWeb) {
      print("Running on web");
      return false;
    } else {
      print(
          "Running on Android or IOS ${Platform.isAndroid || Platform.isIOS}");
      return Platform.isAndroid || Platform.isIOS;
    }
  }
}
