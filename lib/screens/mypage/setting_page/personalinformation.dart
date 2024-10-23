import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "개인정보처리방침",
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
      body: const WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://foggy-scooter-636.notion.site/8ea8fb205c044019ad1f1e8f34d32543',
      ),
    );
  }
}