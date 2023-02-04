import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializeSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializeSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializeSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }

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
}
