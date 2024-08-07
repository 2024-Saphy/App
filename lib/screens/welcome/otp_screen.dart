import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/log.dart';
import 'package:saphy/utils/otp_form.dart';
import 'package:saphy/widgets/normal_button.dart';

class OtpScreen extends StatefulWidget {
  static String id = 'otp_screen';
  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.onVerificationSuccess,
  });

  final String verificationId;
  final String phoneNumber;
  final VoidCallback onVerificationSuccess;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  String get smsCode {
    return _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text +
        _controller5.text +
        _controller6.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '안전한 중고거래를 위해서!',
              style: TextStyle(
                fontFamily: 'Pretendard-Bold',
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: altBlack,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '${widget.phoneNumber}로 인증번호가 전송되었습니다.',
              style: const TextStyle(
                fontFamily: 'Pretendard-Medium',
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: altBlack,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpForm(
                  controller: _controller1,
                  lastNode: false,
                ),
                OtpForm(
                  controller: _controller2,
                  lastNode: false,
                ),
                OtpForm(
                  controller: _controller3,
                  lastNode: false,
                ),
                OtpForm(
                  controller: _controller4,
                  lastNode: false,
                ),
                OtpForm(
                  controller: _controller5,
                  lastNode: false,
                ),
                OtpForm(
                  controller: _controller6,
                  lastNode: true,
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            NormalButton(
              title: "인증하기",
              color: mainPrimary,
              flag: true,
              onTap: () async {
                logger.i(smsCode);
                try {
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: smsCode);
                  await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((_) {
                    widget.onVerificationSuccess();
                    Navigator.of(context).pop();
                  });
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
