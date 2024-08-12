import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/mypage/setting_page/login_info.dart';
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
        title: const Text("설정", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Pretendard")),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "일반",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            SettingMenu(
              title: "로그인 정보",
              icon: Icons.info_outline,
              onTap: (){
                Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) => const LoginInfo()
                    )
                );
              },
            ),
            SettingMenu(
              title: "주소록",
              icon: Icons.list_alt,
              onTap: null,
            ),
            SettingMenu(
              title: "결제 정보",
              icon: Icons.credit_card,
              onTap: null,
            ),
            SettingMenu(
              title: "판매 정산 계좌",
              icon: Icons.monetization_on_outlined,
              onTap: null,
            ),
            SettingMenu(
              title: "현금영수증 정보",
              icon: Icons.receipt_long,
              onTap: null,
            ),
            SettingMenu(
              title: "알림",
              icon: Icons.notifications_none,
              onTap: null,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "정보",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            SettingMenu(
              title: "이용약관",
              icon: Icons.list_alt_sharp,
              onTap: null,
            ),
            SettingMenu(
              title: "개인정보처리방침",
              icon: Icons.security,
              onTap: null,
            ),
            SettingMenu(
              title: "오픈소스 라이선스",
              icon: Icons.code_rounded,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}
