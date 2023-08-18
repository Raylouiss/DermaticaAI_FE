import 'package:firstapp/component/footer.dart';
import 'package:firstapp/screen/Login.dart';
import 'package:firstapp/screen/article.dart';
import 'package:firstapp/screen/camera.dart';
import 'package:firstapp/screen/chat.dart';
import 'package:firstapp/screen/dashboard.dart';
import 'package:firstapp/screen/first_setup.dart';
import 'package:firstapp/screen/history.dart';
import 'package:firstapp/screen/home.dart';
import 'package:firstapp/screen/how_to_use.dart';
import 'package:firstapp/screen/list_of_articles.dart';
import 'package:firstapp/screen/list_of_chat.dart';
import 'package:firstapp/screen/register.dart';
import 'package:firstapp/screen/result.dart';
import 'package:firstapp/screen/scanner_desc.dart';
import 'package:firstapp/screen/start.dart';
import 'package:firstapp/screen/support.dart';
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
      home: const Home(),
    );
  }
}