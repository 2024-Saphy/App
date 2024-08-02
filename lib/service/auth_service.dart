import 'package:saphy/service/api_service.dart';
import 'package:saphy/utils/log.dart';

Future<int?> loginService(String socialType, String email, String token) async {
  final socialTypeLowerCase = socialType.toLowerCase();
  try {
    final response = await APIService.instance.request(
      '/oauth2/$socialTypeLowerCase/login',
      DioMethod.post,
      param: {'email': email, 'socialType': socialType},
      contentType: 'application/json',
      token: token,
    );

    final responseData = response.data;
    final statusCode = responseData['status']['code'];
    logger.i('Status code: $statusCode');

    if (response.statusCode == 200) {
      logger.i('API call [loginService] successful: ${response.data}');
      return statusCode;
    } else if (response.statusCode == 300) {
      logger.i(
          'API call [loginService] successful, redirect register screen: ${response.data}');
      return statusCode;
    } else {
      logger.i('API call [loginService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    logger.i('Network error occurred: $e');
  }
  return null;
}

Future<void> joinService(String socialType, String email, String name,
    String profilePhotoUrl, String phoneNumber, String accessToken) async {
  try {
    final response = await APIService.instance.request(
      '/members/join',
      DioMethod.post,
      param: {
        'email': email,
        'socialType': socialType,
        'name': name,
        'profilePhotoUrl': profilePhotoUrl,
        'phoneNumber': phoneNumber,
        'AccessToken': accessToken
      },
      contentType: 'application/json',
    );

    if (response.statusCode == 200) {
      logger.i('API call [joinService] successful: ${response.data}');
    } else {
      logger.i('API call [loginService] failed: ${response.statusMessage}');
    }
  } catch (e) {
    logger.i('Network error occurred: $e');
  }
  return;
}
