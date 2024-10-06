import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/models/product.dart';
import 'package:dio/dio.dart';
import 'package:saphy/widgets/product_card.dart';

class ItemListPage extends StatefulWidget {
  final String name, url;
  const ItemListPage({super.key, required this.url, required this.name});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  late Future<List<Product>> _products;
  int cnt = 0;

  @override
  void initState() {
    super.initState();
    _products = getProducts();
    countProducts();
  }

  Future<void> countProducts() async {
    List<Product> products = await getProducts(); // getProducts()에서 결과를 대기
    setState(() {
      cnt = products.length; // 제품 개수를 cnt에 설정
    });
  }

  Future<List<Product>> getProducts() async {
    final dio = Dio();
    try {
      final response = await dio
          .get('https://saphy.site/api/items?deviceType=${widget.url}&size=20');
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
      print('Error: ${e.toString()}'); // 오류 메시지 확인
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: altWhite,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Text(
                widget.name,
                style: titleText(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          return const Center(child: Text('No products found'));
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
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildFilterButton(String label) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gray300, width: 1),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
