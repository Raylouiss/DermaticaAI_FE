import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Article extends StatefulWidget {
  final Map<String, dynamic> articleData;

  const Article({Key? key, required this.articleData}) : super(key: key);

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'Article',
          textAlign: TextAlign.center, // Align the title to center
        ),
        centerTitle: true, // Center align the title
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // To align content to the left
            children: [
              Text(
                formatDate(DateTime.parse(widget.articleData['publishedAt'])), // Use articleData to display the date
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10), // Spacing between date and image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.articleData['urlToImage'],
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.articleData['title'], // Use articleData for the title
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Text(widget.articleData['content']),
            ],
          ),
        ),
      )
    );
  }
}
