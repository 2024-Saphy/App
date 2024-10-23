import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/term_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
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
        body: Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/products.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('편하고 안전하게. \n원하는 가격으로.',
                        style: textStyle(40, true, white)),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                      child: NormalButton(
                        title: '판매 시작하기',
                        bgColor: black.withOpacity(0.2),
                        txtColor: white,
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const TermScreen(),
                          ));
                        },
                        flag: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
