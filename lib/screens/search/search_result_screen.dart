import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/product_card.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/widgets/textfield.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;

  const SearchResultScreen({super.key, required this.query});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController _controller;
  Future<List<Product>>? _products;
  int cnt = 0;

  Future<void> countProducts() async {
    List<Product> products = await searchText(widget.query);
    setState(() {
      cnt = products.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _products = searchText(widget.query);
    countProducts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: altWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            textField(
              _controller,
              context,
              (String value) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SearchResultScreen(query: value),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  _products = searchText(_controller.text);
                });
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(slivers: [
        _buildSorter(),
        SliverPadding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          sliver: SliverToBoxAdapter(
            child: FutureBuilder<List<Product>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error.toString()}'));
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
            ),
          ),
        ),
      ]),
    );
  }

  Future<List<Product>> searchText(String value) async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://saphy.site/api/items?size=20&query=$value');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['results'] != null) {
          List<Product> products = (data['results'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          return products;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
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
}
