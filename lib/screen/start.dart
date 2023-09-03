import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../component/bottom_nav.dart';
import 'home.dart';

class UserCredentialProvider extends ChangeNotifier {
  UserCredential? _userCredential;

  UserCredential? get userCredential => _userCredential;

  void setUserCredential(UserCredential credential) {
    _userCredential = credential;
    notifyListeners();
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null || googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        throw Exception(
            "Google Sign-In failed: Missing access token or ID token.");
      }
    } else {
      throw Exception("Google Sign-In failed: No user selected.");
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Reference the "users" collection and create a new document with the user's UID
    final userDocRef = firestoreInstance.collection("users").doc(user.uid);

    final userData = {
      "displayName": user.displayName,
      "email": user.email,
      "photoURL": user.photoURL,
    };

    await userDocRef.set(userData);
  }

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
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await signInWithGoogle();
                    // print("User Info: ${userCredential.user}");
                    // ignore: use_build_context_synchronously
                    Provider.of<UserCredentialProvider>(context, listen: false)
                        .setUserCredential(userCredential);
                    await saveUserDataToFirestore(userCredential.user!);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  } catch (e) {
                    // error
                  }
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(0, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: Image.asset('assets/google_logo.png'),
                    ),
                    const SizedBox(width: 10),
                    const Flexible(
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const BottomNav(),
          ],
        ),
      ),
    );
  }
}
