import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saphy/models/loginInfo.dart';

const storage = FlutterSecureStorage();

readAccessToken() async {
  String? key = await storage.read(key: 'AccessToken');
  return key;
}

writeAccessToke(String? value) async {
  await storage.write(key: 'AccessToken', value: value);
}

deleteAccessToke() async {
  await storage.delete(key: 'AccessToken');
}

readRefreshToken() async {
  String? key = await storage.read(key: 'RefreshToken');
  return key;
}

writeRefreshToke(String? value) async {
  await storage.write(key: 'RefreshToken', value: value);
}

deleteRefreshToke() async {
  await storage.delete(key: 'RefreshToken');
}

readJwt() async {
  String? key = await storage.read(key: 'JWT');
  return key;
}

writeJwt(String? value) async {
  await storage.write(key: 'JWT', value: value);
}

deleteJwt() async {
  await storage.delete(key: 'JWT');
}

readLoginInfo() async {
  String? key = await storage.read(key: 'LoginInfo');
  return key;
}

writeLoginInfo(LoginInfo? loginInfo) async {
  await storage.write(key: 'LoginInfo', value: jsonEncode(loginInfo));
}

deleteLoginInfo() async {
  await storage.delete(key: 'LoginInfo');
}
