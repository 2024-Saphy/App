import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.txtColor,
    required this.onTap,
    required this.flag,
    this.fontColor,
  });

  final String title;
  final Color bgColor;
  final Color txtColor;
  final bool flag;
  final Color? fontColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: flag ? onTap : () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: const BorderSide(color: black, width: 1.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        surfaceTintColor: Colors.transparent,
        overlayColor: Colors.transparent,
        backgroundColor: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20.0,
                color: fontColor ?? black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
