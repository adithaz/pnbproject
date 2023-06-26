import 'package:flutter/material.dart';
import 'package:pnbproject/screens/landingscreen/landingscreen.dart';
import 'package:pnbproject/screens/landingscreen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Politeknik Negeri Bali',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
