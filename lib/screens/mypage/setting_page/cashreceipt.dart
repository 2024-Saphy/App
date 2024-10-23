import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/normal_button.dart';

class CashReceipt extends StatefulWidget {
  const CashReceipt({super.key});

  @override
  State<CashReceipt> createState() => _CashReceiptState();
}

class _CashReceiptState extends State<CashReceipt> {

  String dropdownValue = "휴대폰 번호";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "현금영수증 정보",
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
              "발급방식",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            // 드롭다운 방식
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: DropdownButton<String>(
                value: dropdownValue,
                items: const [
                  DropdownMenuItem(
                    value: "휴대폰 번호",
                    child: Text("휴대폰 번호"),
                  ),
                  DropdownMenuItem(
                    value: "현금영수증 카드",
                    child: Text("현금영수증 카드"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                isExpanded: true,
                hint: const Text("발급방식을 선택해주세요."),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "휴대폰 번호",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "휴대폰 번호를 입력해주세요.",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: systemColorBlue300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("현금 영수증 정보를 저장 할 시 자동으로 해당 정보로 현금 영수증이 발급됩니다."),
            const Spacer(),
            NormalButton(
              title: '저장하기',
              bgColor: systemColorBlue300,
              txtColor: white,
              onTap: () {
                Navigator.pop(context);
                const SnackBar(
                  content: Text("저장되었습니다."),
                  duration: Duration(seconds: 1),
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