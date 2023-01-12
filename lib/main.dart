import 'package:flutter/material.dart';
import 'package:stesh/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stesh',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: signup_screen(),
      debugShowCheckedModeBanner: false,

    );
  }
  }



