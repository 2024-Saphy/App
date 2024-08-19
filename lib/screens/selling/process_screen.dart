import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/photo_screen.dart';
import 'package:saphy/utils/colors.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 40.0, bottom: 100.0),
                child: Text(
                  '판매절차를\n알려드릴게요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 40.0,
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Process(
                number: '1',
                content: '사진 촬영 지침에 맞게 \n제품 사진 촬영하기!',
              ),
              const Process(
                number: '2',
                content: '사진 촬영 지침에 맞게 \n제품 사진 촬영하기!',
              ),
              const Process(
                number: '3',
                content: '사진 촬영 지침에 맞게 \n제품 사진 촬영하기!',
              ),
              const Process(
                number: '4',
                content: '사진 촬영 지침에 맞게 \n제품 사진 촬영하기!',
              ),
              const SizedBox(height: 100.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: NormalButton(
                  title: '확인했어요',
                  bgColor: black,
                  txtColor: white,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PhotoScreen(),
                    ));
                  },
                  flag: true,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Process extends StatelessWidget {
  const Process({
    super.key,
    required this.number,
    required this.content,
  });

  final String number;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: gray300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Prefix(
              number: number,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20.0,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: black,
            width: 3.0,
          )),
      child: Text(
        number,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 40.0,
          color: black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
