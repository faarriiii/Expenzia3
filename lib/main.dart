import 'package:exenzia/splash_screen/splash.dart';
import 'package:exenzia/view/add_expenses.dart';
import 'package:exenzia/view/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
