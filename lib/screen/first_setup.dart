import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/bottom_nav.dart';

class FirstSetup extends StatefulWidget {
  const FirstSetup({super.key});

  @override
  State<FirstSetup> createState() => _FirstSetupState();
}

class _FirstSetupState extends State<FirstSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image:
            AssetImage("assets/background.png")
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset("assets/firstSetup.png"),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.1,
            ),
            GestureDetector(
              onTap: () {
                print('Text clicked');
              },
              child: Text(
                'Click to continue...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            BottomNav()
          ],
        ),
      ),
    );
  }
}
