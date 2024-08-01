import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/log.dart';

class OtpScreen extends StatefulWidget {
  static String id = 'otp_screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpForm(
                  lastNode: false,
                ),
                OtpForm(
                  lastNode: false,
                ),
                OtpForm(
                  lastNode: false,
                ),
                OtpForm(
                  lastNode: true,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class OtpForm extends StatelessWidget {
  OtpForm({
    super.key,
    required this.lastNode,
  });

  bool lastNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      width: 80.0,
      child: TextFormField(
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
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: gray400, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: main500, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            )),
        cursorColor: main500,
        cursorHeight: 50.0,
        style: const TextStyle(
          fontFamily: 'Pretendard-Bold',
          fontSize: 40.0,
          fontWeight: FontWeight.w800,
          color: altBlack,
        ),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
