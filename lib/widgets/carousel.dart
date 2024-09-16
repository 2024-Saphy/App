import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saphy/utils/colors.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    const itemList = [
      (
        link:
            "https://i.pinimg.com/736x/cf/aa/d7/cfaad78b35a7b752054dd564b77f1f10.jpg",
        type: "Phone",
        content: "iPhone 15도\nSaphy에서.",
        color: Colors.white,
      ),
      (
        link:
            "https://i.pinimg.com/736x/d3/81/bb/d381bbb3036599443634fef9503d888c.jpg",
        type: "Collaboration",
        content: "전 세계를 홀린\nKirby와의 콜라보!",
        color: Colors.black
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              type,
              style: TextStyle(color: color, fontSize: 25),
            ),
            Text(
              content,
              style: TextStyle(
                  color: color,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  height: 1.2),
            ),
            const SizedBox(
              height: 30,
            ),
            // SizedBox(
            //   height: 3,
            //   width: 280,
            //   child: Row(
            //     children: [
            //       Expanded(flex: index, child: Container(color: color)),
            //       Expanded(
            //         flex: totalCount + index,
            //         child: Container(
            //           color:
            //               color == Colors.white ? Colors.black : Colors.white,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
