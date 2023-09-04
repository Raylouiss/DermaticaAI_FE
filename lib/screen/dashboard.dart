import 'dart:convert';
import 'package:firstapp/screen/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'camera.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class UserImage {
  final String imageUrl;
  final String timeStamp;

  UserImage({required this.imageUrl, required this.timeStamp});
}

class _DashboardState extends State<Dashboard> {
  late final PageController pageController;
  late Future<List<Map<String, dynamic>>> newsDataFuture;

  int pageNo = 2;

  Future<List<UserImage>> fetchUserImages() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }

    final userEmail = currentUser.email;

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('diseases')
              .where('user', isEqualTo: userEmail)
              .get();

      final List<UserImage> userImages = querySnapshot.docs.map((doc) {
        final imageUrl = doc.data()['url'].toString();
        final timeStamp = doc.data()['timeStamp'].toString();
        return UserImage(imageUrl: imageUrl, timeStamp: timeStamp);
      }).toList();

      userImages.sort((a, b) {
        final dateTimeA = DateTime.parse(a.timeStamp);
        final dateTimeB = DateTime.parse(b.timeStamp);
        return dateTimeB.compareTo(dateTimeA);
      });

      return userImages;
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchNews() async {
    const apiKey = '2e2fc648ec25454182773362fcdd7db5';
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> articles = List.from(data['articles']);
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 2, viewportFraction: 0.85);
    newsDataFuture = fetchNews();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final name = userCredential!.user!.displayName!.split(' ')[0];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '$name' '!',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Camera(
                                  currentTab: 4,
                                  // ignore: avoid_types_as_parameter_names
                                  onTabChanged: (int) {},
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF5F9EA0),
                            minimumSize: const Size(230, 230),
                          ),
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Skin Disease Recognition",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset("assets/dashboard_sdr.png"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Chat(name: name),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF5F9EA0),
                            minimumSize: const Size(230, 230),
                          ),
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "AI Chatbot",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset("assets/dashboard_aichatbot.png"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 30, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "History",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 140,
                      child: FutureBuilder<List<UserImage>>(
                        future: fetchUserImages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                color: Color(0xFF5F93A0),
                                backgroundColor: Colors.grey,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                const Text('No history available.'),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/htu4.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            final List<UserImage> userImages = snapshot.data!;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: userImages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final UserImage userImage = userImages[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Adjust the padding as needed
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            userImage.imageUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                  color: Colors
                                                      .grey, // Display a placeholder
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '${DateFormat('dd-MM-yyyy').format(DateTime.parse(userImage.timeStamp))}\n${DateFormat('HH:mm').format(DateTime.parse(userImage.timeStamp))}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 30, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trending',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: newsDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                color: Color(0xFF5F93A0),
                                backgroundColor: Colors.grey,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('No news data available.');
                          } else {
                            final newsData = snapshot.data!;

                            // Filter articles with valid images
                            final validArticles = newsData.where((article) {
                              return article['urlToImage'] != null &&
                                  article['urlToImage'].isNotEmpty;
                            }).toList();

                            // Shuffle and select 5 random articles
                            validArticles.shuffle();
                            final selectedArticles =
                                validArticles.take(5).toList();

                            return PageView.builder(
                              controller: pageController,
                              onPageChanged: (index) {
                                pageNo = index;
                                setState(() {});
                              },
                              itemBuilder: (_, index) {
                                final article = selectedArticles[
                                    index % selectedArticles.length];
                                return AnimatedBuilder(
                                  animation: pageController,
                                  builder: (ctx, child) {
                                    return child!;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        if (article['urlToImage'] != null &&
                                            article['urlToImage'].isNotEmpty)
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 16, right: 16),
                                            height: 150,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                article['urlToImage']!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        Flexible(
                                          child: Column(children: [
                                            GestureDetector(
                                              onTap: () async {
                                                // ignore: deprecated_member_use
                                                if (!await canLaunch(
                                                    article['url'])) {
                                                  // ignore: deprecated_member_use
                                                  await launch(
                                                    article['url'],
                                                    forceSafariVC: false,
                                                    forceWebView: false,
                                                    headers: <String, String>{
                                                      'my_header_key':
                                                          'my_header_value'
                                                    },
                                                  );
                                                } else {
                                                  // error
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 12,
                                                    top: 10,
                                                    right: 12),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        article['title'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 12, top: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                formatDate(DateTime.parse(
                                                    article['publishedAt'])),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: selectedArticles.length,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.circle,
                            size: 12,
                            color: pageNo == index
                                ? const Color(0xFF5F93A0)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
