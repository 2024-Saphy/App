import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saphy/utils/colors.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({
    super.key,
    required this.lastNode,
    required this.controller,
  });

  final TextEditingController controller;
  final bool lastNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: 60.0,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            if (lastNode) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          }
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainPrimary, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainPrimary, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            )),
        cursorColor: main500,
        cursorHeight: 50.0,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontFamily: 'Pretendard-Bold',
          fontSize: 30.0,
          fontWeight: FontWeight.w800,
          color: mainPrimary,
        ),
      ),
    );
  }
}
