import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'How to Use',
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Center align the title
      ),
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  bodyChat(),
                ],
              ),
              inputChat()
            ],
          )
      ),
    );
  }
  Widget bodyChat(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            itemChat(
              avatar : 'DevHub',
              chat : 1,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 0,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 1,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 0,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 1,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 0,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 1,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
            itemChat(
              avatar : 'DevHub',
              chat : 0,
              message : 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
              time : '10:00',
            ),
          ],

        ),
      ),
    );
  }
  Widget itemChat({required int chat, required String message, required String avatar, required String time}){
    return Row(
      mainAxisAlignment: chat == 1 ? MainAxisAlignment.end: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chat == 1 ?
        Avatar(
            useCache: true,
            name :avatar,
            shape: AvatarShape.circle(25)
        ): Text('$time', style: TextStyle(color: Colors.grey.shade400)),
        Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: chat==0 ? Color(0xFF5F9EA0):Color(0xFF008080) ,
                  borderRadius: chat == 0 ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  ): BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  )
              ),
              child: Text('$message', style: TextStyle(color: Colors.white, fontSize: 16),),
            )
        ),
        chat == 1 ? Text('$time', style: TextStyle(color: Colors.grey.shade400)): SizedBox()
      ],
    );
  }
  Widget inputChat(){
    return Positioned(
      // bottom: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Enter a message",
                  filled: true,
                  fillColor: Colors.grey,
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple.shade100),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple.shade100),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF5F9EA0)
                    ),
                    child: Icon(Icons.send_rounded, color: Colors.white, size: 25,),
                  )
              ),
            ),
          ),
        )
    );
  }
}

