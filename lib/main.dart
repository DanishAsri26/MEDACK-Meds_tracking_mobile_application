import 'package:flutter/material.dart';
import 'package:lab_5/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Remove debug banner
      home: LoginPage(),
    );
  }
}
