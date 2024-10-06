import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saphy/utils/product_provider.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/product_card.dart';

class ItemListPage extends StatefulWidget {
  final String name, url;
  const ItemListPage({super.key, required this.url, required this.name});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  ProductProvider? _productProvider;

  @override
  void dispose() {
    _productProvider?.cancelRequest(); // 미리 저장된 ProductProvider 사용
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productProvider = Provider.of<ProductProvider>(context, listen: false);
      _productProvider?.fetchProducts(widget.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          _buildHeader(widget.name),
          _buildProductCount(productProvider.count),
          _buildProductGrid(productProvider)
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: altWhite,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 25),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, size: 25),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(String name) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(name, style: titleText()),
      ),
    );
  }

  SliverPadding _buildProductCount(int count) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      sliver: SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "상품 ",
                style: subTitleText(bold: false),
                children: <TextSpan>[
                  TextSpan(text: "$count", style: subTitleText())
                ],
              ),
            ),
            IconButton(
                icon: const Icon(
                  Icons.sort,
                  size: 20,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildProductGrid(ProductProvider provider) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.products.isEmpty
                ? const Center(child: Text('상품이 없습니다'))
                : Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 15,
                    runSpacing: 15,
                    children: provider.products
                        .map((product) => ProductCard(product: product))
                        .toList(),
                  ),
      ),
    );
  }
}
