import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:saphy/models/product.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/product_card.dart';
import 'package:saphy/utils/colors.dart';

class LikedListPage extends StatefulWidget {
  const LikedListPage({super.key});

  @override
  State<LikedListPage> createState() => _LikedListPageState();
}

class _LikedListPageState extends State<LikedListPage> {
  final NumberFormat numberFormat = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: altWhite,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 25),
                onPressed: () {},
              ),
              SizedBox(height: 50, width: screenWidth - 150),
              IconButton(
                  icon: const Icon(Icons.search, size: 25), onPressed: () {}),
            ],
          ),
        ),
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
                      buildFilterButton("전체"),
                      const SizedBox(width: 10),
                      buildFilterButton("스마트폰"),
                      const SizedBox(width: 10),
                      buildFilterButton("스마트폰"),
                      const SizedBox(width: 10),
                      buildFilterButton("스마트폰"),
                      const SizedBox(width: 10),
                      buildFilterButton("스마트폰"),
                      const SizedBox(width: 10),
                      buildFilterButton("스마트폰"),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                spacing: 15,
                runSpacing: 15,
                children: [],
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
