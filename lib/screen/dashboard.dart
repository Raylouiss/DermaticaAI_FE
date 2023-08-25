import 'dart:convert';

import 'package:firstapp/screen/list_of_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';

import 'camera.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final PageController pageController;
  late Future<List<Map<String, dynamic>>> newsDataFuture;

  int pageNo = 2;

  Future<List<Map<String, dynamic>>> fetchNews() async {
    final apiKey = '2e2fc648ec25454182773362fcdd7db5';
    final apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=$apiKey';
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
    final userCredential = Provider.of<UserCredentialProvider>(context).userCredential;
    final name = userCredential!.user!.displayName;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child:
            Column(
              children: [
                Container(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Hello, $name!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                )
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
                              MaterialPageRoute(builder: (context) => Camera(currentTab: 4, onTabChanged: (int ) {  },)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color(0xFF5F9EA0),
                            minimumSize: Size(MediaQuery.of(context).size.width*0.4, MediaQuery.of(context).size.width*0.4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Skin Diseases Recognition"),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Image.asset("assets/dashboard_sdr.png"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ListOfChat()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // provide your desired value for the rounded corner
                            ),
                            backgroundColor: Color(0xFF5F9EA0),
                            minimumSize: Size(MediaQuery.of(context).size.width*0.4, MediaQuery.of(context).size.width*0.4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("AI Chatbot"),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Image.asset("assets/dashboard_aichatbot.png"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        Container(
          child: Column(
            children: [
              Padding (
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:
                Align(
                  alignment: Alignment.centerLeft,
                  child : Text("History",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              SizedBox(height: 10),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(fontSize: 24, color: Color(0xFF5F9EA0)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Trending',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child:
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: newsDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Color(0xFF5F93A0),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No news data available.');
                    } else {
                      final newsData = snapshot.data!;

                      // Filter articles with valid images
                      final validArticles = newsData.where((article) {
                        return article['urlToImage'] != null && article['urlToImage'].isNotEmpty;
                      }).toList();

                      // Shuffle and select 5 random articles
                      validArticles.shuffle();
                      final selectedArticles = validArticles.take(5).toList();

                      return PageView.builder(
                        controller: pageController,
                        onPageChanged: (index) {
                          pageNo = index;
                          setState(() {});
                        },
                        itemBuilder: (_, index) {
                          final article = selectedArticles[index % selectedArticles.length];
                          return AnimatedBuilder(
                            animation: pageController,
                            builder: (ctx, child) {
                              return child!;
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5,
                                      offset: Offset(0,3),
                                    )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  if (article['urlToImage'] != null && article['urlToImage'].isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                                      height: 150,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          article['urlToImage']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  Flexible(
                                    child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              if (!await canLaunch(article['url'])) {
                                                await launch(
                                                  article['url'],
                                                  forceSafariVC: false,
                                                  forceWebView: false,
                                                  headers: <String, String>{'my_header_key': 'my_header_value'},
                                                );
                                              } else {
                                                print('Could not launch ${article['url']}');
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(left: 12, top: 10, right: 12),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      article['title'],
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.bookmark_border),
                                                    onPressed: () {
                                                      // TODO: Add your bookmarking logic here
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 12, top : 5),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              formatDate(DateTime.parse(article['publishedAt'])),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
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
                      color: pageNo == index ? Color(0xFF5F93A0) : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
        ],
          ),
        )
        ],
            ),
          ),
        ),
      ),
    );
  }
}
