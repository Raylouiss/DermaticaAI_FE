import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'Support',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/support.png'),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Message: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenWidth,
                height: 0.3 * screenHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Set background color of the Container
                  borderRadius: BorderRadius.circular(10.0), // Set border radius of the Container
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Insert your message here',
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: screenWidth,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Your send button action here
                  },
                  child: Text('Send Message'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF5F9EA0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>( // Adds rounded corners to the button
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
