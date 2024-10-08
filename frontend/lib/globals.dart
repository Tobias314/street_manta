import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static Globals? _singleton;
  static const int IN_APP_UPLOAD_PERIOD_SECONDS = 60;
  late SharedPreferences preferences;

  static Future<Globals> getInstance() async {
    if (_singleton == null) {
      _singleton = Globals._internal();
      _singleton!.preferences = await SharedPreferences.getInstance();
      if (_singleton!.preferences.getString('backendUrl') == null) {
        _singleton!.preferences.setString(
            'backendUrl',
            const String.fromEnvironment('BACKEND_URL',
                defaultValue: 'http://localhost:8080'));
      }
    }
    return _singleton!;
  }

  String get backendUrl {
    return preferences.getString('backendUrl')!;
  }

  set backendUrl(String url) {
    preferences.setString('backendUrl', url);
  }

  Globals._internal();
}
