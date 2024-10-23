import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/term_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class SplashSellingScreen extends StatefulWidget {
  static String id = 'splash_selling_screen';
  const SplashSellingScreen({super.key});

  @override
  State<SplashSellingScreen> createState() => _SplashSellingScreenState();
}

class _SplashSellingScreenState extends State<SplashSellingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: altWhite,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                fit: BoxFit.cover,
                'assets/images/products.jpg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '편하고 안전하게. \n원하는 가격으로.',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 40.0,
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: NormalButton(
                title: '판매 시작하기',
                bgColor: black,
                txtColor: white,
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const TermScreen(),
                  ));
                },
                flag: true,
              ),
            ),
            const SizedBox(
              height: 50.0,
            )
          ],
        ));
  }
}
