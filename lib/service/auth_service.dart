import 'dart:convert';

import 'package:saphy/models/status.dart';
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
      logger.i('API call login successful: ${response.data}');
      return statusCode;
    } else if (response.statusCode == 300) {
      logger
          .i('API call successful, redirect register screen: ${response.data}');
      return statusCode;
    } else {
      logger.i('API call failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    logger.i('Network error occurred: $e');
  }
  return null;
}
