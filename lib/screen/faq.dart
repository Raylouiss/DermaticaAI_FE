import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;
  bool isExpanded5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F93A0),
        title: const Text(
          'FAQ',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'What is Dermatica?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isExpanded1
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded1 = !isExpanded1;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded1)
                    const Text(
                        'Dermatica is an application that can help you to recognize skin diseases. You can use this application by uploading a photo of your skin disease and the application will recognize the skin disease.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'How to use Dermatica?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isExpanded2
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded2 = !isExpanded2;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded2)
                    const Text(
                        'We have provided a How to use page that you can access on the home page. You can also access the How to use page by clicking the How to use button on the Profile page. On the How to use page, you can see how to use the Dermatica application.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Who should use Dermatica?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isExpanded3
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded3 = !isExpanded3;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded3)
                    const Text(
                        'Dermatica is an application that can be used by anyone who wants to recognize skin diseases. Especially for those of you who are lazy to go to the doctor, you can use this application to recognize skin diseases.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Does Dermatica replace the doctor?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isExpanded4
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded4 = !isExpanded4;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded4)
                    const Text(
                        'Dermatica is an application that can help you to recognize skin diseases. However, this application cannot replace the role of a doctor. If you have a skin disease, you should immediately consult a doctor to get the right treatment.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Is my data safe?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isExpanded5
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded5 = !isExpanded5;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded5)
                    const Text(
                        'We guarantee that your data is safe. We will not share your data with other parties. We only use your data to improve user experience and application performance.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
