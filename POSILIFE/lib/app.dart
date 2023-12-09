import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';

import 'view/login/PosiLifeHomeScreen.dart';

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  const MyApp({super.key, required this.flutterLocalNotificationsPlugin});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PosiLifeHomeScreen(),
    );
  }
}
