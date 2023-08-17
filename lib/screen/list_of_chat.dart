import 'package:flutter/material.dart';

class ListOfChat extends StatefulWidget {
  const ListOfChat({super.key});

  @override
  State<ListOfChat> createState() => _ListOfChatState();
}

class _ListOfChatState extends State<ListOfChat> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0), // Set the app bar color to #5F93A0
        title: Text(
          'Chatbot',
          textAlign: TextAlign.center, // Align the title to center
        ),
        centerTitle: true, // Center align the title
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFF008080),
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.add, size: 20, color: Colors.white,),
                    onPressed: () {
                      // Your action here
                    },
                  ),
                  Text(
                    'New Chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true, // Add this line
                physics: NeverScrollableScrollPhysics(), // Add this line to disable the scrolling effect of ListView
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1,
                    color: Colors.black,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(items[index],
                          style: TextStyle(
                            fontSize: 16
                          ),),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {
                              // Add action here
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
