import 'package:flutter/material.dart';
import 'package:saphy/screens/main/main_screen.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/utils/colors.dart';
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
          const Text(
            '판매 요청이\n완료되었어요',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 40.0,
              color: black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '기기 수거를 위한 절차를 확인해볼까요?',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20.0,
              color: black,
              fontWeight: FontWeight.w500,
            ),
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
