import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:saphy/screens/purchase/purchase_page.dart';
import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/number_format.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product? productDetail;
  bool isWished = false;
  late SharedPreferences wished;

  Future initWishes() async {
    wished = await SharedPreferences.getInstance();
    final wishedList = wished.getBool(widget.product.id.toString());
    if (wishedList != null) {
      setState(() {
        isWished = true;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    loadProduct();
    initWishes();
  }

  Future<void> loadProduct() async {
    Product product = await getProduct();
    setState(() {
      productDetail = product;
    });
  }

  Future<Product> getProduct() async {
    String token = await readJwt();
    token = token.toString().split(" ")[2];

    try {
      final response = await APIService.instance.request(
        'https://saphy.site/api/items/${widget.product.id}',
        DioMethod.get,
        contentType: 'application/json',
        token: "Bearer $token",
      );

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
        descriptionImage: ImageModel(name: "name", url: "url"),
      );
    }
  }

  Future<void> toggleWish() async {
    try {
      String token = await readJwt();
      token = token.toString().split(" ")[2];

      if (!isWished) {
        final response = await APIService.instance.request(
          'https://saphy.site/item-wishes?itemId=${widget.product.id}',
          DioMethod.post,
          contentType: 'application/json',
          token: "Bearer $token",
        );

        if (response.statusCode == 200) {
          await wished.setBool(widget.product.id.toString(), true);
          setState(() {
            isWished = true;
          });
        }
      } else {
        final response = await APIService.instance.request(
          'https://saphy.site/item-wishes/${widget.product.id}',
          DioMethod.delete,
          contentType: 'application/json',
          token: "Bearer $token",
        );

        if (response.statusCode == 200) {
          await wished.setBool(widget.product.id.toString(), false);
          setState(() {
            isWished = false; // 아이템이 찜 해제 상태로 변경
          });
        }
      }
    } catch (e) {
      print('Error: $e');
      // 에러 처리 로직 추가 가능
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
                productImage(widget.product.images[0].url),
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
                      gradeInformation(screenWidth),
                      const SizedBox(height: 20),
                      spaceDivider(""),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buttonBar(screenWidth)
        ],
      ),
    );
  }

  SizedBox productImage(String url) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.product.images[0].url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Positioned buttonBar(double screenWidth) {
    return Positioned(
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
                onPressed: toggleWish,
                icon: Icon(
                  isWished
                      ? Icons.favorite
                      : Icons.favorite_outline, // 찜 상태에 따라 아이콘 변경
                  color: isWished
                      ? const Color(0xff9abcff)
                      : Colors.black, // 찜 상태에 따라 색상 변경
                ),
              ),
              const SizedBox(width: 10),
              Flexible(flex: 1, child: button("구매하기")),
              const SizedBox(width: 10),
              Flexible(flex: 1, child: button("판매하기")),
            ],
          ),
        ),
      ),
    );
  }

  InkWell button(String label) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => PurchasePage(
                    product: productDetail!,
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

  Container gradeInformation(double screenWidth) {
    return Container(
      // 등급 안내 상자
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(222, 222, 222, 1),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gradeButton("실제 사진 보기", screenWidth),
                const SizedBox(
                  height: 5,
                ),
                gradeButton("${productDetail?.grade}등급 리뷰 보기", screenWidth),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Flexible gradeButton(String label, double screenWidth) {
    return Flexible(
      flex: 1,
      child: InkWell(
        child: Container(
          width: screenWidth * 0.32,
          decoration: BoxDecoration(
              color: const Color(0xff404756),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontFamily: "Pretendard", color: white),
            ),
          ),
        ),
      ),
    );
  }

  Container spaceDivider(String label) {
    return Container(
      width: double.infinity,
      height: 2000,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                productDetail?.descriptionImage.url ?? ""),
            fit: BoxFit.cover),
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
