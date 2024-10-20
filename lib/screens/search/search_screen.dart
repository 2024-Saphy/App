import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/screens/search/search_result_screen.dart';
import 'package:saphy/widgets/textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: altWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) => const ScreenController(),
                  ),
                );
              },
            ),
            textField(
              _controller,
              context,
              (String value) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SearchResultScreen(query: value),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SearchResultScreen(query: _controller.text),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ],
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
                Text("인기 검색어", style: titleText()),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildKeywordButton("iPhone 14", context),
                      const SizedBox(width: 10),
                      buildKeywordButton("iPhone SE", context),
                      const SizedBox(width: 10),
                      buildKeywordButton("iPhone 13", context),
                      const SizedBox(width: 10),
                      buildKeywordButton("Galaxy", context),
                      const SizedBox(width: 10),
                      buildKeywordButton("iPhone", context),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text("인기 브랜드", style: titleText()),
                const SizedBox(height: 10),
                Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      buildBrandButton(
                          "https://i.pinimg.com/564x/98/86/c2/9886c2f88c318293b04c223f18e57148.jpg",
                          "Apple"),
                      buildBrandButton(
                          "https://i.pinimg.com/564x/68/23/99/68239927494dbd614773edaa5e05606f.jpg",
                          "Samsung"),
                      buildBrandButton(
                          "https://i.pinimg.com/564x/21/9a/ba/219aba5a7e74091741fef401deb08f43.jpg",
                          "Xiaomi"),
                      buildBrandButton(
                          "https://i.pinimg.com/564x/bb/01/82/bb0182822f2cf41937feee1f4a91fb2b.jpg",
                          "Nokia"),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildKeywordButton(String label, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SearchResultScreen(query: label),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: gray300, width: 1),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
          child: Center(
            child: Text(label, style: textStyle(15, false, null)),
          ),
        ),
      ),
    );
  }

  InkWell buildBrandButton(String link, String label) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        width: (screenWidth - 55) / 2,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
          image: DecorationImage(
            image: CachedNetworkImageProvider(link),
            fit: BoxFit.cover,
          ),
        ),
        // child: SizedBox.expand(
        //   child: ClipRect(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // 블러 강도
        //       child: Container(
        //           color: Colors.transparent,
        //           child: Center(
        //               child: Text(label, style: textStyle(25, true, white)))),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
