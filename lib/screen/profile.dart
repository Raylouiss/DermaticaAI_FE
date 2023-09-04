import 'package:firstapp/screen/how_to_use.dart';
import 'package:firstapp/screen/support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final imageUrl = userCredential?.user?.photoURL;
    final name = userCredential?.user?.displayName;
    final email = userCredential?.user?.email;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF5F93A0),
            title: const Text(
              'Profile',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.network(
                  imageUrl ?? 'assets/profile.png',
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16, top: 30),
                    child: const Text(
                      'Personal',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_username.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Username'),
                            ],
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              name ?? 'Username',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_email.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Email'),
                            ],
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              email ?? 'Email',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_howtouse.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('How to Use'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_right, size: 20),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HowToUse()),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_faq.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('FAQ'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_right, size: 20),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const FAQ()),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_support.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Support'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_right, size: 20),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Support()),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/profile_logout.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Logout'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_right, size: 20),
                                onPressed: () async {
                                  bool confirmed = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Sign Out'),
                                        content: const Text(
                                            'Are you sure you want to sign out?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(false); // User canceled
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(true); // User confirmed
                                            },
                                            child: const Text('Sign Out'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirmed == true) {
                                    // User confirmed, perform sign out
                                    await GoogleSignIn().signOut();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StartScreen()),
                                      (route) => false,
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
