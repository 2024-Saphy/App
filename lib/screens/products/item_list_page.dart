import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/app_bar.dart';
import 'package:saphy/widgets/product_card.dart';
import 'package:dio/dio.dart';
import 'package:saphy/models/product.dart';

class ItemListPage extends StatefulWidget {
  final String name, url;
  const ItemListPage({super.key, required this.url, required this.name});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
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
    List<Product> products = await getProducts();
    setState(() {
      cnt = products.length;
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
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: TopAppBar(label: widget.name),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          _buildSorter(),
          _buildProductGrid(),
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

  SliverPadding _buildProductGrid() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20, top: 10),
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
                  return const Center(child: Text('상품이 없습니다'));
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
