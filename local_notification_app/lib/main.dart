import 'package:flutter/material.dart';
import 'package:local_notification_app/screens/main_screen.dart';

import 'notification_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.orange,
      ),
      home: const MainScreen(),
    );
  }
}

