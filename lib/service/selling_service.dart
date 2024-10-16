import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:saphy/service/api_service.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/utils/log.dart';

Future<int?> createSellingItem(
    List<File> imageFiles, Map<String, dynamic> requestObject) async {
  try {
    String? token = await readJwt();
    logger.i('JWT Token: $token');

    token = token.toString().split(" ")[2];

    List<MultipartFile> multipartFiles = [];
    for (var file in imageFiles) {
      String mimeType = 'image/jpeg';
      var mimeTypeData = mimeType.split('/');
      MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: basename(file.path),
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );

      multipartFiles.add(multipartFile);

      logger.i(
          'MultipartFile details - Filename: ${multipartFile.filename}, ContentType: ${multipartFile.contentType?.toString()}, Length: ${multipartFile.length}');
    }

    FormData formData = FormData.fromMap({
      "request": MultipartFile.fromString(
        jsonEncode(requestObject),
        contentType: MediaType('application', 'json'),
      ),
      "imageFiles": await Future.wait(imageFiles.map((file) async {
        return MultipartFile.fromFile(
          file.path,
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        );
      }).toList()),
    });

    final response = await APIService.instance.request(
      '/sales',
      DioMethod.post,
      contentType: 'multipart/form-data',
      token: "Bearer $token",
      formData: formData,
    );

    logger.i('API Response Status Code: ${response.statusCode}');
    logger.i('API Response Data: ${response.data}');

    final statusCode = response.data['status']['code'];

    if (response.statusCode == 200) {
      logger.i('API call [sellingService] successful: ${response.data}');
      return statusCode;
    } else {
      logger.e('API call [sellingService] failed: ${response.statusMessage}');
      return statusCode;
    }
  } catch (e) {
    logger.e('API call [sellingService] exception: $e');
    throw Exception(e);
  }
}
