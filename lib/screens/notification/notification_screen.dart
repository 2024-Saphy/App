import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopAppBar(),
        backgroundColor: altWhite,
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/images/Question-3d.png',
                width: 180.0,
              ),
            ),
            Text(
              '알림이 없습니다',
              style: textStyle(20, true, null),
            ),
          ],
        )));
  }
}
