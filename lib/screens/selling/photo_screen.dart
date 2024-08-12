import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saphy/screens/selling/flaw_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.0,
                      ),
                      Text(
                        '사진 촬영하기',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 40.0,
                          color: black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/camera.png'),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  child: Text(
                    '제품의 모든 각도를 잘 보여줄 수 있도록 명확하고 밝은 곳에서 사진을 촬영하세요',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20.0,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Column(
              children: [
                const Text(
                  '제품 전체 사진',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20.0,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PhotoPlaceholder(
                        image: Image.asset('assets/images/Shuhua.webp'),
                      ),
                      PhotoPlaceholder(
                        image: Image.asset('assets/images/Shuhua.webp'),
                      ),
                      PhotoPlaceholder(
                        image: Image.asset('assets/images/Shuhua.webp'),
                      ),
                      PhotoPlaceholder(
                        image: Image.asset('assets/images/Shuhua.webp'),
                      ),
                      const PhotoPlaceholder(
                        image: null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  '자세한 손상 사진',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20.0,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PhotoPlaceholder(
                        image: Image.asset('assets/images/Shuhua.webp'),
                      ),
                      const PhotoPlaceholder(
                        image: null,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80.0, vertical: 10.0),
                  child: NormalButton(
                    title: '더 추가하기',
                    bgColor: gray800,
                    txtColor: white,
                    onTap: () {},
                    flag: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: NormalButton(
                title: '다음으로',
                bgColor: black,
                txtColor: white,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FlawScreen(),
                  ));
                },
                flag: true,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoPlaceholder extends StatelessWidget {
  const PhotoPlaceholder({
    super.key,
    required this.image,
  });

  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Container(
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
          color: gray300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: image!.image,
                  fit: BoxFit.cover,
                  width: 160.0,
                  height: 160.0,
                ),
              )
            : const Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: white,
                  size: 30.0,
                ),
              ),
      ),
    );
  }
}
