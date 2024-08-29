import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:saphy/screens/products/product_detail_page.dart';
import 'package:saphy/utils/textstyles.dart';

class ProductCard extends StatelessWidget {
  final String productBrand;
  final String productName;
  final String productImageUrl;
  final double price;

  const ProductCard({
    super.key,
    required this.productBrand,
    required this.productName,
    required this.productImageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('###,###,###,###');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              productBrand: productBrand,
              productName: productName,
              productImageUrl: productImageUrl,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        width: 190,
        height: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(productImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(productName, style: bodyBoldText()),
                      Text(
                        productBrand,
                        style: const TextStyle(
                          fontFamily: "Pretendard",
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${numberFormat.format(price)}원",
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: "Pretendard",
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
