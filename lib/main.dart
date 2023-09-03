import 'package:firstapp/screen/splash_screen.dart';
import 'package:firstapp/screen/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserCredentialProvider(),
      child: const MyApp(),
    ),
  );
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DermaticaAI',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}