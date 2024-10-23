import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
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
import 'package:saphy/widgets/normal_button.dart';
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

  @override
  void initState() {
    super.initState();
    loadProduct();
    initWishes();
  }

  List<double> generatePriceData() {
    List<double> priceData = [];
    double price = 100000;
    Random random = Random();

    for (int i = 0; i < 70; i++) {
      // 중간까지는 랜덤하게 가격을 올리거나 내림
      if (i < 70) {
        price += random.nextInt(10000) - 5000; // ±5000 범위에서 변동
      } else {
        // 마지막 30개 데이터는 가격을 내리기 시작
        price -= random.nextInt(8000); // 0 ~ 8000 범위에서 감소
      }

      // 가격이 음수가 되지 않도록 최소 가격을 80,000으로 설정
      price = max(price, 80000);
      priceData.add(price);
    }

    return priceData;
  }

  Future initWishes() async {
    wished = await SharedPreferences.getInstance();
    final wishedList = wished.getBool(widget.product.id.toString());
    if (wishedList != null) {
      setState(() {
        isWished = true;
      });
    } else {}
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
        backgroundColor: white,
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
      backgroundColor: altWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                productImage(widget.product.images[0].url),
                productTextInfor(),
                const SizedBox(height: 15),
                gradeInformation(screenWidth),
                graphInformation(),
                productInfor(),
                const SizedBox(height: 80),
              ],
            ),
          ),
          buttonBar(screenWidth)
        ],
      ),
    );
  }

  Container productTextInfor() {
    return Container(
      color: white,
      child: Padding(
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
                    text: "${numberFormat.format(widget.product.price)}원",
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
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
            color: white,
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
                  isWished ? Icons.favorite : Icons.favorite_outline,
                  color: isWished ? const Color(0xff9abcff) : Colors.black,
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
      color: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
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
                gradeButton("상품 상세 정보", screenWidth),
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
        onTap: () {
          _showPopup(context);
        },
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

  Padding graphInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        color: white,
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                "중고 시세",
                style: textStyle(25, true, null),
              ),
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 10000 == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  value.toInt().toString(),
                                  style: textStyle(10, false, gray700),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                          reservedSize: 50,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                          spots: generatePriceData()
                              .asMap()
                              .entries
                              .map((e) => FlSpot(e.key.toDouble(), e.value))
                              .toList(),
                          isCurved: true,
                          color: mainPrimary,
                          barWidth: 3,
                          dotData: const FlDotData(show: false)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container productInfor() {
    return Container(
      width: double.infinity,
      height: 2000,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                productDetail?.descriptionImage.url ?? ""),
            fit: BoxFit.cover),
        color: white,
        border: Border.all(color: gray400, width: 0.5),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            backgroundColor: white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text('상품 상세', style: textStyle(22, true, null)),
                      const SizedBox(height: 4),
                      Text("Saphy에서 검수를 진행한 결과입니다.",
                          style: textStyle(18, false, null)),
                      const SizedBox(height: 8),
                      _buildInfoRow("개봉여부", "개봉"),
                      _buildInfoRow("제품 박스 유무", "있음"),
                      _buildInfoRow("전면/액정 외관", "흠집 없음"),
                      _buildInfoRow("측/후면 외관", "흠집 없음"),
                      _buildInfoRow("카메라/렌즈 외관", "흠집 없음"),
                      _buildInfoRow("전원 동작", "정상"),
                      _buildInfoRow("LCD 손상", "없음"),
                      _buildInfoRow("화면 이상(잔상, 번인, 주름)", "없음"),
                      _buildInfoRow("터치", "정상"),
                      _buildInfoRow("생체 인식(지문, Face id 등)", "정상"),
                      _buildInfoRow("GPS/WIFI", "정상"),
                      _buildInfoRow("카메라(멍 유무, 동작여부)", "정상"),
                      _buildInfoRow("스피커/마이크(녹음기능)", "정상"),
                      _buildInfoRow("배터리 효율", "80~84%"),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: NormalButton(
                          title: '확인했어요',
                          bgColor: altBlack,
                          txtColor: white,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          flag: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _buildInfoRow(String label, String status) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textStyle(18, false, gray700),
          ),
          Text(
            status,
            style: textStyle(18, false, null),
          ),
        ],
      ),
    );
  }
}
