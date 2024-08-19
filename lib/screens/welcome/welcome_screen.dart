import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:saphy/models/loginInfo.dart';
import 'package:saphy/screens/welcome/loding_screen.dart';
import 'package:saphy/screens/welcome/signup_screen.dart';
import 'package:saphy/service/auth_service.dart';
import 'package:saphy/service/authentication/google_login_controller.dart';
import 'package:saphy/service/authentication/kakao_login_controller.dart';
import 'package:saphy/service/authentication/main_view_model.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/log.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/widgets/login_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = true;
  final kakaoViewModel = MainViewModel(KakaoLoginController());
  final googleViewModel = MainViewModel(GoogleLoginController());

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    final loginInfo = await readLoginInfo();
    final jwt = await readJwt();
    if (loginInfo != null) {
      LoginInfo userInfo = LoginInfo.fromJson(jsonDecode(loginInfo));
      final code = await loginService(userInfo.socialType, userInfo.email!);
      if (code == 200) {
        logger.i(
            "Auto Login Success : ${userInfo.email}, ${userInfo.socialType}, / JWT : $jwt");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ScreenController(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingScreen();
    }

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
                    onTap: () async {
                      final GoogleSignInAccount user =
                          await googleViewModel.login();

                      final code = await loginService('GOOGLE', user.email);

                      if (code == 200) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScreenController(),
                        ));
                      } else if (code == 300) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(
                              socialType: 'GOOGLE',
                              userName: user.displayName,
                              userEmail: user.email,
                              userPhotoUrl: user.photoUrl,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 5.0),
                  LoginButton(
                    title: '카카오 로그인',
                    logo: Image.asset(
                      'assets/images/Kakao.png',
                    ),
                    color: systemKakao,
                    onTap: () async {
                      final User user = await kakaoViewModel.login();
                      final code = await loginService(
                        'KAKAO',
                        user.kakaoAccount!.email!,
                      );
                      if (code == 200) {
                        //Login Success
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScreenController(),
                        ));
                      } else if (code == 300) {
                        //Navigate register screen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(
                              socialType: 'KAKAO',
                              userName: user.kakaoAccount?.profile?.nickname,
                              userEmail: user.kakaoAccount?.email,
                              userPhotoUrl:
                                  user.kakaoAccount?.profile?.thumbnailImageUrl,
                            ),
                          ),
                        );
                      }
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


                  // SizedBox(
                  //   width: 50.0,
                  //   child: Image.network(kakaoViewModel
                  //           .user?.kakaoAccount?.profile?.profileImageUrl ??
                  //       'https://beforeigosolutions.com/wp-content/uploads/2021/12/dummy-profile-pic-300x300-1.png'),
                  // ),
                  // LoginButton(
                  //   title: '카카오 로그아웃',
                  //   logo: Image.asset(
                  //     'assets/images/Kakao.png',
                  //   ),
                  //   color: systemKakao,
                  //   onTap: () async {
                  //     await kakaoViewModel.logout();
                  //     setState(() {});
                  //   },
                  // ),