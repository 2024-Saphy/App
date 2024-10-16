import 'package:flutter/cupertino.dart';
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
  final List<bool> _terms = [false, false, false, false];

  bool get _allTermsAccepted => _terms.every((element) => element);

  void _updateTermState(int index, bool value) {
    setState(() {
      _terms[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 100.0),
                child: Text(
                  '이용약관에\n동의해주세요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 40.0,
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Term(
                content: '사용자는 판매하려는 제품에 대한 정확하고 정직한 정보를 제공해야 합니다.',
                initial: false,
                onChanged: (value) => _updateTermState(0, value),
              ),
              Term(
                content: '사진에 타인의 얼굴이나 개인정보가 포함되지 않도록 주의해야 합니다.',
                initial: false,
                onChanged: (value) => _updateTermState(1, value),
              ),
              Term(
                content: '금지된 품목을 사진에 포함하거나 게시하는 것은 엄격히 금지됩니다.',
                initial: false,
                onChanged: (value) => _updateTermState(2, value),
              ),
              Term(
                content:
                    '사진은 선명하고 제품의 상태를 명확히 보여줄 수 있어야 합니다. 흐리거나 제품의 상태를 왜곡하는 사진은 삭제될 수 있습니다.',
                initial: false,
                onChanged: (value) => _updateTermState(3, value),
              ),
              const SizedBox(height: 100.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: NormalButton(
                  title: '확인했어요',
                  bgColor: _allTermsAccepted ? black : gray400,
                  txtColor: white,
                  onTap: () {
                    _allTermsAccepted
                        ? {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProcessScreen(),
                            ))
                          }
                        : null;
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

class Term extends StatefulWidget {
  const Term({
    super.key,
    required this.content,
    required this.initial,
    required this.onChanged,
  });

  final String content;
  final bool initial;
  final ValueChanged<bool> onChanged;

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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  approve = value;
                });
                widget.onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
