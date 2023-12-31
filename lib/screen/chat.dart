import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final String name;

  const Chat({Key? key, required this.name}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<ChatMessage> _messages = [];
  final List<String> _answers = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _initialMessageSent = false;

  @override
  void initState() {
    super.initState();
    _sendInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final imageUrl = userCredential?.user?.photoURL;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F93A0),
        title: const Text(
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
                controller: _scrollController,
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

  void _sendInitialMessage() {
    const initialMessage = "";
    _addMessage(initialMessage, false, '');
    _initialMessageSent = true;
  }

  void _addMessage(
    String messageText,
    bool isSentByUser,
    String imageUrl,
  ) async {
    if (_initialMessageSent) {
      final userMessage = ChatMessage(
        avatar: imageUrl,
        message: messageText,
        isSentByUser: isSentByUser,
      );

      setState(() {
        _messages.add(userMessage);
      });

      if (messageText.isNotEmpty) {
        final chatbotResponse = ChatMessage(
          avatar: 'assets/htu4.png',
          message: '...',
          isSentByUser: false,
        );

        setState(() {
          _messages.add(chatbotResponse);
        });

        await sendQuery(messageText);

        final chatbotAnswer = ChatMessage(
          avatar: 'assets/htu4.png',
          message: _answers.isNotEmpty ? _answers.removeAt(0) : "",
          isSentByUser: false,
        );

        setState(() {
          _messages.remove(chatbotResponse);
          _messages.add(chatbotAnswer);
        });

        _textController.clear();
        _scrollToBottom();
      }
    } else {
      String name = widget.name;
      final chatbotResponse = ChatMessage(
        avatar: 'assets/htu4.png',
        message: 'Hi $name! My name is Michie. How can I help you?',
        isSentByUser: isSentByUser,
      );

      setState(() {
        _messages.add(chatbotResponse);
      });

      _textController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> sendQuery(String query) async {
    final url = Uri.parse('http://34.87.19.232/ask');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'query': query,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final answer = jsonData['answer'];
      _answers.add(answer);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Widget itemChat({
    required String message,
    required String avatar,
    required bool isSentByUser,
  }) {
    return Row(
      mainAxisAlignment:
          isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        !isSentByUser
            ? Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage(avatar),
                  radius: 25,
                ),
              )
            : const SizedBox(),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: !isSentByUser ? 10 : 70,
              right: isSentByUser ? 10 : 70,
              top: 15,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSentByUser
                  ? const Color(0xFF5F9EA0)
                  : const Color(0xFF008080),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                topRight: const Radius.circular(30),
                bottomLeft:
                    isSentByUser ? const Radius.circular(30) : Radius.zero,
                bottomRight:
                    !isSentByUser ? const Radius.circular(30) : Radius.zero,
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        isSentByUser
            ? Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(avatar),
                  radius: 25,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget inputChat(String imageUrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Enter a message",
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: const EdgeInsets.all(15),
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
            icon: const Icon(Icons.send_rounded),
            onPressed: () async {
              final messageText = _textController.text;
              if (messageText.isNotEmpty) {
                _scrollToBottom();
                _addMessage(messageText, true, imageUrl);
                await sendQuery(messageText);
              }
            },
          ),
        ],
      ),
    );
  }
}
