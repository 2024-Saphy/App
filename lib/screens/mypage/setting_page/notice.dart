import 'package:flutter/material.dart';

class NoticeSetting extends StatefulWidget {
  const NoticeSetting({super.key});

  @override
  State<NoticeSetting> createState() => _NoticeSettingState();
}

class _NoticeSettingState extends State<NoticeSetting> {

  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false;
  bool switchValue5 = false;
  bool switchValue6 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "알림",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Pretendard",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "구매/판매 알림",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("구매 거래 현황",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("구매와 관련된 체결 및 배송 알림"),
                ],
              ),
              value: switchValue1,
              onChanged: (value) {
                setState(() {
                  switchValue1 = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SwitchListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("판매 거래 현황",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("판매와 관련된 체결 및 배송 알림"),
                ],
              ),
              value: switchValue2,
              onChanged: (value) {
                setState(() {
                  switchValue2 = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SwitchListTile(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("찜목록 알림",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("찜목록 상품 관련 알림"),
                ],
              ),
              value: switchValue3,
              onChanged: (value) {
                setState(() {
                  switchValue3 = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "광고성 정보 수신",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text("앱 푸시",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              value: switchValue4,
              onChanged: (value) {
                setState(() {
                  switchValue4 = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("문자메시지",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              value: switchValue5,
              onChanged: (value) {
                setState(() {
                  switchValue5 = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("이메일",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              value: switchValue6,
              onChanged: (value) {
                setState(() {
                  switchValue6 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
