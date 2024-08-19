import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saphy/screens/selling/rule_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';
import 'package:toggle_list/toggle_list.dart';

class FlawScreen extends StatefulWidget {
  const FlawScreen({super.key});

  @override
  State<FlawScreen> createState() => _FlawScreenState();
}

class _FlawScreenState extends State<FlawScreen> {
  final _listSize = 6;

  List<String> titles = [
    '판매하는 제품의 이름',
    '액정 스크래치 혹은 파손',
    '외관 스크래치 혹은 파손',
    '배터리 효율',
    '기능 파손(센서, 카메라, 버튼)',
    '구매 시기',
    '수리 여부',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      '더 자세한\n정보를 알려주세요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 40.0,
                        color: black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 45.0,
                    ),
                    Text(
                      '예상 판매 금액을 측정할 수 있어요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ToggleList(
                  trailing: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Icon(FontAwesomeIcons.arrowDown),
                  ),
                  children: List.generate(
                    _listSize,
                    (index) => ToggleListItem(
                      leading: const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      itemDecoration: BoxDecoration(
                        color: gray100,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        titles[index],
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      divider: const Divider(
                        color: white,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 20.0,
                            color: black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            child: NormalButton(
              title: '제출할게요',
              bgColor: black,
              txtColor: white,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RuleScreen(),
                ));
              },
              flag: true,
            ),
          ),
        ],
      ),
    );
  }
}
