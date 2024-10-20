import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/screens/screen_controller.dart';
import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/product_card.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/app_bar.dart';

class LikedListPage extends StatefulWidget {
  const LikedListPage({super.key});

  @override
  State<LikedListPage> createState() => _LikedListPageState();
}

class _LikedListPageState extends State<LikedListPage> {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');
  late Future<List<Product>> _products;
  int cnt = 0;

  Future<List<Product>> getProducts(String url) async {
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    try {
      final response = await APIService.instance.request(
        'https://saphy.site/item-wishes?type=$url',
        DioMethod.get,
        contentType: 'application/json',
        token: "Bearer $token",
      );

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
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _products = getProducts("ALL");
    countProducts("ALL");
  }

  Future<void> countProducts(String url) async {
    List<Product> products = await getProducts(url);
    setState(() {
      cnt = products.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: TopAppBar(
        backAction: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => (const ScreenController())));
        },
        label: "찜 목록",
        searchable: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildFilterButton("전체", "ALL"),
                      const SizedBox(
                        width: 10,
                      ),
                      buildFilterButton("스마트폰", "PHONE"),
                      const SizedBox(
                        width: 10,
                      ),
                      buildFilterButton("태블릿", "TABLET"),
                      const SizedBox(
                        width: 10,
                      ),
                      buildFilterButton("노트북", "LAPTOP"),
                      const SizedBox(
                        width: 10,
                      ),
                      buildFilterButton("음향기기", "headphone-3d"),
                      const SizedBox(
                        width: 10,
                      ),
                      buildFilterButton("웨어러블", "wearable-3d"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          _buildSorter(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error.toString()}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                'assets/images/Question-3d.png',
                                width: 180.0,
                              ),
                            ),
                            Text(
                              '상품이 없습니다',
                              style: textStyle(20, true, null),
                            ),
                          ],
                        ));
                      } else {
                        final products = snapshot.data!;
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
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildSorter() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      sliver: SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '상품 $cnt',
              style: subTitleText(),
            ),
            IconButton(
              icon: const Icon(Icons.sort_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildFilterButton(String label, String url) {
    return InkWell(
      onTap: () {
        setState(() {
          // URL에 따라 제품을 다시 가져오고, 상태를 업데이트합니다.
          _products = getProducts(url);
          countProducts(url); // 필터에 맞는 제품 개수를 카운트합니다.
        });
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: gray300, width: 1),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
          child: Center(
            child: Text(label, style: textStyle(15, false, null)),
          ),
        ),
      ),
    );
  }
}
