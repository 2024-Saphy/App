import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/photo_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/app_bar.dart';
import 'package:saphy/widgets/normal_button.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altWhite,
      appBar: const TopAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, bottom: 32.0, top: 10),
                child: Text(
                  '판매는\n이렇게 진행돼요',
                  style: textStyle(30, true, null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Center(child: Image.asset('assets/images/shop.png')),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      Step(
                        number: '1',
                        last: false,
                      ),
                      Step(
                        number: '2',
                        last: false,
                      ),
                      Step(
                        number: '3',
                        last: false,
                      ),
                      Step(
                        number: '4',
                        last: true,
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Process(
                        content: '사진 촬영하기',
                        description: '사진 촬영 지침에 맞게 촬영해요.',
                      ),
                      Process(
                        content: '하자 입력하기',
                        description: '카테고리에 알맞는 정보를 입력해주세요.',
                      ),
                      Process(
                        content: '기기 수거',
                        description: '사피에서 판매될 기기를 수거해요.',
                      ),
                      Process(
                        content: '판매 완료!',
                        description: '책정된 금액이 계좌로 입금돼요.',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 84.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: NormalButton(
                  title: '확인했어요',
                  bgColor: black,
                  txtColor: white,
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const PhotoScreen(),
                    ));
                  },
                  flag: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Step extends StatelessWidget {
  const Step({
    super.key,
    required this.number,
    required this.last,
  });

  final String number;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Prefix(
          number: number,
        ),
        if (!last)
          Container(
            color: const Color(0xffa5abbb),
            width: 2.0,
            height: 24.0,
          ),
      ],
    );
  }
}

class Process extends StatelessWidget {
  const Process({
    super.key,
    required this.content,
    required this.description,
  });

  final String content;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20.0,
              color: black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16.0,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0)
        ],
      ),
    );
  }
}

class Prefix extends StatelessWidget {
  const Prefix({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffdcdcdc),
      ),
      child: Text(
        number,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 15.0,
          color: black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
