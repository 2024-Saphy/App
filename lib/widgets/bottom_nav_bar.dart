import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xff9abcff),
      unselectedItemColor: Colors.black,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "홈",
        ),
        //BottomNavigationBarItem(
        // icon: Icon(Icons.build),
        // label: "수리센터",
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "탐색",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "찜 목록",
        ),
        // BottomNavigationBarItem(
        // icon: Icon(Icons.person),
        // label: "나의 사피",
        // ),
      ],
    );
  }
}
