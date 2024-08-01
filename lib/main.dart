import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:saphy/screens/welcome/otp_screen.dart';
import 'package:saphy/screens/welcome/signup_screen.dart';
import 'package:saphy/screens/welcome/welcome_screen.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/screen_controller.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  String? kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'];
  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saphy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: altBlack),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignupScreen.id: (context) => const SignupScreen(
              socialType: '',
              userEmail: '',
              userName: '',
              userPhotoUrl: '',
              userToken: '',
            ),
        OtpScreen.id: (context) => const OtpScreen(),
      },
    );
  }
}
