import 'package:flutter/material.dart';
import 'package:saphy/models/accountinfo.dart';
import 'package:saphy/service/mypage/account_service.dart';

import '../../../service/authentication/google_login_controller.dart';
import '../../../service/authentication/kakao_login_controller.dart';
import '../../../service/authentication/main_view_model.dart';
import '../../../utils/log.dart';
import '../../welcome/welcome_screen.dart';

class LoginInfo extends StatefulWidget {
  const LoginInfo({super.key});

  @override
  State<LoginInfo> createState() => _LoginInfoState();
}

class _LoginInfoState extends State<LoginInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "로그인 정보",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Pretendard",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<AccountInfo>(
              future: getMyAccount(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "나의 계정 정보",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "이름",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        "내 이메일",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.loginId.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.fromBorderSide(BorderSide(
                                color: data.socialType.toString() == "KAKAO" ? Colors.yellow : Colors.blue,
                                width: 2,
                              )),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              data.socialType.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "휴대폰 번호",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.phoneNumber.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: const BoxDecoration(
                              border: Border.fromBorderSide(BorderSide(
                                color: Colors.black,
                                width: 2,
                              )),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text(
                              "변경",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                    style:
                    const TextStyle(color: Colors.black),
                  ); // 오류 처리
                }
                // 데이터 로딩 중 표시할 위젯
                return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.black,),
                    )
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () async {
                // 팝업으로 재확인
                final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("회원탈퇴"),
                      content: const Text("정말로 회원탈퇴를 하시겠습니까?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("취소"),
                        ),
                        TextButton(
                          onPressed: () async{
                            logger.i("회원탈퇴 시작");
                            await deleteAccount();
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
                          child: const Text("확인"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("회원탈퇴", style: TextStyle(color: Colors.red, fontSize: 15)),
            )
          ],
        ),
      ),
    );
  }
}
