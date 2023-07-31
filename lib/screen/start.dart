import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/bottom_nav.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset("assets/logo.png"),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(0, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF008080)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(0, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF008080),
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.05,
              alignment: Alignment.center,
              child: const Text(
                'or',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(0, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            const Spacer(),
            BottomNav(),
          ],
        ),
      ),
    );
  }
}