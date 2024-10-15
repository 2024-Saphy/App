import 'package:flutter/material.dart';
import 'package:saphy/screens/main/main_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class PurchaseFail extends StatelessWidget {
  const PurchaseFail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Center(
        child: Column(
          children: [
            const Text("결제 실패"),
            NormalButton(
                title: "홈으로 돌아가기",
                bgColor: black,
                txtColor: white,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false,
                  );
                },
                flag: true)
          ],
        ),
      ),
    );
  }
}
