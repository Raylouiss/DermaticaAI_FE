import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF008080),
        body : Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Image.asset("assets/logo.png")
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1
                ),
                // Added text input
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child : TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your text here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                )
              ],
            )
        )
    );
  }
}
