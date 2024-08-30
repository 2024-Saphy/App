import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:simple_shadow/simple_shadow.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  final kakaoViewModel = MainViewModel(KakaoLoginController());
  final googleViewModel = MainViewModel(GoogleLoginController());

  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  final double _imageWidth = 1600.0;
  final double _startPadding = 72.0;

  @override
  void initState() {
    super.initState();
    _autoLogin();

    _logoController = AnimationController(
      duration: const Duration(seconds: 150),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double screenWidth = MediaQuery.of(context).size.width;
      _logoAnimation = TweenSequence([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: _startPadding,
            end: -_imageWidth,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: screenWidth,
            end: -_imageWidth,
          ),
          weight: 1,
        ),
      ]).animate(
        CurvedAnimation(
          parent: _logoController,
          curve: Curves.linear,
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
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
      backgroundColor: newGray,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Positioned(
                      left: _logoAnimation.value,
                      top: 150.0,
                      child: SimpleShadow(
                        opacity: 0.25,
                        offset: const Offset(8, 15),
                        child: SvgPicture.asset(
                          'assets/images/LogoBig.svg',
                          width: _imageWidth,
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'electronics flea-market, ',
                          style: TextStyle(
                            fontFamily: 'Prompt-Thin',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w100,
                            color: white,
                          ),
                        ),
                        Text(
                          ' Saphy',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
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
                                userPhotoUrl: user
                                    .kakaoAccount?.profile?.thumbnailImageUrl,
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
                        color: white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40.0),
                  ],
                )
              ],
            ),
          ),
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