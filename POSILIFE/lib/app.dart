import 'package:flutter/material.dart';

import 'view/login/PosiLifeHomeScreen.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PosiLifeHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
