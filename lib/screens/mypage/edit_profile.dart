import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../models/memberinfo.dart';
import '../../service/mypage/member_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nicknameController = TextEditingController();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "프로필 수정",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<MemberInfo>(
          future: getMemberInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              nicknameController.text = data.nickname == null ? "" : data.nickname.toString();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          data.profileImage == null ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" : data.profileImage.toString(),
                        ),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "프로필 닉네임",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              enabled: isEdit,
                              controller: nicknameController,
                              decoration: const InputDecoration(
                                hintText: "닉네임을 설정해 주세요.",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: ()async{
                          if(isEdit){
                            await updateMemberInfo(nicknameController.text);
                            setState(() {
                              isEdit = false;
                            });
                          }
                          else{
                            setState(() {
                              isEdit = true;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: const BoxDecoration(
                            border: Border.fromBorderSide(BorderSide(
                              color: Colors.blue,
                              width: 2,
                            )),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            isEdit ? "완료" : "수정",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                style:
                const TextStyle(color: Colors.black),
              ); // 오류 처리
            }
            // 데이터 로딩 중 표시할 위젯
            return const SizedBox(
                height: 500,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                )
            );
          },
        ),
      ),
    );
  }
}
