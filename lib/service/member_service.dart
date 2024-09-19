import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/log.dart';

Future<int?> getMemberInfo(String socialType, String email) async {
  try {
    final response = await APIService.instance.request(
      '/members/info',
      DioMethod.get,
      // param: {'email': email, 'socialType': socialType},
      contentType: 'application/json',
    );

    final statusCode = response.data['status']['code'];
    logger.i('Status code: $statusCode');

    if (response.statusCode == 200) {
      logger.i('API call [MemberService] successful: ${response.data}');
      return response.data;
    } else if (response.statusCode == 300) {
      logger.i(
          'API call [MemberService] successful, redirect register screen: ${response.data}');
      return statusCode;
    } else {
      logger.i('API call [MemberService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    logger.i('Network error occurred: $e');
  }
  return null;
}