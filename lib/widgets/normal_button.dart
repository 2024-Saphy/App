import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.flag,
  });

  final String title;
  final Color color;
  final bool flag;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: flag ? onTap : () {},
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
