import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:saphy/service/google_login_controller.dart';
import 'package:saphy/service/kakao_login_controller.dart';
import 'package:saphy/service/main_view_model.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/login_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final viewModel = MainViewModel(KakaoLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset('assets/images/LogoBig.png')),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'electronics flea-market',
                    style: TextStyle(
                      fontFamily: 'Prompt-Thin',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w100,
                      color: altBlack,
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                    title: '구글 로그인',
                    logo: Image.asset(
                      'assets/images/Google.png',
                      width: 20.0,
                    ),
                    color: white,
                    onTap: () {},
                  ),
                  const SizedBox(height: 5.0),
                  LoginButton(
                    title: '카카오 로그인',
                    logo: Image.asset(
                      'assets/images/Kakao.png',
                    ),
                    color: systemKakao,
                    onTap: () async {
                      await viewModel.login();
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 50.0,
                    child: Image.network(viewModel
                            .user?.kakaoAccount?.profile?.profileImageUrl ??
                        'https://beforeigosolutions.com/wp-content/uploads/2021/12/dummy-profile-pic-300x300-1.png'),
                  ),
                  LoginButton(
                    title: '카카오 로그아웃',
                    logo: Image.asset(
                      'assets/images/Kakao.png',
                    ),
                    color: systemKakao,
                    onTap: () async {
                      await viewModel.logout();
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'By tapping Sign in and using Saphy, \n you agree to our Terms and Privacy Policy.',
                    style: TextStyle(
                      fontFamily: 'Prompt-Regular',
                      fontWeight: FontWeight.w200,
                      color: altBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
