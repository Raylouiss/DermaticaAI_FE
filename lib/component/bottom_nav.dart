import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.15,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset("assets/logo_kelompok.png"),
      ),
    ),
  );
}
}
