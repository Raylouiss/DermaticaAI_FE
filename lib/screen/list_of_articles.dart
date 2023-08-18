import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListOfArticles extends StatefulWidget {
  const ListOfArticles({super.key});

  @override
  State<ListOfArticles> createState() => _ListOfArticlesState();
}

class _ListOfArticlesState extends State<ListOfArticles> {
  late final PageController pageController;
  late Future<List<Map<String, dynamic>>> newsDataFuture;

  int pageNo = 0;
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final apiKey = '2e2fc648ec25454182773362fcdd7db5';
    final apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

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
    pageController = PageController(initialPage: 2, viewportFraction: 0.85);
    newsDataFuture = fetchNews();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'List Of Articles',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
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
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xFF5F93A0),
                      ),
                    ),
                  );
                },
                itemCount: 5,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Just For You',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 5,
                              color: Color(0xFF5F93A0),
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(height: 10,),
                            Text("Loading...")
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No news data available.');
                  } else {
                    final newsData = snapshot.data!;
                    return GridView.builder(
                      padding: EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 6 / 2,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: newsData.length,
                      itemBuilder: (context, index) {
                        final article = newsData[index];
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: article['urlToImage'] != null && article['urlToImage'].isNotEmpty
                                  ? Image.network(
                                article['urlToImage']!,
                                width: 120,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                                  : Container(
                                width: 120,
                                height: 80,
                                color: Colors.grey, // Placeholder color
                                child: Icon(Icons.image, color: Colors.white), // Placeholder icon
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formatDate(DateTime.parse(article['publishedAt'])),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    article['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}