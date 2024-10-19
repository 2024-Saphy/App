import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/web.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/screens/welcome/otp_screen.dart';
import 'package:saphy/service/auth_service.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/phone_input_formatter.dart';
import 'package:saphy/widgets/normal_button.dart';
import 'package:saphy/widgets/sign_up_form.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'signup_screen';
  const SignupScreen({
    super.key,
    required this.socialType,
    required this.userEmail,
    required this.userName,
    required this.userPhotoUrl,
  });

  final String? socialType;
  final String? userEmail;
  final String? userName;
  final String? userPhotoUrl;

  @override
  State<SignupScreen> createState() => _SignupScreenState(
        socialType: socialType,
        userName: userName,
        userEmail: userEmail,
        userPhotoUrl: userPhotoUrl,
      );
}

class _SignupScreenState extends State<SignupScreen> {
  Logger logger = Logger();
  static bool phoneAuth = false;
  String userPhoneNumber = '010-';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? socialType;
  String? userName;
  String? userEmail;
  String? userPhotoUrl;
  String? userToken;
  _SignupScreenState(
      {this.socialType,
      this.userName,
      this.userEmail,
      this.userPhotoUrl,
      this.userToken});

  void despose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formWidget(context),
                NormalButton(
                  title: '사피 시작하기',
                  bgColor: phoneAuth ? mainPrimary : gray400,
                  txtColor: black,
                  flag: phoneAuth,
                  onTap: () async {
                    logger.i(
                      '${_nameController.text} / ${_emailController.text} / ${_phoneController.text} / ${widget.userPhotoUrl} /',
                    );
                    final code = await joinService(
                      widget.socialType!,
                      _emailController.text,
                      _nameController.text,
                      _phoneController.text,
                    );
                    // final code2 = await setProfileImageService();
                    if (code == 200) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ScreenController(),
                      ));
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column formWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '안녕하세요!',
          style: TextStyle(
            fontFamily: 'Pretendard-Bold',
            fontSize: 50.0,
            fontWeight: FontWeight.w800,
            color: white,
          ),
        ),
        const Text(
          '서비스 이용에 필요한 정보를 입력해주세요',
          style: TextStyle(
            fontFamily: 'Pretendard-Medium',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: gray100,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SignUpForm(
          textEditingController: _nameController,
          readOnly: true,
          formatter: const [],
          initialValue: userName ?? '',
          labelText: '어떻게 불러드릴까요?',
        ),
        SignUpForm(
          textEditingController: _emailController,
          readOnly: true,
          formatter: const [],
          initialValue: userEmail ?? '',
          labelText: '이메일을 알려주세요',
        ),
        SignUpForm(
          textEditingController: _phoneController,
          readOnly: phoneAuth,
          formatter: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
            PhoneInputFormatter(),
          ],
          initialValue: userPhoneNumber,
          labelText: '전화번호를 알려주세요',
        ),
        NormalButton(
            title: "인증번호 전송",
            bgColor: phoneAuth ? gray300 : mainPrimary,
            txtColor: black,
            flag: !phoneAuth,
            onTap: () async {
              String phoneNumber = _phoneController.text.trim();
              String formattedNumber = '';
              if (phoneNumber.isNotEmpty) {
                // '-'를 제거하고, 앞에 +82를 붙임
                formattedNumber = phoneNumber
                    .replaceAll('-', '') // '-' 제거
                    .replaceFirst('010', '+8210'); // '010'을 '+8210'으로 변환
              }
              logger.i(formattedNumber);
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: formattedNumber,
                verificationCompleted: (PhoneAuthCredential) {},
                verificationFailed: (error) {
                  logger.i(error);
                },
                codeSent: (verificationId, forceResendingToken) {
                  //if code is send successfully then nevigate to next screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        verificationId: verificationId,
                        phoneNumber: formattedNumber,
                        onVerificationSuccess: () {
                          setState(() {
                            phoneAuth = true;
                            userPhoneNumber = _phoneController.text;
                          });
                        },
                      ),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (verificationId) {},
              );
            }),
      ],
    );
  }
}







  // final TextEditingController _postcodeController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _addressDetailController =
  //     TextEditingController();
 // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0),
              //   child: NormalButton(
              //     title: '주소 찾기',
              //     color: mainPrimary,
              //     onTap: () async {
              //       flag = false;
              //       setState(() {});
              //       Map<String, String> formData =
              //           await searchAdress(context, logger);
              //       _postcodeController.value =
              //           TextEditingValue(text: formData['postcode'] ?? '');
              //       _addressController.value =
              //           TextEditingValue(text: formData['address'] ?? '');
              //       _addressDetailController.value = TextEditingValue(
              //           text: formData['address_detail'] ?? '');
              //     },
              //   ),
              // ),
              // SignUpForm(
              //   textEditingController: _postcodeController,
              //   readOnly: true,
              //   formatter: const [],
              //   initialValue: '',
              //   labelText: '우편번호를 검색하세요',
              // ),
              // SignUpForm(
              //   textEditingController: _addressController,
              //   readOnly: true,
              //   formatter: const [],
              //   initialValue: '',
              //   labelText: '배송을 위한 주소를 검색하세요',
              // ),
              // SignUpForm(
              //   textEditingController: _addressDetailController,
              //   readOnly: flag,
              //   formatter: const [],
              //   initialValue: '',
              //   labelText: '상세 주소를 입력하세요',
              // ),
                    //               logger.i(
                    //   '${_nameController.text} / ${_emailController.text} / ${_phoneController.text} / ${_postcodeController.text} / ${_addressController.text}/ ${_addressDetailController.text}',
                    // );