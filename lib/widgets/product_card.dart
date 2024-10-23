import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saphy/screens/products/product_detail_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/number_format.dart';
import 'package:saphy/utils/textstyles.dart';
import "package:saphy/models/product.dart";

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetail(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        width: (screenWidth - 55) / 2,
        height: 230,
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
                  image: CachedNetworkImageProvider(product.images[0].url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("${numberFormat.format(product.price)}원",
                      style: textStyle(20, true, black)),
                  Text(product.name, style: textStyle(16, false, gray800)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
