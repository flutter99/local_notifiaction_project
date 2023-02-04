

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:rxdart/rxdart.dart';

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
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {

        });

    var initializeSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializeSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {

        });
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

  scheduleNotificationDetails() async {

    final largeIconPath = await Utils.downlaodFile('https://cdn.pixabay.com/photo/2013/07/13/13/53/diamond-161739_960_720.png', 'largeIcon');
    final bigPicPath = await Utils.downlaodFile('https://cdn.pixabay.com/photo/2022/11/20/09/06/night-view-7603847_960_720.jpg', 'bigPic');

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicPath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
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

          styleInformation: styleInformation,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }
}

class Utils {
  static Future<String> downlaodFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
