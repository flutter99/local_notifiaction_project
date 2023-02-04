import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_app/notification_api.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 150),
          const SizedBox(height: 20),
          const Text(
            'Local Notification',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              NotificationApi().showLocalNotification(title: 'Local Notification Practice', body: 'This is my first project of Flutter Local Notification');
            },
            icon: const Icon(Icons.notifications),
            label: const Text(
              'Simple Notification',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              NotificationApi().showScheduleNotification(title: 'Schedule Notification Practice', body: 'This is the Flutter Schedule Local Notification');
            },
            icon: const Icon(Icons.notifications_active),
            label: const Text(
              'Schedule Notification',
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            label: const Text(
              'Remove Notification',
            ),
          ),
        ],
      ),
    );
  }
}
