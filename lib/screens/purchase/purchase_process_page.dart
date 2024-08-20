import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/normal_button.dart';

class PurchaseProcessPage extends StatefulWidget {
  const PurchaseProcessPage({super.key});

  @override
  State<PurchaseProcessPage> createState() => _PurchaseProcessPageState();
}

class _PurchaseProcessPageState extends State<PurchaseProcessPage> {
  List<String> items = ["쿠폰이 없습니다"];
  String selectedValue = "쿠폰이 없습니다";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: altWhite,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("배송 / 결제", style: titleText()),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소", style: bodyText()),
            ),
          ),
        ],
      ),
      backgroundColor: altWhite,
      body: CustomScrollView(
        slivers: [
          _buildSpacer(10),
          _buildProductInfo(),
          _buildSpacer(20),
          _buildAddressInfo(),
          _buildSpacer(20),
          _buildCouponInfo(),
          _buildSpacer(20),
          _buildPaymentInfo(),
          _buildSpacer(20),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        child: NormalButton(
            title: "결제",
            bgColor: black,
            onTap: () {},
            flag: true,
            txtColor: white),
      ),
    );
  }

  SliverToBoxAdapter _buildSpacer(double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }

  SliverPadding _buildProductInfo() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // 이미지 추가 시:
                      // image: DecorationImage(
                      //   image: NetworkImage('image_url'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    height: double.infinity,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Iphone 14", style: subTitleText()),
                      Text("256GB, Black", style: bodyText()),
                      const Spacer(),
                      Text("1,000,000원", style: subTitleText()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildAddressInfo() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeaderRow("배송 주소", "주소 변경하기", () {}),
                const Divider(),
                buildInfoRow("받는 분", "한유진"),
                buildInfoRow("연락처", "01012345678"),
                buildInfoRow("주소", "용인시 기흥구"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding _buildCouponInfo() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeaderRow("할인 혜택", "쿠폰 받기", () {}),
                const Divider(),
                DropdownButtonFormField(
                  value: selectedValue,
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: inputDecoration(),
                  dropdownColor: const Color(0xfff4f4f4),
                  isDense: true,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Color(0xff9abcff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding _buildPaymentInfo() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeaderRow("결제 수단", "결제 수단 추가", () {}),
                const Divider(),
                buildInfoRow("신한카드", "신한은행 7890"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildInfoRow(String label, String value) {
    const labelTextStyle = TextStyle(
      fontFamily: "Pretendard",
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    const valueTextStyle = TextStyle(
      fontFamily: "Pretendard",
      fontSize: 15,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelTextStyle),
        Text(value, style: valueTextStyle),
      ],
    );
  }

  Row buildHeaderRow(String label, String value, Function() onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              child: Text(value),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 229, 229, 229),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xff9abcff),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
