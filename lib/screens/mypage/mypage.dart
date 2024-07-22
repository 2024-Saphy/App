import 'package:flutter/material.dart';
import 'package:saphy/widgets/app_bar.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: TopAppBar(),
      body: Center(
        child: Text("My Page"),
      ),
    );
  }
}