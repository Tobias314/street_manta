import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static Globals? _singleton;
  static const int IN_APP_UPLOAD_PERIOD_SECONDS = 60;
  late SharedPreferences preferences;
  static const double GEO_CAPTURE_CHUNK_LENGTH_SECONDS = 30;
  static const int DEFAULT_VIDEO_FPS = 30;
  static const int DEFAULT_VIDEO_BITRATE = 12000000;
  static const double DEFAULT_VIDEO_EXPOSURE_OFFSET = -1.0; //in EV
  static const double IMU_CALIBRATION_CHUNK_LENGTH_SECONDS = 60;
  static const int IMU_CALIBRATION_LENGTH_SECONDS = 900;

  static const int GEO_CAPTURE_FORMAT_VERSION = 1;

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
      if (_singleton!.preferences.getDouble('videoExposureOffset') == null) {
        _singleton!.preferences
            .setDouble('videoExposureOffset', DEFAULT_VIDEO_EXPOSURE_OFFSET);
      }
      if (_singleton!.preferences.getInt('videoFps') == null) {
        _singleton!.preferences.setInt('videoFps', DEFAULT_VIDEO_FPS);
      }
      if (_singleton!.preferences.getInt('videoBitrate') == null) {
        _singleton!.preferences.setInt('videoBitrate', DEFAULT_VIDEO_BITRATE);
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

  double get geoCaptureChunkLengthSeconds {
    return GEO_CAPTURE_CHUNK_LENGTH_SECONDS;
  }

  double get videoExposureOffset {
    return preferences.getDouble('videoExposureOffset')!;
  }

  set videoExposureOffset(double videoExposureOffset) {
    preferences.setDouble('videoExposureOffset', videoExposureOffset);
  }

  int get videoFps {
    return preferences.getInt('videoFps')!;
  }

  set videoFps(int videoFps) {
    preferences.setInt('videoFps', videoFps);
  }

  int get videoBitrate {
    return preferences.getInt('videoBitrate')!;
  }

  set videoBitrate(int videoBitrate) {
    preferences.setInt('videoBitrate', videoBitrate);
  }

  int get geoCaptureFormatVersion {
    return GEO_CAPTURE_FORMAT_VERSION;
  }

  Globals._internal();
}
