import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xFF5F9EA0),
      ),
      body: Center(
          child: Text("Profile Screen", style : TextStyle(fontSize: 40))
      ),
    );
  }
}
