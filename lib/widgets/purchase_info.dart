import 'package:flutter/material.dart';

class PurchaseInfo extends StatelessWidget {
  final String productCondition;
  final String productName;
  final String productStorage;
  final String productColor;
  final double price;

  const PurchaseInfo({
    super.key,
    required this.productCondition,
    required this.productName,
    required this.productStorage,
    required this.productColor,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildInfoRow("상품 상태", productCondition),
          buildInfoRow("기종", productName),
          buildInfoRow("저장공간", productStorage),
          buildInfoRow("색상", productColor),
        ],
      ),
    );
  }

  Row buildInfoRow(String label, String value) {
    const labelTextStyle = TextStyle(
      fontFamily: "Pretendard",
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    const valueTextStyle = TextStyle(
      fontFamily: "Pretendard",
      fontSize: 20,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelTextStyle),
        Text(value, style: valueTextStyle),
      ],
    );
  }
}
