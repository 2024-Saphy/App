import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:saphy/provider/image_provider.dart';
import 'package:saphy/screens/selling/end_selling_screen.dart';
import 'package:saphy/service/selling_service.dart';
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
  final Logger logger = Logger();

  List<String> titles = [
    '판매하는 제품의 이름',
    '액정 스크래치 혹은 파손',
    '외관 스크래치 혹은 파손',
    '배터리 효율',
    '기능 파손(센서, 카메라, 버튼)',
    '구매 시기',
    '수리 여부',
  ];

  // 각 TextFormField의 입력값을 제어하기 위한 컨트롤러 리스트
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // _listSize만큼 컨트롤러 생성
    controllers = List.generate(_listSize, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // 사용이 끝난 후 컨트롤러 해제
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderModel>(context);
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
                        controller: controllers[index],
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
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            child: NormalButton(
              title: '제출할게요',
              bgColor: black,
              txtColor: white,
              onTap: () async {
                List<File> imageFiles = imageProvider.images
                    .map((xfile) => File(xfile.path))
                    .toList();
                Map<String, dynamic> requestObject = {
                  "itemId": 1, // 판매하는 제품의 고유 아이디, 동적으로 처리할 수 있음
                  "defect": {
                    "display": controllers[0].text, // 액정 스크래치 혹은 파손
                    "appearance": controllers[1].text, // 외관 스크래치 혹은 파손
                    "batteryEfficiency": controllers[2].text, // 배터리 효율
                    "function": controllers[3].text, // 기능 파손
                    "purchaseDate": controllers[4].text, // 구매 시기
                    "isRepaired": controllers[5].text, // 수리 여부
                  }
                };
                final statecode =
                    await createSellingItem(imageFiles, requestObject);
                if (statecode == 200) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EndSellingScreen(),
                  ));
                }
              },
              flag: true,
            ),
          ),
        ],
      ),
    );
  }
}
