import 'package:saphy/service/api_service.dart';

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
    if (response.statusCode == 200) {
      print('API call login successful: ${response.data}');
      return response.statusCode;
    } else if (response.statusCode == 300) {
      print('API call successful, redirect register screen: ${response.data}');
      return response.statusCode;
    } else {
      print('API call failed: ${response.statusMessage}');
      return response.statusCode;
    }
  } catch (e) {
    print('Network error occurred: $e');
  }
  return null;
}
