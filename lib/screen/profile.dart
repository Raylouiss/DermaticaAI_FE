import 'package:firstapp/screen/how_to_use.dart';
import 'package:firstapp/screen/support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Login.dart';
import 'faq.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final userCredential = Provider.of<UserCredentialProvider>(context).userCredential;
    final imageUrl = userCredential?.user?.photoURL;
    final name = userCredential?.user?.displayName;
    final email = userCredential?.user?.email;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5F93A0),
          title: Text(
            'Profile',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.black,),
                Text('Back',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          leadingWidth: 90,
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
            imageUrl ?? 'assets/profile.png',
          ),
            TextButton(
                onPressed: (){

                },
                child:
                Text('Change Profile Picture',
                style: TextStyle(
                  color: Colors.black
                ),)
            ),
            Container(
              alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Personal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),)
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_username.png'),
                          SizedBox(width: 10,),
                          Text('Username'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(name ?? 'Username'),
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              // Your action here
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_email.png'),
                          SizedBox(width: 10,),
                          Text('Email'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(email ?? 'Email'),
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              // Your action here
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0,3),
                    )
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text('Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_notifications.png'),
                          SizedBox(width: 10,),
                          Text('Notifications'),
                        ],
                      ),
                      Row(
                        children: [
                        Switch(
                        value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeColor: Color(0xFF5F93A0),
                        )
                    ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_howtouse.png'),
                          SizedBox(width: 10,),
                          Text('How to Use'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HowToUse()),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_faq.png'),
                          SizedBox(width: 10,),
                          Text('FAQ'),
                        ],
                      ),
                      Row(
                        children: [IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FAQ()),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_support.png'),
                          SizedBox(width: 10,),
                          Text('Support'),
                        ],
                      ),
                      Row(
                        children: [IconButton(
                          icon: Icon(Icons.chevron_right, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Support()),
                            );
                          },
                        )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/profile_logout.png'),
                          SizedBox(width: 10,),
                          Text('Logout'),
                        ],
                      ),
                      Row(
                        children: [IconButton(
                          icon: Icon(Icons.chevron_right, size: 20),
                          onPressed: () async {
                            await GoogleSignIn().signOut(); // Assuming you're using FirebaseAuth
        
                            // Navigate back to the start screen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => StartScreen()),
                              (route) => false, // Remove all previous routes from the navigation stack
                            );
                          },
                        )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0,3),
                    )
                  ]
              ),
            )
          ],
        ),
      )
    );
  }
}
