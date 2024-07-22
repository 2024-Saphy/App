import 'package:flutter/material.dart';
import 'package:saphy/screens/main/main_screen.dart';
import 'package:saphy/screens/mypage/mypage.dart';
import 'package:saphy/screens/products/liked_list_page.dart';
import 'package:saphy/screens/search/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                ),
                const Text("홈"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.build),
                  onPressed: () {},
                ),
                const Text("수리센터"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
                const Text("탐색"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
                const Text("관심 목록"),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPage(),
                      ),
                    );
                  },
                ),
                const Text("나의 사피"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
