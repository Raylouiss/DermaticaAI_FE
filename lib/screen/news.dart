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
          title: Text('News'),
          backgroundColor: Color(0xFF5F9EA0),
      ),
      body: Center(
          child: Text("News Screen", style : TextStyle(fontSize: 40))
      ),
    );
  }
}
