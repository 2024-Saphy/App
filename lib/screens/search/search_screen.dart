import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
                Navigator.of(context).pop();
              },
            ),
            textField(
              _controller,
              context,
              (String value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultScreen(query: value),
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
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchResultScreen(query: _controller.text),
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
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("최근 검색어", style: titleText()),
                const SizedBox(height: 20),
                Text("인기 검색어", style: titleText()),
                const SizedBox(height: 20),
                Text("인기 브랜드", style: titleText()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
