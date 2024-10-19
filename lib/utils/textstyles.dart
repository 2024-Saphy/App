import 'package:flutter/material.dart';

TextStyle textStyle(double size, bool bold, Color? color) {
  return TextStyle(
    fontSize: size,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    fontFamily: "Pretendard",
    color: color ?? Colors.black,
  );
}

TextStyle titleText() {
  return const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontFamily: "Pretendard",
  );
}

TextStyle titleText30() {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: "Pretendard",
  );
}

TextStyle subTitleText({bold = true}) {
  return TextStyle(
    fontSize: 20,
    fontWeight: bold ? FontWeight.bold : FontWeight.w500,
    fontFamily: "Pretendard",
  );
}

TextStyle bodyText() {
  return const TextStyle(
    fontSize: 15,
    fontFamily: "Pretendard",
  );
}

TextStyle bodyBoldText() {
  return const TextStyle(
    fontSize: 15,
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w600,
  );
}
