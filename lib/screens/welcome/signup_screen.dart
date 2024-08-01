import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/web.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/phone_input_formatter.dart';
import 'package:saphy/utils/search_adress.dart';
import 'package:saphy/widgets/login_button.dart';
import 'package:saphy/widgets/normal_button.dart';
import 'package:saphy/widgets/sign_up_form.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'signup_screen';
  const SignupScreen(
      {super.key,
      required this.socialType,
      required this.userEmail,
      required this.userName,
      required this.userPhotoUrl,
      required this.userToken});

  final String? socialType;
  final String? userEmail;
  final String? userName;
  final String? userPhotoUrl;
  final String? userToken;

  @override
  State<SignupScreen> createState() => _SignupScreenState(
        socialType: socialType,
        userName: userName,
        userEmail: userEmail,
        userPhotoUrl: userPhotoUrl,
        userToken: userToken,
      );
}

class _SignupScreenState extends State<SignupScreen> {
  Logger logger = Logger();
  bool flag = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressDetailController =
      TextEditingController();

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
    _postcodeController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '환영합니다!',
                style: TextStyle(
                  fontFamily: 'Pretendard-Bold',
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800,
                  color: altBlack,
                ),
              ),
              const Text(
                '서비스 이용에 필요한 정보를 입력해주세요',
                style: TextStyle(
                  fontFamily: 'Pretendard-Medium',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: altBlack,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SignUpForm(
                textEditingController: _nameController,
                readOnly: false,
                formatter: const [],
                initialValue: userName ?? '',
                labelText: '어떻게 불러드릴까요?',
              ),
              SignUpForm(
                textEditingController: _emailController,
                readOnly: false,
                formatter: const [],
                initialValue: userEmail ?? '',
                labelText: '이메일을 알려주세요',
              ),
              SignUpForm(
                textEditingController: _phoneController,
                readOnly: false,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                  PhoneInputFormatter(),
                ],
                initialValue: '',
                labelText: '전화번호를 알려주세요',
              ),
              NormalButton(
                  title: '다 적었어요',
                  color: mainPrimary,
                  onTap: () {
                    logger.i(
                      '${_nameController.text} / ${_emailController.text} / ${_phoneController.text}',
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

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