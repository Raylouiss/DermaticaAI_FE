import 'package:firstapp/screen/list_of_articles.dart';
import 'package:firstapp/screen/profile.dart';
import 'package:flutter/material.dart';

import 'camera.dart';
import 'dashboard.dart';
import 'history.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    History(),
    ListOfArticles(),
    Profile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5F9EA0),
        child: Icon(Icons.camera_alt_rounded, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Camera(currentTab: currentTab, onTabChanged: (index) => setState(() => currentTab = index))),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  BottomAppBar buildBottomNavBar() {
    return BottomAppBar(
      color: Color(0xFF008080),
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNavBarItem(Icons.home, 0),
                buildNavBarItem(Icons.history, 1),
              ],
            ),
            Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNavBarItem(Icons.newspaper, 2),
                buildNavBarItem(Icons.person, 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    bool isSelected = currentTab == index;
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = screens[index];
          currentTab = index;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFF5F9EA0) : Colors.transparent,
        ),
        child: Icon(
          icon,
          // color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
