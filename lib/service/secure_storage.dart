import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

readAccessToken() async {
  String? key = await storage.read(key: 'AccessToken');
  return key;
}

writeAccessToke(String? value) async {
  await storage.write(key: 'AccessToken', value: value);
}

deleteAccessToke(String? value) async {
  await storage.delete(key: 'AccessToken');
}

readRefreshToken() async {
  String? key = await storage.read(key: 'RefreshToken');
  return key;
}

writeRefreshToke(String? value) async {
  await storage.write(key: 'RefreshToken', value: value);
}

deleteRefreshToke(String? value) async {
  await storage.delete(key: 'RefreshToken');
}
