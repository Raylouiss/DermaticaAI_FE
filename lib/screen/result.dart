import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/screen/start.dart';
import 'package:firstapp/screen/chat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Result extends StatefulWidget {
  final String inputString;

  const Result({Key? key, required this.inputString}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isLoading = true;
  double confidence = 0;
  int predictedClass = 0;

  @override
  void initState() {
    super.initState();
    fetchPrediction();
  }

  Future<void> fetchPrediction() async {
    final url = Uri.parse('http://35.240.181.145:80/predict');
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        widget.inputString,
      ),
    );

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = json.decode(responseData);

        final confidence = decodedData['confidence'];
        final predictedClass = decodedData['predicted_class'];

        String userEmail = currentUser.email!;
        String timeStamp = DateTime.now().toIso8601String();
        String disease = 'Disease Name';
        String level = 'Threat Level';
        String percentage = '${(confidence * 100).toStringAsFixed(2)}%';

        if (predictedClass == 4) {
          level = 'Danger';
          disease = 'Melanoma';
        } else if (predictedClass == 0 ||
            predictedClass == 1 ||
            predictedClass == 7) {
          level = 'Medium';
          if (predictedClass == 0) {
            disease = 'Actinic Keratosis';
          } else if (predictedClass == 1) {
            disease = 'Basal Cell Carcinoma';
          } else if (predictedClass == 7) {
            disease = 'Vascular Skin Lesions';
          }
        } else if (predictedClass == 3 ||
            predictedClass == 6 ||
            predictedClass == 2) {
          level = 'Safe';
          if (predictedClass == 3) {
            disease = 'Dermatofibroma';
          } else if (predictedClass == 6) {
            disease = 'Melanocytic Nevi';
          } else if (predictedClass == 2) {
            disease = 'Benign Keratosis';
          }
        } else if (predictedClass == 5) {
          level = 'Zero';
          disease = 'Normal Skin';
        }

        await saveUserDataToFirestore(
          widget.inputString,
          userEmail,
          timeStamp,
          disease,
          level,
          percentage,
        );

        setState(() {
          this.confidence = confidence;
          this.predictedClass = predictedClass;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveUserDataToFirestore(String imageUrl, String email,
      String timeStamp, String disease, String level, String percentage) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Reference the "images" collection and create a new document with the user's UID
    final imageDocRef = firestoreInstance.collection("diseases");

    final imageData = {
      "imageUrl": imageUrl,
      "user": email,
      "timeStamp": timeStamp,
      "disease": disease,
      "level": level,
      "percentage": percentage,
    };

    await imageDocRef.add(imageData);
  }

  @override
  Widget build(BuildContext context) {
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final name = userCredential!.user!.displayName!.split(' ')[0];
    String threatLevel = '';
    String colorPrimary = '';
    String colorSecondary = '';
    String desc = '';
    String image = '';
    String icon = '';
    String link = '';
    if (predictedClass == 4) {
      threatLevel = 'Danger';
      colorPrimary = '#FFFF8F8F';
      colorSecondary = '#FFFA1111';
      desc = 'Recommended immediate consultation with a doctor';
      image = 'res_danger.png';
      icon = 'res_danger_icon.png';
      link = 'https://en.wikipedia.org/wiki/Melanoma';
    } else if (predictedClass == 0 ||
        predictedClass == 1 ||
        predictedClass == 7) {
      threatLevel = 'Medium';
      colorPrimary = '#FFFFD27D';
      colorSecondary = '#FFFFC048';
      desc = 'Recommended additional examination';
      image = 'htu4.png';
      icon = 'res_medium_icon.png';
      if (predictedClass == 0) {
        link = 'https://en.wikipedia.org/wiki/Actinic_keratosis';
      } else if (predictedClass == 1) {
        link = 'https://en.wikipedia.org/wiki/Basal-cell_carcinoma';
      } else if (predictedClass == 7) {
        link = 'https://en.wikipedia.org/wiki/Vascular_anomaly';
      }
    } else if (predictedClass == 3 ||
        predictedClass == 6 ||
        predictedClass == 2) {
      threatLevel = 'Safe';
      colorPrimary = '#FF94CB88';
      colorSecondary = '#FF51B53C';
      desc = 'Recommended to read the disease info and consult with Michie';
      image = 'res_safe.png';
      icon = 'res_safe_icon.png';
      if (predictedClass == 3) {
        link = 'https://en.wikipedia.org/wiki/Dermatofibroma';
      } else if (predictedClass == 6) {
        link = 'https://en.wikipedia.org/wiki/Melanocytic_nevus';
      } else if (predictedClass == 2) {
        link = 'https://en.wikipedia.org/wiki/Seborrheic_keratosis';
      }
    } else if (predictedClass == 5) {
      threatLevel = 'Zero';
      colorPrimary = '#FFEEEAEA';
      colorSecondary = '#FFD2D2D2';
      desc = 'Recommended to stay healthy';
      image = 'res_zero.png';
      icon = 'res_safe_icon.png';
      link = 'https://en.wikipedia.org/wiki/Skin';
    }
    Color colorPrim = Color(int.parse(colorPrimary.replaceAll("#", "0x")));
    Color colorSec = Color(int.parse(colorSecondary.replaceAll("#", "0x")));
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
            isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Color(0xFF5F93A0),
                    backgroundColor: Colors.grey,
                  )
                : SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.file(
                          File(widget.inputString),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: colorPrim,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              height: double.infinity,
                              color: colorSec,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 25,
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      threatLevel,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Threat Level',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  desc,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/$image'),
                          )
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/res_consult.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Consult with Michie',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/$icon'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  predictedClass == 0
                                      ? 'Actinic Keratosis'
                                      : predictedClass == 1
                                          ? 'Basal Cell Carcinoma'
                                          : predictedClass == 2
                                              ? 'Benign Keratosis'
                                              : predictedClass == 3
                                                  ? 'Dermatofibroma'
                                                  : predictedClass == 4
                                                      ? 'Melanoma'
                                                      : predictedClass == 5
                                                          ? 'Normal Skin'
                                                          : predictedClass == 6
                                                              ? 'Melanocytic Nevi'
                                                              : 'Vascular Skin Lesions',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    '${(confidence * 100).toStringAsFixed(2)}%'),
                                IconButton(
                                  icon:
                                      const Icon(Icons.chevron_right, size: 20),
                                  onPressed: () async {
                                    // ignore: deprecated_member_use
                                    if (!await canLaunch(link)) {
                                      // ignore: deprecated_member_use
                                      await launch(
                                        link,
                                        forceSafariVC: false,
                                        forceWebView: false,
                                        headers: <String, String>{
                                          'my_header_key': 'my_header_value'
                                        },
                                      );
                                    } else {
                                      // error
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
