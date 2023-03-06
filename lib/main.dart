import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stesh/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stesh',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Color.fromARGB(255, 255, 255, 255),
            displayColor: Color.fromARGB(255, 255, 255, 255)),
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      home: signup_screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
