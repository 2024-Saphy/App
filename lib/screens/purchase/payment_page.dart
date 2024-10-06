import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/screens/purchase/purchase_success.dart';

class Payment extends StatelessWidget {
  final Product product;
  const Payment({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      userCode: 'imp16147707',
      data: PaymentData(
          pg: 'tosspayments',
          payMethod: 'card',
          name: product.name,
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
          amount: product.price,
          buyerName: '홍길동',
          buyerTel: '01012345678',
          buyerEmail: 'example@naver.com',
          buyerAddr: '서울시 강남구 신사동 661-16',
          buyerPostcode: '06018',
          appScheme: 'example',
          cardQuota: [2, 3]),
      callback: (Map<String, String> result) async {
        if (result['success'] == 'true') {
          String? impUid = result['imp_uid'];
          String? merchantUid = result['merchant_uid'];
          await verifyIamport(impUid, merchantUid, context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PurchaseSuccess(),
            ),
          );
        } else {
          String? errorMsg = result['error_msg'];
          print('결제 실패: $errorMsg');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('결제 실패: $errorMsg')),
          );
        }
      },
    );
  }

  Future<void> verifyIamport(
      String? impUid, String? itemId, BuildContext context) async {
    final dio = Dio();

    if (impUid == null || itemId == null) return;

    final data = {
      'itemId': itemId,
      'impUid': impUid,
    };

    try {
      final response = await dio.post(
        'https://saphy.site/payments',
        data: data, // 수정된 부분
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버와 연결할 수 없습니다.')),
      );
    }
  }
}
