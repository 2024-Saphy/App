import 'package:flutter/material.dart';

class PaymentsList extends StatefulWidget {
  const PaymentsList({super.key});

  @override
  State<PaymentsList> createState() => _PaymentsListState();
}

class _PaymentsListState extends State<PaymentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "결제 정보",
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                child: const Text(
                  "새로운 카드 추가",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // 결제 정보 리스트
            PaymentItem(
              title: "신한카드",
              cardNumber: "1234-5678-1234-5678",
            ),
            PaymentItem(
              title: "국민카드",
              cardNumber: "1234-5678-1234-5678",
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  final String title;
  final String cardNumber;

  const PaymentItem({super.key, required this.title, required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              cardNumber,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
      ],
    );
  }
}

