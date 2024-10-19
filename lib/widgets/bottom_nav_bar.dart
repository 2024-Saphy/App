import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saphy/utils/colors.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: 90,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        currentIndex: currentIndex,
        backgroundColor: white,
        selectedItemColor: mainPrimary,
        unselectedItemColor: altBlack,
        onTap: onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: screenWidth / 25),
            label: "홈",
          ),
          //BottomNavigationBarItem(
          // icon: Icon(Icons.build),
          // label: "수리센터",
          // ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass,
                size: screenWidth / 25),
            label: "탐색",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidGem, size: screenWidth / 25),
            label: "판매",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidHeart, size: screenWidth / 25),
            label: "찜 목록",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser, size: screenWidth / 25),
            label: "나의 사피",
          ),
        ],
      ),
    );
  }
}
