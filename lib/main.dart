import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:saphy/provider/image_provider.dart';
import 'package:saphy/screens/screen_controller.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'];
  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageProviderModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ScreenController();
    // return MaterialApp(
    //   title: 'Saphy',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: altBlack),
    //     useMaterial3: true,
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: WelcomeScreen.id,
    //   routes: {
    //     WelcomeScreen.id: (context) => const WelcomeScreen(),
    //     SignupScreen.id: (context) => const SignupScreen(
    //           socialType: '',
    //           userEmail: '',
    //           userName: '',
    //           userPhotoUrl: '',
    //         ),
    //     OtpScreen.id: (context) => OtpScreen(
    //           verificationId: '',
    //           phoneNumber: '',
    //           onVerificationSuccess: () {},
    //         ),
    //     SplashSellingScreen.id: (context) => const SplashSellingScreen(),
    //     ScreenController.id: (context) => const ScreenController(),
    //   },
    // );
  }
}
