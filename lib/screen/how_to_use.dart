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
        backgroundColor: const Color(0xFF5F93A0),
        title: const Text(
          'How to Use',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 30),
                child: const Text(
                  'Skin Disease Recognition',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(children: [
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '1. Click the camera button or the skin diseases recognition',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu2.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '2. Take or upload a photo of your skin',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu3.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '3. Wait for Michie to analyze',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu4.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '4. Get the result and recommendation',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu5.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '5. Check the diseases info',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu6.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Text(
                            '6. Consult with Michie for more details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment
                                .center,
                            child: Image.asset("assets/htu7.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ])),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'You can also ask Michie anytime by clicking the AI Chatbot on homepage',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
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
