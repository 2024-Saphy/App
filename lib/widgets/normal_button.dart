import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';

class NormalButton extends StatelessWidget {
  NormalButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  String title;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Pretendard-Medium', fontSize: 15.0, color: black),
          ),
        ],
      ),
    );
  }
}
