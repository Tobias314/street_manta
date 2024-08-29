import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../api/geo_photo.dart';
import '../constants.dart';
import '../models/geo_photo.dart';

Logger logger = Logger();

class GeoPhotoUploader {
  static final GeoPhotoUploader _instance = GeoPhotoUploader._internal();

  late Directory uploadDirectory;
  bool _isUploadDirectoryInitialized = false;
  bool isUploading = false;
  Timer? _uploadTimer;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  GeoPhotoUploader._internal() {
    Timer.periodic(
        const Duration(seconds: Constants.IN_APP_UPLOAD_PERIOD_SECONDS),
        (timer) {
      triggerUpload();
    });
  }

  factory GeoPhotoUploader() {
    return _instance;
  }

  Future<bool> _isWifiAvailable() async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }

  Future<Directory> _getUploadDirectory() async {
    if (!_isUploadDirectoryInitialized) {
      var documentDirectory = await getApplicationDocumentsDirectory();
      uploadDirectory = Directory('${documentDirectory.path}/uploads');
      await uploadDirectory.create(recursive: true);
      _isUploadDirectoryInitialized = true;
    }
    return uploadDirectory;
  }

  void enableAutoUpload({int periodInSeconds = 60}) {
    _uploadTimer = Timer.periodic(Duration(seconds: periodInSeconds), (timer) {
      triggerUpload();
    });
  }

  void disableAutoUpload() {
    _uploadTimer?.cancel();
  }

  Future<void> triggerUpload() async {
    logger.i('Triggering upload');
    var isWifiAvailable = await _isWifiAvailable();
    if (!isUploading && isWifiAvailable) {
      isUploading = true;
      var uploadDir = await _getUploadDirectory();
      List<FileSystemEntity> files;
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              'streetmanta_file_upload', 'StreetManta File Upload',
              channelDescription: 'Photo upload channel',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      do {
        files = await uploadDir
            .list()
            .where((element) => element.path.split('.').last == 'json')
            //.take(1)
            .toList();

        if (files.isNotEmpty) {
          await flutterLocalNotificationsPlugin.show(
              0,
              'StreetManta Upload',
              'Uploading images: ${files.length} images remaining...',
              notificationDetails);
          var file = files.first;
          var lockFile = File('${file.path}.lock');
          if (lockFile.existsSync()) {
            if (lockFile
                .lastModifiedSync()
                .isBefore(DateTime.now().subtract(const Duration(minutes: 5)))) {
              logger.w('Lock file is older than 5 minutes, deleting it');
              lockFile.delete();
            } else {
              // We assume that the file is being uploaded by another process so we wait before we try again
              await Future.delayed(const Duration(seconds: 2));
              continue;
            }
          }
          try {
            logger.i('Uploading file: ${file.path}');
            lockFile.createSync(exclusive: true);
            var jsonFile = File(file.path);
            var geoPhoto =
                GeoPhotoUpload.fromJson(await jsonFile.readAsString());
            await uploadGeoPhoto(geoPhoto);
            await File(geoPhoto.path).delete();
            await jsonFile.delete();
          } catch (err) {
            logger.e('Error uploading file: ${file.path}');
            logger.e(err.toString());
          } finally {
            if (lockFile.existsSync()) {
              lockFile.delete();
            }
          }
        } else {
          await flutterLocalNotificationsPlugin.show(0, 'StreetManta Upload',
              'Done uploading images.', notificationDetails);
        }
      } while (files.isNotEmpty);
      isUploading = false;
    }
  }

  Future<void> registerForUpload(GeoPhotoUpload geoPhoto) async {
    //TODO: upload directely when executing in the web
    var uploadDir = await _getUploadDirectory();
    await geoPhoto.saveToDirectory(uploadDir);
  }
}
