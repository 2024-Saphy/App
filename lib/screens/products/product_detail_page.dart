import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:saphy/screens/purchase/purchase_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class ProductDetail extends StatelessWidget {
  final String productBrand;
  final String productName;
  final String productImageUrl;
  final double price;

  const ProductDetail({
    super.key,
    required this.productBrand,
    required this.productName,
    required this.productImageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('###,###,###,###');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: altWhite,
        automaticallyImplyLeading: false,
        title: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline_outlined),
            onPressed: () {},
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Center(
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(productImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "출고가 500,000원",
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 15,
                      color: gray700,
                    ),
                  ),
                  Text(
                    "30% ${numberFormat.format(price)}원",
                    style: titleText30(),
                  ),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Pretendard",
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 213, 0),
                        size: 20,
                      ),
                      Text(
                        "4.8 후기 5개",
                        style: bodyText(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // 버튼
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PurchasePage()),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff404756),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "구매하기",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pretendard",
                                  fontSize: 15,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff404756),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "판매하기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pretendard",
                                fontSize: 15,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // 등급 안내 상자
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: gray400, width: 0.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '해당 상품은 등급 A 제품입니다.',
                                style: bodyText(),
                              ),
                              Text(
                                "Grade A",
                                style: titleText30(),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: mainPrimary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "실제 사진 보기",
                                        style:
                                            TextStyle(fontFamily: "Pretendard"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: mainPrimary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "A등급 리뷰 보기",
                                        style:
                                            TextStyle(fontFamily: "Pretendard"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: gray400, width: 0.5)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
