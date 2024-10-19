import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saphy/screens/selling/end_selling_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/widgets/normal_button.dart';

class RuleScreen extends StatefulWidget {
  const RuleScreen({super.key});

  @override
  State<RuleScreen> createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: altWhite,
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
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 40.0),
                child: Text(
                  '검수 기준을\n확인해주세요',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 40.0,
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: gray100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 2850.0,
                child: const Text(
                  """

  전자기기 검수 기준
  1. 외관 상태
  검수 항목: 외관의 스크래치, 파손 여부 확인.
  세부 기준:
  A 등급: 외관에 거의 결함이 없으며, 눈에 띄는 스크래치나 마모가 전혀 없음.
  B 등급: 생활 스크래치로 취급될 정도로 작은 결함이 존재하나, 눈에 잘 띄지 않으며 기기의 전반적인 상태가 우수함.
  C 등급: 중간 정도의 스크래치나 마모가 있으며, 사용 흔적이 명확히 드러남. 그러나 기기 사용에는 영향을 주지 않음.
  D 등급: 깊은 스크래치나 눈에 띄는 파손이 있으며, 외관 상태가 전반적으로 좋지 않음.
  E 등급: 외관이 심각하게 파손되었거나 부서진 상태로, 기기 사용에 영향을 줄 정도의 손상이 있음.

  2. 액정 상태
  검수 항목: 액정 스크래치, 깨짐 여부, 터치 기능 확인.
  세부 기준:
  A 등급: 액정에 스크래치나 깨짐이 전혀 없으며, 화면의 밝기와 색상이 완벽하게 유지됨. 터치 기능이 정상적으로 작동.
  B 등급: 미세한 스크래치가 있을 수 있으나, 사용 중 거의 인지되지 않음. 터치 기능과 화면 품질에 이상 없음.
  C 등급: 액정에 가벼운 스크래치가 있거나, 터치 반응이 약간 둔할 수 있으나 사용에는 큰 문제가 없음.
  D 등급: 액정에 중대한 스크래치가 있거나 터치 기능에 불량이 발생함. 화면의 일부가 깨졌으나 사용은 가능함.
  E 등급: 액정이 크게 파손되어 화면 일부 또는 전체가 보이지 않거나 터치 기능이 거의 작동하지 않음.

  3. 배터리 상태
  검수 항목: 배터리 효율, 급격한 배터리 소모 여부.
  세부 기준:
  A 등급: 배터리 효율이 90% 이상 유지되어, 거의 새 제품과 동일한 배터리 성능을 제공함.
  B 등급: 배터리 효율이 80% 이상 유지되며, 일반적인 사용 환경에서 하루 이상 사용 가능함.
  C 등급: 배터리 효율이 70% 이상이지만, 자주 충전이 필요하거나 장시간 사용에 불편함이 있을 수 있음.
  D 등급: 배터리 효율이 60% 이하로 떨어져 있으며, 배터리 소모가 빠르고 충전 빈도가 높음.
  E 등급: 배터리 성능이 매우 낮아 실사용이 어려울 정도로 자주 충전이 필요함. 배터리 교체가 필요한 상태.

  4. 기능 상태
  검수 항목: 주요 기능 (센서, 카메라, 버튼 등) 작동 여부 확인.
  세부 기준:
  A 등급: 모든 기능이 완벽하게 작동하며, 기기의 모든 부품이 정상 작동함.
  B 등급: 주요 기능이 대부분 정상 작동하며, 일부 부수적인 기능에만 미세한 문제가 있을 수 있음 (예: 특정 센서의 민감도 저하).
  C 등급: 카메라, 버튼, 센서 등 일부 기능이 약간의 문제가 있거나, 사용에 불편함이 있을 수 있음.
  D 등급: 주요 기능 중 하나 이상이 작동하지 않거나, 사용에 불편을 줄 수 있는 결함이 있음.
  E 등급: 여러 주요 기능이 작동하지 않거나, 기기의 정상적인 사용이 어려울 정도로 기능이 파손됨.

  5. 제품 이력
  검수 항목: 구매 시기, 수리 여부 확인.
  세부 기준:
  A 등급: 최근 1년 이내에 구매한 제품으로, 수리 이력이 없거나 경미한 수리만 있었으며 부품 교체가 없는 상태.
  B 등급: 구매한 지 1~2년 이내로, 수리 이력이 있지만 공인 서비스 센터에서 진행되었으며 부품 교체가 없는 상태.
  C 등급: 구매한 지 2~3년 이상 되었으며, 수리 이력이 있고 일부 부품이 교체되었으나 정상 작동하는 상태.
  D 등급: 3년 이상 된 제품으로, 여러 번의 수리 이력이 있으며, 부품 교체가 이루어졌고 이후 정상 작동하지만 상태가 좋지 않은 제품.
  E 등급: 수리 이력이 다수 존재하며, 수리 이후에도 문제가 발생하거나, 구매 시점이 오래되어 전반적인 성능과 상태가 떨어지는 제품.

  최종 등급 평가
  등급별 점수 환산 (소수점 적용)
  A 등급: 5.0점
  B 등급: 4.0점
  C 등급: 3.0점
  D 등급: 2.0점
  E 등급: 1.0점
  검수 항목별 점수 계산
  각 검수 기준(외관 상태, 액정 상태, 배터리 상태, 기능 상태, 제품 이력)에서 각각의 점수를 부여한 후, 이 점수를 모두 합산하여 총점을 계산합니다. 계산된 총점에 따라 제품의 최종 등급이 결정됩니다.

  최종 등급 산정 기준
  총점에 따라 최종 제품 등급을 다음과 같이 산정합니다:

  A 등급: 23.5 ~ 25.0점
  B 등급: 18.5 ~ 23.4점
  C 등급: 13.5 ~ 18.4점
  D 등급: 8.5 ~ 13.4점
  E 등급: 5.0 ~ 8.4점
  예시
  예를 들어, 다음과 같은 검수 결과를 얻었다고 가정해보겠습니다:

  외관 상태: B 등급 (4.0점)
  액정 상태: A 등급 (5.0점)
  배터리 상태: C 등급 (3.0점)
  기능 상태: B 등급 (4.0점)
  제품 이력: A 등급 (5.0점)
  이 경우 총점은 
  4.0+5.0+3.0+4.0+5.0=21.0점입니다. 따라서 이 제품의 최종 등급은 B 등급으로 평가됩니다.


  상품 보류 사유
  제품이 위조품으로 의심되는 경우
  검수 과정에서 제품이 정품이 아닐 가능성이 있는 경우, 거래 안전을 위해 제품 판매가 일시적으로 보류됩니다. 위조품 여부를 확인하기 위해 추가 검토가 필요합니다.

  제품 상태가 심각하게 불량한 경우
  제품의 기능이 거의 작동하지 않거나, 심각한 외관 손상이 있어 판매가 어려운 상태로 판단되는 경우, 보류됩니다. 이 경우 사용자는 추가 조치를 논의할 수 있습니다.

  필수 정보 누락 또는 불충분한 경우
  사용자가 제공한 제품 정보(사진, 구매 이력 등)가 불충분하거나 중요한 정보가 누락된 경우, 검수 및 판매 진행이 일시적으로 보류됩니다. 추가 정보 제공이 필요합니다.

  제품의 수리가 필요하다고 판단되는 경우
  검수 과정에서 제품이 정상적으로 작동하지 않으며, 수리가 필요한 것으로 판단되는 경우, 보류됩니다. 수리 여부와 방법에 대해 사용자와 협의가 이루어질 수 있습니다.

  제품이 불법적인 또는 제한된 항목에 해당하는 경우
  제품이 법적 규제를 받거나 판매가 제한된 품목으로 분류되는 경우, 판매 진행이 불가능하여 보류됩니다. 해당 제품은 즉시 반송됩니다.
  """,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15.0,
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: NormalButton(
                  title: '확인했어요',
                  bgColor: black,
                  txtColor: white,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const EndSellingScreen(),
                      ),
                      (Route<dynamic> route) =>
                          false, // 이 predicate는 모든 이전 화면을 제거
                    );
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
