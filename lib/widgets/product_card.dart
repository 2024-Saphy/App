import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

Widget productCard({
  required String productBrand,
  required String productName,
  required String productImageUrl,
  required double price,
}) {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: CachedNetworkImageProvider(productImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productBrand,
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 15,
                )),
            Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Pretendard",
                fontSize: 15,
              ),
            ),
            Text(
              "${numberFormat.format(price)}원",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Pretendard",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
