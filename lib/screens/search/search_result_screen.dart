import 'package:dio/dio.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _products = searchText(widget.query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
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
                  MaterialPageRoute(
                    builder: (context) => SearchResultScreen(query: value),
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
        SliverPadding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
          throw Exception('검색 결과가 없습니다.');
        }
      } else {
        throw Exception('상품 로드에 실패했습니다.');
      }
    } catch (e) {
      throw Exception('에러가 발생했습니다.');
    }
  }
}
