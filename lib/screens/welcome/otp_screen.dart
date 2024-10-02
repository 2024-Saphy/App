import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: newGray,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: -240,
            child: Opacity(
              opacity: 0.5,
              child: SvgPicture.asset(
                'assets/images/LogoFixed.svg',
                width: MediaQuery.of(context).size.width + 500.0,
              ),
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '안전한 중고거래를 위해서!',
                        style: TextStyle(
                          fontFamily: 'Pretendard-Bold',
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                          color: white,
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
                          color: gray100,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      OtpForms(
                          controller1: _controller1,
                          controller2: _controller2,
                          controller3: _controller3,
                          controller4: _controller4,
                          controller5: _controller5,
                          controller6: _controller6),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: NormalButton(
                      title: "인증하기",
                      bgColor: mainPrimary,
                      txtColor: black,
                      flag: true,
                      onTap: () async {
                        logger.i(smsCode);
                        try {
                          final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: smsCode);
                          await FirebaseAuth.instance
                              .signInWithCredential(credential)
                              .then((_) {
                            widget.onVerificationSuccess();
                            Navigator.of(context).pop();
                          });
                          logger.i("정상적으로 로그인 되었습니다.");
                        } catch (e) {
                          logger.i(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OtpForms extends StatelessWidget {
  const OtpForms({
    super.key,
    required TextEditingController controller1,
    required TextEditingController controller2,
    required TextEditingController controller3,
    required TextEditingController controller4,
    required TextEditingController controller5,
    required TextEditingController controller6,
  })  : _controller1 = controller1,
        _controller2 = controller2,
        _controller3 = controller3,
        _controller4 = controller4,
        _controller5 = controller5,
        _controller6 = controller6;

  final TextEditingController _controller1;
  final TextEditingController _controller2;
  final TextEditingController _controller3;
  final TextEditingController _controller4;
  final TextEditingController _controller5;
  final TextEditingController _controller6;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
