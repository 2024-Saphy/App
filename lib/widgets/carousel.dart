import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    const itemList = [
      (
        link:
            "https://i.pinimg.com/736x/cf/aa/d7/cfaad78b35a7b752054dd564b77f1f10.jpg",
        type: "Phone",
        content: "IPhone 16도\nSaphy에서.",
        color: Colors.white,
      ),
      (
        link:
            "https://i.pinimg.com/736x/9d/e8/08/9de808527966126e0d92397b346fb06e.jpg",
        type: "Phone",
        content: "더욱 새로워진\nGalaxy S24.",
        color: Colors.white
      ),
    ];
    int totalCount = itemList.length;
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: itemList.length,
        options: CarouselOptions(
          height: 575,
          viewportFraction: 1,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
        ),
        itemBuilder: (context, index, realIndex) {
          return contentBuilder(
            itemList[index].link,
            itemList[index].type,
            itemList[index].content,
            itemList[index].color,
            realIndex,
            totalCount,
          );
        },
      ),
    );
  }

  Container contentBuilder(String link, String type, String content,
      Color color, int index, int totalCount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
              link,
            ),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              type,
              style: textStyle(25, false, white),
            ),
            Text(
              content,
              style: TextStyle(
                  color: color,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  height: 1.1),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
