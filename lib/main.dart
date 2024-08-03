import 'package:flutter/material.dart';

import 'package:my_project/splash_screen.dart';

const bool isLoggedIn = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search A Holic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //this will call the splash_screen.dart file
      home: const Splash(),
    );
  }
}
