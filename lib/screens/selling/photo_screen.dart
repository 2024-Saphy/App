import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:saphy/provider/image_provider.dart';
import 'package:saphy/screens/selling/flaw_screen.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';
import 'package:saphy/widgets/app_bar.dart';
import 'package:saphy/widgets/normal_button.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopup(context);
    });
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            backgroundColor: white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Photo Guide',
                      style: TextStyle(
                        fontFamily: 'Prompt',
                        fontSize: 32.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text.rich(
                      TextSpan(
                        text: '상품의 ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '모든 면',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: '이 보이도록 촬영해주세요.'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text.rich(
                      TextSpan(
                        text: '밝은 ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '배경',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: '에서 촬영해주세요.'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text.rich(
                      TextSpan(
                        text: '실사진 ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '최소 4장',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: '이 필요해요!'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text.rich(
                      TextSpan(
                        text: '상태가 잘 보이도록\n',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '적절한 거리',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: '에서 촬영해주세요'),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text.rich(
                      TextSpan(
                        text: '케이스 등 ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '보호 장비는\n 탈착 후',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(text: ' 촬영해주세요.'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: NormalButton(
                      title: '확인했어요',
                      bgColor: gray800,
                      txtColor: white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      flag: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        context.read<ImageProviderModel>().addImage(pickedFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<ImageProviderModel>();
    bool isButtonEnabled = imageProvider.images.length >= 4;

    return Scaffold(
      backgroundColor: altWhite,
      appBar: const TopAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 20, left: 40.0),
                  child: Text(
                    '사진 촬영하기',
                    style: textStyle(30, true, null),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(child: Image.asset('assets/images/camera.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 40.0),
                  child: Center(
                    child: Text(
                      '제품의 모든 각도를 잘 보여줄 수 있도록\n명확하고 밝은 곳에서 사진을 촬영하세요',
                      style: textStyle(20, false, null),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text('제품 전체 사진', style: textStyle(20, true, null)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await pickImage();
                          },
                          child: const PhotoPlaceholder(image: null),
                        ),
                        Consumer<ImageProviderModel>(
                          builder: (context, imageProvider, child) {
                            return Row(
                              children: imageProvider.images.map((image) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Image.file(
                                    File(image.path),
                                    width: 160.0,
                                    height: 160.0,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: NormalButton(
                title: '다음으로',
                bgColor: isButtonEnabled ? black : gray400,
                txtColor: white,
                onTap: () {
                  isButtonEnabled
                      ? {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FlawScreen(),
                          ))
                        }
                      : null;
                },
                flag: true,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoPlaceholder extends StatelessWidget {
  const PhotoPlaceholder({
    super.key,
    required this.image,
  });

  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Container(
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
          color: gray300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: image!.image,
                  fit: BoxFit.cover,
                  width: 160.0,
                  height: 160.0,
                ),
              )
            : const Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: white,
                  size: 30.0,
                ),
              ),
      ),
    );
  }
}
