import 'package:firstapp/component/footer.dart';
import 'package:firstapp/screen/Login.dart';
import 'package:firstapp/screen/dashboard.dart';
import 'package:firstapp/screen/first_setup.dart';
import 'package:firstapp/screen/home.dart';
import 'package:firstapp/screen/how_to_use.dart';
import 'package:firstapp/screen/register.dart';
import 'package:firstapp/screen/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HowToUse(),
    );
  }
}