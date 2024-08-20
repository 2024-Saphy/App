import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:saphy/screens/purchase/purchase_page.dart';

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
      backgroundColor: const Color(0xfff4f4f4),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                width: 250,
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ),
          Flexible(
            flex: 5,
            child: SizedBox(
              height: 500,
              child: Center(
                child: Container(
                  height: 300,
                  width: 290,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(productImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${numberFormat.format(price)}원",
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: "Pretendard",
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Pretendard",
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              productBrand,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Pretendard",
                                fontSize: 30,
                              ),
                            ),
                            const Text(
                              "브랜드 보러가기",
                              style: TextStyle(
                                fontFamily: "Pretendard",
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PurchasePage()),
                              );
                            },
                            child: Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text("구매"),
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "판매",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
