import 'package:flutter/material.dart';

class HowToUse extends StatefulWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'How to Use',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.black,),
              Text('Back',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 90,
      ),
      body: 
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top:16),
                child: Text(
                  'Skin Disease Recognition',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0,3),
                        )
                      ]
                  ),
                  child:
                  Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('1. Create an account and login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu1.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('2. Click the camera button or the skin diseases recognition',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu2.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('3. Take or upload a photo of your skin',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu3.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('4. Wait for Michie to analyze',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu4.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('5. Get the result and recommendation',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu5.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('6. Check the diseases info',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu6.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text('7. Consult with Michie for more details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset("assets/htu7.png", fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ]
                  )
              ),
              Container(
                padding: EdgeInsets.all(16),
                 child:
                 Column(
                   children: [
                     Align(
                       alignment: Alignment.center,
                       child: Text(
                         'You can also ask Michie anytime by clicking the AI Chatbot on homepage',
                         textAlign: TextAlign.center, // Align text within the Text widget to center
                         style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 16
                         ),
                       ),
                     ),
                     Image.asset("assets/htu8.png"),
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
