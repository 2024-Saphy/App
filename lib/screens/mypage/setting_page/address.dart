import 'package:flutter/material.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "주소록",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Pretendard",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 주소록 추가 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                child: Text(
                  "새로운 주소 추가",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // 주소록 리스트
            SizedBox(
              height: 10,
            ),
            AddressItem(
              title: "집",
              address: "서울시 강남구 역삼동 123-456",
            ),
            AddressItem(
              title: "학교",
              address: "경기도 수원시 영통구 광교산로 154-42",
            ),
            AddressItem(
              title: "친구집",
              address: "서울시 강남구 역삼동 123-456",
            ),
          ],
        ),
      ),
    );
  }
}

class AddressItem extends StatelessWidget {
  final String title;
  final String address;

  const AddressItem({super.key, required this.title, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              address,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        const Spacer(),
        // 수정 및 삭제 버튼
        Row(
           children: [
            IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ],
    );
  }
}
