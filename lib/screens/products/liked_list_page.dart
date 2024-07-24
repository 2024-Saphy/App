import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/widgets/bottom_nav_bar.dart';
import 'package:saphy/widgets/product_card.dart';
import 'package:saphy/screens/main/main_screen.dart';

class LikedListPage extends StatefulWidget {
  const LikedListPage({super.key});

  @override
  State<LikedListPage> createState() => _LikedListPageState();
}

class _LikedListPageState extends State<LikedListPage> {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');
  List<Product> productList = [
    // 그냥 구현용 샘플 데이터
    // 아직 좋아한거 띄우는건 못함
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
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
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
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Text(
                "Wish List",
                style: TextStyle(
                  fontFamily: "Prompt",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductCard(
                      productBrand: productList[index].productBrand ?? "",
                      productName: productList[index].productName ?? "",
                      productImageUrl: productList[index].productImageUrl ?? "",
                      price: productList[index].price ?? 0);
                },
                childCount: productList.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.84,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}
