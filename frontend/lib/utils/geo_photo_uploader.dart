import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
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
  HashMap<int, Function> _registeredCallbacks = HashMap();
  List<FileSystemEntity> filesQueuedForUpload = [];

  GeoPhotoUploader._internal() {
    enableAutoUpload();
  }

  factory GeoPhotoUploader() {
    return _instance;
  }

  void registerCallback(Widget widget, Function callback) {
    _registeredCallbacks[widget.hashCode] = callback;
  }

  void unregisterCallback(Widget widget) {
    _registeredCallbacks.remove(widget.hashCode);
  }

  Future<void> reloadListOfQueuedFiles() async {
    filesQueuedForUpload = (await _getUploadDirectory())
        .listSync()
        .where((element) => element.path.split('.').last == 'json')
        .toList();
    _registeredCallbacks.forEach((key, callback) {
      callback();
    });
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
    _uploadTimer?.cancel();
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
    if (isUploading) {
      logger.i('Already uploading, skipping');
      return;
    } else {
      reloadListOfQueuedFiles();
      if (isWifiAvailable) {
        isUploading = true;
        var uploadDir = await _getUploadDirectory();
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
          if (filesQueuedForUpload.isNotEmpty) {
            await flutterLocalNotificationsPlugin.show(
                0,
                'StreetManta Upload',
                'Uploading images: ${filesQueuedForUpload.length} images remaining...',
                notificationDetails);
            var file = filesQueuedForUpload.first;
            var lockFile = File('${file.path}.lock');
            if (lockFile.existsSync()) {
              if (lockFile.lastModifiedSync().isBefore(
                  DateTime.now().subtract(const Duration(minutes: 5)))) {
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
            await reloadListOfQueuedFiles();
          } else {
            await flutterLocalNotificationsPlugin.show(0, 'StreetManta Upload',
                'Done uploading images.', notificationDetails);
          }
        } while (filesQueuedForUpload.isNotEmpty);
      }
    }
    isUploading = false;
  }

  Future<void> queueForUpload(GeoPhotoUpload geoPhoto) async {
    //TODO: upload directely when executing in the web
    var uploadDir = await _getUploadDirectory();
    await geoPhoto.saveToDirectory(uploadDir);
  }
}
