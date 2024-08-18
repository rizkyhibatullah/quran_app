import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionScreen(),
    );
  }
}
