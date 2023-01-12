import "package:flutter/material.dart";
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/views/screens/add_video_screen.dart';
import 'package:snapshorts_app/views/screens/search_screen.dart';
import 'package:snapshorts_app/views/screens/video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;
  final pages = [
    const VideoScreen(),
    SearchScreen(),
    const AddVideoScreen(),
    const Text("Profile Screen"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIdx],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        currentIndex: pageIdx,
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.white70,
        items: [
          const BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: 28,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search,
              size: 28,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Column(
              children: const [
                SizedBox(
                  height: 15,
                ),
                Icon(
                  Icons.add_box,
                  size: 36,
                ),
              ],
            ),
          ),
          const BottomNavigationBarItem(
            label: "Message",
            icon: Icon(
              Icons.message,
              size: 28,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.account_circle_sharp,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
