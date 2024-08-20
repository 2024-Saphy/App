import 'package:flutter/material.dart';
import 'package:saphy/screens/purchase/purchase_process_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';
import 'package:saphy/widgets/purchase_info.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: Column(
        children: [
          const Spacer(flex: 1),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PurchaseHeader(),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: PurchaseInfo(
                        // 요기는 나중에는 상품 모델 백엔이랑 해서 정해지면 모델에서 정보 받아올듯
                        productCondition: "A",
                        productColor: "그린",
                        productName: "Iphone 14",
                        price: 130000,
                        productStorage: "128G",
                      ),
                    ),
                    Spacer(),
                    PurchaseFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PurchaseFooter extends StatefulWidget {
  const PurchaseFooter({super.key});

  @override
  State<PurchaseFooter> createState() => _PurchaseFooterState();
}

class _PurchaseFooterState extends State<PurchaseFooter> {
  bool _isAgreed = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isAgreed = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            value: _isAgreed,
            onChanged: _toggleCheckbox,
            activeColor: mainPrimary,
          ),
          title: const Text(
            "상품 정보를 확인하였습니다.",
            style: TextStyle(
                fontFamily: "Pretendard",
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        const Divider(
          color: black,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
        const SizedBox(height: 10),
        NormalButton(
          title: "구매하기",
          bgColor: white,
          txtColor: black,
          onTap: _isAgreed
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (const PurchaseProcessPage())),
                  );
                }
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('상품 정보를 확인해 주세요.')),
                  );
                },
          flag: true,
        ),
      ],
    );
  }
}

class PurchaseHeader extends StatelessWidget {
  const PurchaseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 48,
            ),
            const Text(
              "구매하기",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontFamily: "Pretendard",
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
          color: black,
          thickness: 1,
          indent: 40,
          endIndent: 40,
        ),
      ],
    );
  }
}
