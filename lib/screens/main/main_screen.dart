import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/screens/products/item_list_page.dart';
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
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = getProducts();
  }

  Future<List<Product>> getProducts() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://saphy.site/api/items?size=20');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['results'] != null) {
          List<Product> products = (data['results'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          return products;
        } else {
          throw Exception('No results found in the response');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: 25,
            child: Image(
                image: AssetImage('assets/images/SaphyLogoSmallWhite.png')),
          ),
        ),
        backgroundColor: Colors.transparent, //appBar 투명색
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: altWhite,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Carousel(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      categoryButton("전체", "ALL"),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryButton("스마트폰", "PHONE"),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryButton("태블릿", "TABLET"),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryButton("노트북", "LAPTOP"),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryButton("음향기기", "headphone-3d"),
                      const SizedBox(
                        width: 20,
                      ),
                      categoryButton("웨어러블", "wearable-3d"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("전체 상품", style: titleText()),
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
                  FutureBuilder(
                      future: _products,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error.toString()}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No products found')); // 데이터 없음 메시지
                        } else {
                          final products = snapshot.data!; // 데이터 가져오기
                          return Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 15,
                            runSpacing: 15,
                            children: products
                                .map((product) => ProductCard(product: product))
                                .toList(),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell categoryButton(String category, String url) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemListPage(
              name: category,
              url: url,
            ),
          ),
        );
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/$url.png'),
                  fit: BoxFit.cover,
                )),
              ),
              Text(
                category,
                style: const TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: 15,
                    color: black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
