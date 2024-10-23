import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/mypage/setting_page/address.dart';
import 'package:saphy/screens/mypage/setting_page/cashreceipt.dart';
import 'package:saphy/screens/mypage/setting_page/login_info.dart';
import 'package:saphy/screens/mypage/setting_page/notice.dart';
import 'package:saphy/screens/mypage/setting_page/oss_page.dart';
import 'package:saphy/screens/mypage/setting_page/payments.dart';
import 'package:saphy/screens/mypage/setting_page/personalinformation.dart';
import 'package:saphy/screens/mypage/setting_page/terms.dart';
import 'package:saphy/screens/welcome/welcome_screen.dart';
import 'package:saphy/service/authentication/google_login_controller.dart';
import 'package:saphy/service/authentication/kakao_login_controller.dart';
import 'package:saphy/service/authentication/main_view_model.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/log.dart';
import 'package:saphy/widgets/normal_button.dart';
import '../../widgets/setting_menu.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("설정",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Pretendard")),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "일반",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SettingMenu(
              title: "로그인 정보",
              icon: Icons.info_outline,
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const LoginInfo()));
              },
            ),
            SettingMenu(
              title: "주소록",
              icon: Icons.list_alt,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const AddressList()));
              },
            ),
            SettingMenu(
              title: "결제 정보",
              icon: Icons.credit_card,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const PaymentsList()));
              },
            ),
            SettingMenu(
              title: "현금영수증 정보",
              icon: Icons.receipt_long,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const CashReceipt()));
              },
            ),
            SettingMenu(
              title: "알림",
              icon: Icons.notifications_none,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const NoticeSetting()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "정보",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SettingMenu(
              title: "이용약관",
              icon: Icons.list_alt_sharp,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const Terms()));
              },
            ),
            SettingMenu(
              title: "개인정보처리방침",
              icon: Icons.security,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const PersonalInformation()));
              },
            ),
            SettingMenu(
              title: "오픈소스 라이선스",
              icon: Icons.code_rounded,
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const OssPage()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            NormalButton(
              title: '로그아웃',
              bgColor: systemColorRed300,
              txtColor: white,
              onTap: () {
                logger.i("로그아웃 시작");
                final googleViewModel = MainViewModel(GoogleLoginController());
                googleViewModel.logout();
                final kakaoViewModel = MainViewModel(KakaoLoginController());
                googleViewModel.logout();
                kakaoViewModel.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
              flag: true,
            ),
          ],
        ),
      ),
    );
  }
}
