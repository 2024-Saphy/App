import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

SizedBox textField(
    TextEditingController controller, BuildContext context, onSubmitted) {
  var screenWidth = MediaQuery.of(context).size.width;

  return SizedBox(
    width: screenWidth - 150,
    child: TextField(
      style: bodyText(),
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: gray800, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: gray800, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainPrimary, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: '검색어를 입력하세요',
        hintStyle: const TextStyle(
          color: gray700,
        ),
      ),
    ),
  );
}
