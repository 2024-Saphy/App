import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: altWhite,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
                onPressed: () {},
              ),
              Container(
                height: 50,
                width: screenWidth - 150,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gray200, width: 1),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 아래 모두 데이터 연동 & stateful 위젯으로의 전환 추후 진행예정
                Text(
                  "최근 검색어",
                  style: titleText(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("인기 검색어", style: titleText()),

                const SizedBox(
                  height: 20,
                ),
                Text(
                  "인기 브랜드",
                  style: titleText(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
