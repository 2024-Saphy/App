import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/log.dart';

import '../../models/memberinfo.dart';

Future<MemberInfo> getMemberInfo() async {
  String token = await readJwt();
  token = token.toString().split(" ")[2];
  try {
    final response = await APIService.instance.request(
      '/members/info',
      DioMethod.get,
      contentType: 'application/json',
      token: "Bearer $token",
    );

    final statusCode = response.data['status']['code'];

    if (response.statusCode == 200) {
      logger.i('API call [loginService] successful: ${response.data}');
      final result = MemberInfo.fromJson(response.data['results'][0]);
      return result;
    } else if (response.statusCode == 300) {
      logger.i(
          'API call [loginService] successful, redirect register screen: ${response.data}');
      return statusCode;
    } else {
      logger.e('API call [loginService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<int?> updateMemberInfo(String? nickname) async {
  String token = await readJwt();
  token = token.toString().split(" ")[2];
  try {
    final response = await APIService.instance.request(
      '/members/info',
      DioMethod.patch,
      contentType: 'application/json',
      token: "Bearer $token",
      param: {
        "password": null,
        "nickName": nickname,
        "name": null,
        "address": null,
        "phoneNumber": null,
        "email": null
      },
    );

    final statusCode = response.data['status']['code'];

    if (response.statusCode == 200) {
      logger.i('API call [loginService] successful: ${response.data}');
      return statusCode;
    } else if (response.statusCode == 300) {
      logger.i(
          'API call [loginService] successful, redirect register screen: ${response.data}');
      return statusCode;
    } else {
      logger.e('API call [loginService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    throw Exception(e);
  }
}