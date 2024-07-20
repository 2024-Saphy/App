import 'package:flutter/material.dart';

Widget bottomNavBar() {
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
                onPressed: () {},
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
                onPressed: () {},
              ),
              const Text("탐색"),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              const Text("관심 목록"),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
              const Text("나의 사피"),
            ],
          ),
        ],
      ),
    ),
  );
}
