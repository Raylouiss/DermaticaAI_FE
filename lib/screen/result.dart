import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/screen/start.dart';
import 'package:firstapp/screen/chat.dart';

class Result extends StatefulWidget {
  final String inputString;

  const Result({Key? key, required this.inputString}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  // Future<String> getUserLatestImageUrlFromFirestore(String uid) async {
  //   final firestoreInstance = FirebaseFirestore.instance;
  //   try {
  //     // Query the "images" collection for documents with the given UID
  //     final query = firestoreInstance
  //         .collection("images")
  //         .where("user", isEqualTo: uid)
  //         // .orderBy("timestamp", descending: true) // Order by timestamp in descending order
  //         .limit(1); // Limit to the latest document

  //     final querySnapshot = await query.get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       // If documents are found, return the latest imageUrl
  //       final latestDoc = querySnapshot.docs.first;
  //       return latestDoc.get("imageUrl");
  //     } else {
  //       // No documents found for the given user
  //       return "";
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     print("Error fetching user data: $e");
  //     return "";
  //   }
  // }
  Future<String> fetchImage() async {
    await Future.delayed(const Duration(seconds: 1));
    return widget.inputString;
  }

  @override
  Widget build(BuildContext context) {
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final name = userCredential!.user!.displayName!.split(' ')[0];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5F93A0),
          title: const Text(
            'Result',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FutureBuilder<String>(
                future: fetchImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: const Color(0xFFFF8F8F), // ganti warna
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: double.infinity,
                          color: const Color(0xFFFA1111), // ganti warna
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Danger ', // ganti status
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Threat Level',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Recommended immediate consultation with a doctor', // ganti desc
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                          'assets/res_danger.png') // tinggal ganti gambar
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Aligns the button to the right
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/res_consult.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Consult with Michie',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(name: name)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Aligns the button to the right
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/res_danger_icon.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Acne Vulgaris',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('98%'),
                            IconButton(
                              icon: const Icon(Icons.chevron_right, size: 20),
                              onPressed: () {
                                // Your action here
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
