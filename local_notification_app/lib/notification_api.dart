import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializeSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializeSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializeSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
  }


  /// show local notification
  Future showLocalNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }


  /// local notification
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notisound'),
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  var scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 3));

  // static Future<String> getImageFilePathFromAssets(String asset) async {
  //   final byteData = await rootBundle.load(asset);
  //
  //   final file =
  //   File('${(await getTemporaryDirectory()).path}/${asset.split('/').last}');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file.path;
  // }

  // final attachmentPicturePath = await getImageFilePathFromAssets('assets/img.png');
  // final BigPictureStyleInformation bigPictureStyleInformation =
  // BigPictureStyleInformation(FilePathAndroidBitmap(attachmentPicturePath),
  //     largeIcon: FilePathAndroidBitmap(filePath));

  /// show schedule notification
  Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      scheduledNotificationDateTime,
      await scheduleNotificationDetails(),
    );
  }

  scheduleNotificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          ticker: 'ticker',

          /// for sound of notification
          playSound: true,
          showWhen: false,

          /// color of the icon
          color: Colors.orange,

          /// show time on notification
          usesChronometer: false,

          /// top small text with time
          //subText: 'hello how are you doing? everything is okay?',

          /// sound path
          sound: RawResourceAndroidNotificationSound('notisound'),
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }
}
