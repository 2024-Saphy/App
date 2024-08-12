import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/process_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  '이용약관에\n동의해주세요',
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
          const Expanded(
            flex: 3,
            child: Column(
              children: [
                Term(
                  content: '사용자는 판매하려는 제품에 대한 정확하고 정직한 정보를 제공해야 합니다.',
                  initial: false,
                ),
                Term(
                  content: '사진에 타인의 얼굴이나 개인정보가 포함되지 않도록 주의해야 합니다.',
                  initial: false,
                ),
                Term(
                  content: '금지된 품목을 사진에 포함하거나 게시하는 것은 엄격히 금지됩니다.',
                  initial: false,
                ),
                Term(
                  content:
                      '사진은 선명하고 제품의 상태를 명확히 보여줄 수 있어야 합니다. 흐리거나 제품의 상태를 왜곡하는 사진은 삭제될 수 있습니다.',
                  initial: false,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: NormalButton(
              title: '확인했어요',
              bgColor: black,
              txtColor: white,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProcessScreen(),
                ));
              },
              flag: true,
            ),
          ),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}

class Term extends StatefulWidget {
  const Term({
    super.key,
    required this.content,
    required this.initial,
  });

  final String content;
  final bool initial;

  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  late bool approve;

  @override
  void initState() {
    super.initState();
    approve = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              widget.content,
              maxLines: 3,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
          ),
          Checkbox(
            value: approve,
            onChanged: (value) {
              setState(() {
                approve = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
