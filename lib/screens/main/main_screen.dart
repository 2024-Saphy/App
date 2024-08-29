import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
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
      id: 1,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'Black',
      storage: '128GB',
      grade: 'A',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 250000,
      stock: 50,
    ),
    Product(
      id: 2,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'White',
      storage: '128GB',
      grade: 'A',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 250000,
      stock: 45,
    ),
    Product(
      id: 3,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'Blue',
      storage: '256GB',
      grade: 'B',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 270000,
      stock: 40,
    ),
    Product(
      id: 4,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'Red',
      storage: '256GB',
      grade: 'A',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 280000,
      stock: 35,
    ),
    Product(
      id: 5,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'Green',
      storage: '128GB',
      grade: 'C',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 240000,
      stock: 30,
    ),
    Product(
      id: 6,
      brand: "Apple",
      name: "iPhone 13",
      description: 'Latest iPhone model with A15 Bionic chip',
      color: 'Pink',
      storage: '512GB',
      grade: 'B',
      imageUrl:
          'https://i.pinimg.com/564x/f3/54/dc/f354dc1f040fc1fc4dfc4c436ad52159.jpg',
      price: 290000,
      stock: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 575,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://i.pinimg.com/736x/cf/aa/d7/cfaad78b35a7b752054dd564b77f1f10.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 25,
                          width: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/SaphyLogoSmallWhite.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/notifications.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text(
                      "Phone",
                      style: TextStyle(color: white, fontSize: 25),
                    ),
                    const Text(
                      "iPhone 15도\nSaphy에서.",
                      style: TextStyle(
                          color: white,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          height: 1.2),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
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
                  for (int i = 0; i < productLength; i++)
                    ProductCard(
                        brand: productList[i].brand ?? "",
                        name: productList[i].name ?? "",
                        imageUrl: productList[i].imageUrl ?? "",
                        price: productList[i].price ?? 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
