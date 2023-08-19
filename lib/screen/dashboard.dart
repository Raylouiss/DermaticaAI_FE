import 'package:firstapp/screen/list_of_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    child: Text("Hello, Willson",
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
                          // Do something when the first button is pressed
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
          Padding (
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:
            Align(
              alignment: Alignment.centerLeft,
              child : Text("Trending",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ),
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
          )
      ],
        ),
      )
      ],
          ),
        ),
      ),
    );
  }
}
