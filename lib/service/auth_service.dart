import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/log.dart';

Future<int?> loginService(String socialType, String email) async {
  final socialTypeLowerCase = socialType.toLowerCase();
  try {
    final response = await APIService.instance.request(
      '/oauth2/login',
      DioMethod.post,
      param: {'email': email, 'socialType': socialType},
      contentType: 'application/json',
    );

    final statusCode = response.data['status']['code'];

    if (response.statusCode == 200) {
      logger.i('API call [loginService] successful: ${response.data}');
      final authorization = response.headers['Authorization'];
      final jwt = 'Bearer ${authorization?[0]}';
      await writeJwt(jwt);
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

Future<int?> joinService(
    String socialType, String email, String name, String phoneNumber) async {
  // String profilePhotoUrl,
  try {
    final response = await APIService.instance.request(
      '/oauth2/join',
      DioMethod.post,
      param: {
        'email': email,
        'socialType': socialType,
        'name': name,
        // 'profilePhotoUrl': profilePhotoUrl,
        'phoneNumber': phoneNumber,
      },
      contentType: 'application/json',
    );

    final statusCode = response.data['status']['code'];
    logger.i('Status code: $statusCode');

    if (response.statusCode == 200) {
      logger.i('API call [joinService] successful: ${response.data}');
      // final authorization = response.headers['Authorization'];
      // final jwt = authorization?[0].replaceFirst('Bearer ', '');
      // await writeJwt(jwt);
      // logger.i('JWT : $jwt');
      return statusCode;
    } else {
      logger.e('API call [loginService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<int?> setProfileImageService() async {
  String token = await readJwt();
  token = token.toString().split(" ")[2];
  try {
    final response = await APIService.instance.request(
      '/members/profileImage',
      DioMethod.patch,
      token: "Bearer $token",
      param: {
        "profileImage": "string"
      },
      contentType: 'application/json',
    );

    final statusCode = response.data['status']['code'];
    logger.i('Status code: $statusCode');

    if (response.statusCode == 200) {
      logger.i('API call [joinService] successful: ${response.data}');
      return statusCode;
    } else {
      logger.e('API call [loginService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    throw Exception(e);
  }
}
