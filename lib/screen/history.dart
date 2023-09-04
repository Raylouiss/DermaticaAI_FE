import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class UserData {
  final String imageUrl;
  final String timeStamp;
  final String disease;
  final String level;
  final String percentage;

  UserData({
    required this.imageUrl,
    required this.timeStamp,
    required this.disease,
    required this.level,
    required this.percentage,
  });
}

class _HistoryState extends State<History> {
  Future<List<UserData>> fetchUserDatas() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }

    final userEmail = currentUser.email;

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('diseases')
              .where('user', isEqualTo: userEmail)
              .get();

      final List<UserData> userDatas = querySnapshot.docs.map((doc) {
        final imageUrl = doc.data()['url'].toString();
        final timeStamp = doc.data()['timeStamp'].toString();
        final disease = doc.data()['disease'].toString();
        final level = doc.data()['level'].toString();
        final percentage = doc.data()['percentage'].toString();
        return UserData(
          imageUrl: imageUrl,
          timeStamp: timeStamp,
          disease: disease,
          level: level,
          percentage: percentage,
        );
      }).toList();

      userDatas.sort((a, b) {
        final dateTimeA = DateTime.parse(a.timeStamp);
        final dateTimeB = DateTime.parse(b.timeStamp);
        return dateTimeB.compareTo(dateTimeA);
      });

      return userDatas;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5F93A0),
          title: const Text(
            'History',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<UserData>>(
                future: fetchUserDatas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Color(0xFF5F93A0),
                      backgroundColor: Colors.grey,
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                              height: 200),
                          const Text(
                            'No history available.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                              height: 20),
                          ClipRRect(
                            child: SizedBox(
                              child: Image.asset(
                                'assets/htu4.png',
                                width:
                                    120,
                                height: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final userDatas = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userDatas.length,
                      itemBuilder: (context, index) {
                        final userData = userDatas[index];

                        // Splitting timestamp into date and time
                        final timestamp = DateTime.parse(userData.timeStamp);
                        final formattedDate =
                            DateFormat('dd MMMM yyyy').format(timestamp);
                        final formattedTime =
                            DateFormat('HH:mm').format(timestamp);

                        return Container(
                          padding: const EdgeInsets.all(12),
                          width: width,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      userData.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData.disease,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Level: ${userData.level}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Confidence: ${userData.percentage}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Date: $formattedDate',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Time: $formattedTime',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
