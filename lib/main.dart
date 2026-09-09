import 'package:flutter/material.dart';

import 'pages/gesture_home_page.dart';

void main() {
  runApp(const GestureExampleApp());
}

class GestureExampleApp extends StatelessWidget {
  const GestureExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Gesture Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const GestureHomePage(),
    );
  }
}