import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.title,
    required this.logo,
    required this.color,
    required this.onTap,
  });

  String title;
  Image logo;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: const BorderSide(color: gray100, width: 1.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          surfaceTintColor: Colors.transparent,
          overlayColor: Colors.transparent,
          backgroundColor: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Pretendard-Medium',
                  fontSize: 15.0,
                  color: black),
            ),
          ],
        ),
      ),
    );
  }
}
