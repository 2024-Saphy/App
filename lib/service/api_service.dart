import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DioMethod { post, get, put, delete, patch }

class APIService {
  APIService._singletone();
  static final APIService instance = APIService._singletone();

  final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

// local -> 'http://10.0.2.2:8080/'
  String get baseUrl {
    if (kDebugMode) {
      return 'https://saphy.site/';
    } else {
      return 'https://saphy.site/';
    }
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    formData,
    token,
  }) async {
    final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        headers: {HttpHeaders.authorizationHeader: '$token'}));
    dio.interceptors.add(logger);
    switch (method) {
      case DioMethod.post:
        return dio.post(
          endpoint,
          data: param ?? formData,
        );
      case DioMethod.patch:
        return dio.patch(
          endpoint,
          data: param ?? formData,
        );
      case DioMethod.get:
        return dio.get(
          endpoint,
          queryParameters: param,
        );
      case DioMethod.put:
        return dio.put(
          endpoint,
          data: param ?? formData,
        );
      case DioMethod.delete:
        return dio.delete(
          endpoint,
          data: param ?? formData,
        );
      default:
        return dio.post(
          endpoint,
          data: param ?? formData,
        );
    }
  }
}
