import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: const Text(
          'Result',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Color(0xFFFF8F8F), // ganti warna
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: double.infinity,
                        color: Color(0xFFFA1111), // ganti warna
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 10,
                      ),
                      width: MediaQuery.of(context).size.width*0.5,
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Text('Danger ', // ganti status
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),),
                              Text('Threat Level',
                              style: TextStyle(
                                fontSize: 10,
                              ),)
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Recommended immediate consultation with a doctor', // ganti desc
                          style: TextStyle(
                            fontSize: 16,
                          ),),
                        ],
                      ),
                    ),
                    Image.asset('assets/res_danger.png') // tinggal ganti gambar
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the button to the right
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/res_consult.png'),
                          SizedBox(width: 10,),
                          Text('Consult with Michie',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right, size: 20),
                        onPressed: () {
                          // Your action here
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns the button to the right
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/res_danger_icon.png'),
                          SizedBox(width: 10,),
                          Text('Acne Vulgaris',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('98%'),
                          IconButton(
                            icon: Icon(Icons.chevron_right, size: 20),
                            onPressed: () {
                              // Your action here
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
