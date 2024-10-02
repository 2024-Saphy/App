import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/carousel.dart';
import 'package:saphy/widgets/product_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');
  final int productLength = 6;
  // Future<List<Product>> getProduct = getProducts();

  Product product = Product(
    id: 1,
    name: "iPhone 14",
    brand: "Apple",
    images: {
      "name": "iPhone 14",
      'url':
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
    },
    price: 130000.0,
    description: "Latest model from Apple with advanced features.",
    color: "Green",
    storage: "128GB",
    grade: "A",
    deviceType: "phone",
    stock: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altWhite,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Carousel(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("최근 확인한 상품", style: titleText()),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                spacing: 15,
                runSpacing: 15,
                children: [
                  ProductCard(
                    product: product,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Product>> getProducts() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://saphy.site/item-wishes');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return []; // Return an empty list in case of error
    }
  }
}
