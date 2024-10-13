import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/screens/purchase/purchase_fail.dart';
import 'package:saphy/screens/purchase/purchase_success.dart';
import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class Payment extends StatelessWidget {
  final Product product;
  const Payment({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altWhite,
      body: FutureBuilder(
        future: preparePayment(product),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: white,
              ),
            );
          }

          if (snapshot.data != null) {
            final paymentData = snapshot.data as Map<String, dynamic>;
            final String merchantUid = paymentData['merchantUid'];
            final double amount = paymentData['amount'];

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
                merchantUid: merchantUid,
                amount: amount,
                buyerName: '홍길동',
                buyerTel: '01012345678',
                buyerEmail: 'example@naver.com',
                buyerAddr: '서울시 강남구 신사동 661-16',
                buyerPostcode: '06018',
                appScheme: 'example',
                cardQuota: [2, 3],
              ),
              callback: (Map<String, String> result) async {
                print('결제 결과: $result');

                if (result['success'] == 'true') {
                  String? impUid = result['imp_uid'];
                  String? merchantUid = result['merchant_uid'];
                  await verifyIamport(product.id, impUid, merchantUid, context);
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
          return const Text("결제 실패!");
          // return Center(
          //   child: Column(
          //     children: [
          //       const Text("결제 실패"),
          //       NormalButton(
          //           title: "홈으로 돌아가기",
          //           bgColor: black,
          //           txtColor: white,
          //           onTap: () {},
          //           flag: true)
          //     ],
          //   ),
          // );
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> preparePayment(Product product) async {
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    final param = {
      'itemId': product.id,
      'quantity': 1,
      'amount': '${product.price}.00',
      'payMethod': 'CREDIT_CARD',
    };

    try {
      final response = await APIService.instance.request(
        'https://saphy.site/payments/prepare',
        DioMethod.post,
        contentType: 'application/json',
        token: "Bearer $token",
        param: param,
      );

      final statusCode = response.data['status']['code'];

      if (statusCode == 200) {
        final data = response.data;
        final merchantUid = data['results'][0]['merchantUid'];
        final amount = data['results'][0]['amount'];
        return {'merchantUid': merchantUid, 'amount': amount};
      } else {
        throw Exception('결제 준비 실패');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // 결제 후 Iamport에서 검증하는 함수
  Future<void> verifyIamport(int itemId, String? impUid, String? merchantUid,
      BuildContext context) async {
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    if (impUid == null) return;

    final param = {
      "merchantUid": merchantUid,
      "itemId": itemId,
      "impUid": impUid,
      "amount": "${product.price}.00"
    };

    try {
      final response = await APIService.instance.request(
        'https://saphy.site/payments/complete',
        DioMethod.post,
        contentType: 'application/json',
        token: "Bearer $token",
        param: param,
      );

      if (response.statusCode == 200) {
        // 결제 검증 성공 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제 검증 성공')),
        );
      } else {
        // 실패 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제 검증 실패')),
        );
      }
    } catch (e) {
      // 예외 처리
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버와 연결할 수 없습니다.')),
      );
    }
  }
}
