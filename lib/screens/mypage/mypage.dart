import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/mypage/edit_profile.dart';
import 'package:saphy/screens/mypage/setting.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff4f4f4),
        appBar: AppBar(
          backgroundColor: altWhite,
          centerTitle: true,
          title: Text(
            "마이페이지",
            style: titleText(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // 설정 페이지 이동
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const SettingPage()));
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/56/28/6f/56286feaa430d8d83dbe9382f8c10c8d.jpg",
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "홍길동",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "gildong9403",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Pretendard",
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const EditProfile()));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black38,
                          ),
                        ),
                        child: const Text("프로필 수정",
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("배송/수거 상태", style: subTitleText()),
                              const Spacer(),
                              // 더보기
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 1, bottom: 1, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: const Text("더보기",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Pretendard",
                                        color: Colors.black,
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("발송요청",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.black26,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매대기",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매 중",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("정산완료",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("기기 판매 내역", style: subTitleText()),
                              const Spacer(),
                              // 더보기
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 1, bottom: 1, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: const Text("더보기",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Pretendard",
                                        color: Colors.black,
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("발송요청",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.black26,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매대기",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매 중",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("정산완료",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.post_add,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("보관 신청하기",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Pretendard",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("한 번에 신청하고 한 번에 발송하세요.",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Pretendard",
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 15),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("기기 구매 내역", style: subTitleText()),
                              const Spacer(),
                              // 더보기
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 1, bottom: 1, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: const Text("더보기",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Pretendard",
                                        color: Colors.black,
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("발송요청",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.black26,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매대기",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("판매 중",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("정산완료",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Pretendard",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text("0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Pretendard",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
