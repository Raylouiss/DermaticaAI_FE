import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'List Of Articles',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Text("News Screen", style : TextStyle(fontSize: 40))
      ),
    );
  }
}
