import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xff9abcff),
      unselectedItemColor: Colors.black,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house, size: 20.0),
          label: "홈",
        ),
        //BottomNavigationBarItem(
        // icon: Icon(Icons.build),
        // label: "수리센터",
        // ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20.0),
          label: "탐색",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidGem, size: 20.0),
          label: "판매",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidHeart, size: 20.0),
          label: "찜 목록",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidUser, size: 20.0),
          label: "나의 사피",
        ),
      ],
    );
  }
}
