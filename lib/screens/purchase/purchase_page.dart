import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/purchase/purchase_process_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';
import 'package:saphy/widgets/purchase_info.dart';
import 'package:saphy/models/product.dart';

class PurchasePage extends StatelessWidget {
  final Product product;

  const PurchasePage({
    super.key,
    required this.product,
  });

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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PurchaseHeader(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: PurchaseInfo(
                        productCondition: product.grade,
                        productColor: product.color,
                        productName: product.name,
                        price: product.price,
                        productStorage: product.storage,
                      ),
                    ),
                    const Spacer(),
                    PurchaseFooter(product: product),
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
  final Product product;

  const PurchaseFooter({
    super.key,
    required this.product,
  });

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
          color: gray800,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
        const SizedBox(height: 10),
        NormalButton(
          title: "구매하기",
          bgColor: black,
          txtColor: white,
          onTap: _isAgreed
              ? () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PurchaseProcessPage(
                        product: widget.product, // widget.product 사용
                      ),
                    ),
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
          color: gray800,
          thickness: 1,
          indent: 40,
          endIndent: 40,
        ),
      ],
    );
  }
}
