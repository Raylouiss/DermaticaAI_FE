import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';

class ChatMessage {
  final String avatar;
  final String message;
  final bool isSentByUser;

  ChatMessage({
    required this.avatar,
    required this.message,
    required this.isSentByUser,
  });
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<ChatMessage> _messages = [];

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userCredential = Provider.of<UserCredentialProvider>(context).userCredential;
    final imageUrl = userCredential?.user?.photoURL;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'Chatbot',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = _messages[index];
                  return itemChat(
                    avatar: message.avatar,
                    message: message.message,
                    isSentByUser: message.isSentByUser,
                  );
                },
              ),
            ),
            inputChat(imageUrl!),
          ],
        ),
      ),
    );
  }

  void _addMessage(String messageText, bool isSentByUser, String imageUrl) {
    // Add the user's message to the list
    final userMessage = ChatMessage(
      avatar: imageUrl,
      message: messageText,
      isSentByUser: isSentByUser,
    );

    // Add the constant "hello" message to the list
    final helloMessage = ChatMessage(
      avatar: 'assets/htu4.png',
      message: "Hello",
      isSentByUser: false,
    );

    setState(() {
      _messages.add(userMessage);
      _messages.add(helloMessage);
    });

    // Clear the text field
    _textController.clear();
  }

  Widget itemChat({
    required String message,
    required String avatar,
    required bool isSentByUser,
  }) {

    return Row(
      mainAxisAlignment: isSentByUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        !isSentByUser
          ? Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage(avatar), // Load avatar image
                radius: 25,
              ),
            )
          : SizedBox(),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: !isSentByUser ? 10 : 70,
              right: isSentByUser ? 10 : 70,
              top: 15,
            ),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSentByUser ? Color(0xFF5F9EA0) : Color(0xFF008080),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: isSentByUser ? Radius.circular(30) : Radius.zero,
                bottomRight: !isSentByUser ? Radius.circular(30) : Radius.zero,
              ),
            ),
            child: Text(
              '$message',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        isSentByUser
          ? Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(avatar),
                radius: 25,
              ),
            )
          : SizedBox(),
      ],
    );
  }

  Widget inputChat(String imageUrl) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Enter a message",
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade100),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_rounded),
            onPressed: () {
              final messageText = _textController.text;
              if (messageText.isNotEmpty) {
                _addMessage(messageText, true, imageUrl);
              }
            },
          ),
        ],
      ),
    );
  }
}
