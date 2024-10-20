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
        filled: true,
        fillColor: white.withOpacity(0.8),
        hintText: '검색어를 입력하세요',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // 둥근 모서리 설정
          borderSide: BorderSide.none, // 테두리 제거
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // 포커스 시에도 둥근 모서리 유지
          borderSide: BorderSide(
              color: mainPrimary.withOpacity(0.5), width: 1.5), // 포커스 시 테두리 스타일
        ),
      ),
    ),
  );
}
