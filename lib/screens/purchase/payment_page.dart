import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/screens/purchase/purchase_success.dart';
import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/colors.dart';

class Payment extends StatelessWidget {
  final Product product;
  const Payment({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preparePayment(product),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: white,
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('결제 준비 실패'), // 결제 준비가 실패한 경우 표시할 UI
          );
        }

        if (snapshot.hasData) {
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
              merchantUid: merchantUid, // 준비된 merchantUid 사용
              amount: amount, // 준비된 amount 사용
              buyerName: '홍길동',
              buyerTel: '01012345678',
              buyerEmail: 'example@naver.com',
              buyerAddr: '서울시 강남구 신사동 661-16',
              buyerPostcode: '06018',
              appScheme: 'example',
              cardQuota: [2, 3],
            ),
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

        // 기본적으로 로딩 UI를 표시
        return const Center(
          child: CircularProgressIndicator(), // 기본적으로 결제 준비 중 로딩 표시
        );
      },
    );
  }

  // preparePayment 함수는 결제 준비 데이터를 서버에서 받아오는 역할
  Future<Map<String, dynamic>?> preparePayment(Product product) async {
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    final param = {
      'itemId': product.id,
      'quantity': 1,
      'amount': product.price,
      'payMethod': 'CREDIT_CARD',
    };

    try {
      final response = await APIService.instance.request(
        '/payments/prepare',
        DioMethod.post,
        contentType: 'application/json',
        token: "Bearer $token",
        param: param,
      );

      if (response.statusCode == 200 && response.data != null) {
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
  Future<void> verifyIamport(
      String? impUid, String? itemId, BuildContext context) async {
    // JWT 토큰 읽기
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    // impUid 또는 itemId가 없을 경우 중단
    if (impUid == null || itemId == null) return;

    // 결제 검증에 사용할 파라미터
    final param = {
      "merchantUid":
          "ORD-8d323fff-339a-4707-89b1-7b1cbb1681f6", // 실제 merchantUid 값을 가져오거나 사용
      "itemId": itemId,
      "impUid": impUid, // Iamport에서 반환된 impUid를 사용
      "amount": 999.99 // 실제 결제 금액을 사용
    };

    try {
      // API 요청 보내기 (POST)
      final response = await APIService.instance.request(
        '/payments/complete',
        DioMethod.post,
        contentType: 'application/json',
        token: "Bearer $token", // JWT 토큰을 헤더에 포함
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
