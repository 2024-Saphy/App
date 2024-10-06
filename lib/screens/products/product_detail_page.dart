import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saphy/screens/purchase/purchase_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/number_format.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/models/product.dart';
import 'package:dio/dio.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product? productDetail;

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  Future<void> loadProduct() async {
    Product product = await getProduct();
    setState(() {
      productDetail = product;
    });
  }

  Future<Product> getProduct() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://saphy.site/api/items/${widget.product.id}');
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        List<dynamic> results = data['results'];
        if (results.isNotEmpty) {
          Product product = Product.fromJson(results[0]);
          return product;
        } else {
          throw Exception('No results found in the response');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: ${e.toString()}'); // 오류 메시지 확인
      return Product(
        id: 0,
        deviceType: "deviceType",
        name: "name",
        description: "description",
        price: 0,
        stock: 0,
        images: [ImageModel(name: "name", url: "url")],
        brand: "brand",
        color: "color",
        storage: "storage",
        grade: "grade",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: altWhite,
        automaticallyImplyLeading: false,
        title: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () {},
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Center(
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.product.images[0].url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "출고가 ",
                          style: const TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 15,
                            color: gray700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: numberFormat.format(widget.product.price),
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: gray700,
                                fontFamily: "Pretendard",
                                fontSize: 15,
                                color: gray700,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Pretendard",
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: "30% ",
                                style: TextStyle(
                                  color: mainPrimary,
                                )),
                            TextSpan(
                              text:
                                  "${numberFormat.format(widget.product.price)}원",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "[${productDetail?.grade}] ${widget.product.name} ${productDetail?.storage} ${productDetail?.color}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Pretendard",
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 213, 0),
                            size: 20,
                          ),
                          Text.rich(
                            TextSpan(
                              style: bodyText(),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: " 4.8 ",
                                ),
                                TextSpan(
                                  text: "후기 5개",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // 등급 안내 상자
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(222, 222, 222, 1),
                          gradient: const LinearGradient(
                            begin: Alignment(-0.92, -0.39),
                            end: Alignment(0.92, 0.39),
                            colors: [
                              Color(0xffa1a1a1),
                              Color(0xffdedede),
                              Color(0xffdedede),
                              Color(0xffdedede),
                              Color(0xffdedede),
                              white,
                              white,
                              Color(0xffffffff),
                              Color(0xffdedede),
                              Color(0xffdedede),
                              Color(0xffdedede),
                              Color(0xffa1a1a1),
                            ],
                            stops: [
                              0,
                              0.16,
                              0.21,
                              0.24,
                              0.27,
                              0.36,
                              0.45,
                              0.6,
                              0.72,
                              0.8,
                              0.84,
                              1
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '해당 상품은 등급 ${productDetail?.grade} 제품입니다.',
                                    style: bodyText(),
                                  ),
                                  Text(
                                    "Grade ${productDetail?.grade}",
                                    style: titleText30(),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: InkWell(
                                      child: Container(
                                        width: screenWidth * 0.32,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff404756),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            "실제 사진 보기",
                                            style: TextStyle(
                                                fontFamily: "Pretendard",
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: InkWell(
                                      child: Container(
                                        width: screenWidth * 0.32,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff404756),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "${productDetail?.grade}등급 리뷰 보기",
                                            style: const TextStyle(
                                                fontFamily: "Pretendard",
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      spaceDivider("다른 색상 메뉴"),
                      const SizedBox(height: 20),
                      spaceDivider("쿠폰 발급 메뉴"),
                      const SizedBox(height: 20),
                      Row(
                        // 버튼
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(flex: 1, child: button("구매하기")),
                          const SizedBox(width: 10),
                          Flexible(flex: 1, child: button("판매하기")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      spaceDivider("상품 정보 사진 칸"),
                      const SizedBox(height: 20),
                      spaceDivider("댓글 칸"),
                      const SizedBox(height: 160),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              height: 100,
              color: altWhite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline)),
                    const SizedBox(width: 10),
                    Flexible(flex: 1, child: button("구매하기")),
                    const SizedBox(width: 10),
                    Flexible(flex: 1, child: button("판매하기")),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell button(String label) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PurchasePage(
                    product: widget.product,
                  )),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff404756),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Pretendard",
              fontSize: 15,
              color: white,
            ),
          ),
        ),
      ),
    );
  }

  Container spaceDivider(String label) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gray400, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(label),
      ),
    );
  }
}
