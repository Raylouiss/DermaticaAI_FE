import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
                '7 July 2023',
                textAlign: TextAlign.left, // Align the text to the left
              ),
              SizedBox(height: 10), // Spacing between date and image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_YCalozv20Oki516pDRvDiNfByLm_OxvEZc6_XN6TIw&s',
                  width: MediaQuery.of(context).size.width,  // Adjust the width to match screen width
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                  'General Hospital Management Steps Up Safety Protocols',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
              ),
              SizedBox(height: 10),
              Text(
                  "First and foremost, if you have oily skin, you should be washing your face regularly. Ideally, you should wash your face in the morning, in the evening, and after exercising. These are moments when your skin will be the oiliest. You want to get rid of as much of the excess oil as possible in order to prevent it from clogging your pores."
              ),
              Text(
                  "First and foremost, if you have oily skin, you should be washing your face regularly. Ideally, you should wash your face in the morning, in the evening, and after exercising. These are moments when your skin will be the oiliest. You want to get rid of as much of the excess oil as possible in order to prevent it from clogging your pores."
              )
            ],
          ),
        ),
      )
    );
  }
}
