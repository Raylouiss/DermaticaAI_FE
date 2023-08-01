import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('History'),
          backgroundColor: Color(0xFF5F9EA0),
      ),
      body: Center(
          child: Text("History Screen", style : TextStyle(fontSize: 40))
      ),
    );
  }
}
