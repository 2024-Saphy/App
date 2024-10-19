import 'package:flutter/material.dart';
import 'package:saphy/screens/main/main_screen.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/normal_button.dart';

class EndSellingScreen extends StatefulWidget {
  const EndSellingScreen({super.key});

  @override
  State<EndSellingScreen> createState() => _EndSellingScreenState();
}

class _EndSellingScreenState extends State<EndSellingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/congratulation.png',
                  width: 250.0,
                ),
              ],
            ),
          ),
          Text(
            '판매 요청이\n완료되었어요',
            style: textStyle(35, true, null),
            textAlign: TextAlign.center,
          ),
          Text(
            '기기 접수가 완료되면 알려드릴게요!',
            style: textStyle(20, false, null),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: NormalButton(
              title: '좋아요!',
              bgColor: black,
              txtColor: white,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ScreenController(),
                  ),
                );
              },
              flag: true,
            ),
          ),
        ],
      ),
    );
  }
}
