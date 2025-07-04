import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../api/capture.dart';
import '../models/geocapture.dart';

Logger logger = Logger();

class FileUploader {
  static final FileUploader _instance = FileUploader._internal();

  late Directory uploadDirectory;
  bool _isUploadDirectoryInitialized = false;
  bool isUploading = false;
  bool isDone = true;
  Timer? _uploadTimer;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final HashMap<int, Function> _registeredCallbacks = HashMap();
  List<FileSystemEntity> filesQueuedForUpload = [];

  FileUploader._internal() {
    enableAutoUpload();
  }

  factory FileUploader() {
    return _instance;
  }

  void registerCallback(Widget widget, Function callback) {
    _registeredCallbacks[widget.hashCode] = callback;
  }

  void unregisterCallback(Widget widget) {
    _registeredCallbacks.remove(widget.hashCode);
  }

  Future<void> reloadListOfQueuedFiles() async {
    filesQueuedForUpload = (await getUploadDirectory())
        .listSync()
        .where((element) => element.path.split('.').last == 'cap')
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

  Future<Directory> getUploadDirectory() async {
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
            isDone = false;
            await flutterLocalNotificationsPlugin.show(
                0,
                'StreetManta Upload',
                'Uploading captures: ${filesQueuedForUpload.length} captures remaining...',
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
              await uploadGeoCaptureFile(file.path);
              await file.delete();
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
            if (!isDone) {
              isDone = true;
              await flutterLocalNotificationsPlugin.show(
                  0,
                  'StreetManta Upload',
                  'Done uploading images.',
                  notificationDetails);
            }
          }
        } while (filesQueuedForUpload.isNotEmpty);
      } else {
        logger.i('No wifi available, skipping upload');
      }
    }
    isUploading = false;
  }
}
