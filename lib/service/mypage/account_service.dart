import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/log.dart';
import '../../models/accountinfo.dart';
import '../../models/memberinfo.dart';

Future<AccountInfo> getMyAccount() async {
  String token = await readJwt();
  token = token.toString().split(" ")[2];
  try {
    final response = await APIService.instance.request(
      '/members/me',
      DioMethod.get,
      contentType: 'application/json',
      token: "Bearer $token",
    );

    final statusCode = response.data['status']['code'];

    if (response.statusCode == 200) {
      logger.i('API call [loginService] successful: ${response.data}');
      final result = AccountInfo.fromJson(response.data['results'][0]);
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

Future<int?> deleteAccount() async {
  String token = await readJwt();
  logger.i(token);
  token = token.toString().split(" ")[2];
  try {
    final response = await APIService.instance.request(
      '/members/delete',
      DioMethod.delete,
      contentType: 'application/json',
      token: "Bearer $token",
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