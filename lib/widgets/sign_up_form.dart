import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:saphy/utils/colors.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.initialValue,
    required this.labelText,
    required this.formatter,
    required this.readOnly,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  final String initialValue;
  final String labelText;
  final List<TextInputFormatter> formatter;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = initialValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: readOnly
              ? const Color.fromARGB(200, 160, 163, 180)
              : const Color.fromARGB(200, 223, 225, 230),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            controller: textEditingController,
            readOnly: readOnly,
            inputFormatters: formatter,
            style: TextStyle(
              fontFamily: 'Pretendard-Medium',
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: readOnly ? gray200 : altBlack,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: labelText,
                labelStyle: TextStyle(
                  fontFamily: 'Pretendard-Medium',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  color: readOnly ? gray200 : altBlack,
                )),
          ),
        ),
      ),
    );
  }
}
