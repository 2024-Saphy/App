import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/widgets/app_bar.dart';
import 'package:saphy/widgets/product_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');
  final int productLength = 6;
  List<Product> productList = [
    // 그냥 구현용 샘플 데이터
    Product(
        productNo: 1,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
    Product(
        productNo: 2,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
    Product(
        productNo: 3,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
    Product(
        productNo: 4,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
    Product(
        productNo: 5,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
    Product(
        productNo: 6,
        productBrand: "Apple",
        productName: "Iphone 15",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 250000),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Saphy",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xfff4f4f4),
        appBar: const TopAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "https://i.pinimg.com/564x/56/28/6f/56286feaa430d8d83dbe9382f8c10c8d.jpg",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xffDFE1E6),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "중고기기를 안전하게 구매하는 방법",
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "사피 초대하고 지원금 받기",
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                    for (int i = 0; i < productLength; i++)
                      ProductCard(
                          productBrand: productList[i].productBrand ?? "",
                          productName: productList[i].productName ?? "",
                          productImageUrl: productList[i].productImageUrl ?? "",
                          price: productList[i].price ?? 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
