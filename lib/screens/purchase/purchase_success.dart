import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class PurchaseSuccess extends StatelessWidget {
  const PurchaseSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "결제 완료!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pretendard"),
                ),
                const SizedBox(
                  height: 30,
                ),
                NormalButton(
                    title: "홈으로 돌아가기",
                    bgColor: black,
                    txtColor: white,
                    onTap: () {},
                    flag: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
