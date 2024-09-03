import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:saphy/screens/purchase/purchase_page.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class ProductDetail extends StatelessWidget {
  final String productBrand;
  final String productName;
  final String productImageUrl;
  final double price;

  const ProductDetail({
    super.key,
    required this.productBrand,
    required this.productName,
    required this.productImageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('###,###,###,###');
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
                          image: CachedNetworkImageProvider(productImageUrl),
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
                      const Text.rich(
                        TextSpan(
                          text: "출고가 ",
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 15,
                            color: gray700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "500,000원",
                              style: TextStyle(
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
                              text: "${numberFormat.format(price)}원",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        productName,
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
                      const SizedBox(
                        height: 10,
                      ),
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
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(122, 122, 122, 0.55),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              offset: Offset(1, 1),
                              blurRadius: 0,
                              spreadRadius: -1,
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.34),
                              offset: Offset(-1, -1),
                              blurRadius: 0,
                              spreadRadius: -1,
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0xffdedede),
                            width: 1,
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
                                    '해당 상품은 등급 A 제품입니다.',
                                    style: bodyText(),
                                  ),
                                  Text(
                                    "Grade A",
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
                                        width: 150,
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
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff404756),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            "A등급 리뷰 보기",
                                            style: TextStyle(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: gray400, width: 0.5)),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("다른 색상 메뉴"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: gray400, width: 0.5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("쿠폰 발급 메뉴"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        // 버튼
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PurchasePage()),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff404756),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "구매하기",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pretendard",
                                      fontSize: 15,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xff404756),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "판매하기",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pretendard",
                                    fontSize: 15,
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // 상품 정보
                        width: double.infinity,
                        height: 900,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: gray400, width: 0.5)),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("상품 정보 사진 칸"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // 상품 정보
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: gray400, width: 0.5)),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("댓글 칸"),
                        ),
                      ),
                      const SizedBox(
                        height: 160,
                      ),
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
              color: const Color(0xfff4f4f4f4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  // 버튼
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline)),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PurchasePage()),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff404756),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "구매하기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pretendard",
                                fontSize: 15,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff404756),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "판매하기",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Pretendard",
                              fontSize: 15,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
