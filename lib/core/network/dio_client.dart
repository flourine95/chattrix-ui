import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        contentType: AppConstants.contentTypeJson,
        // Allow 401 to trigger onError interceptor for token refresh
        validateStatus: (status) => status != null && status >= 200 && status < 300,
      ),
    );

    // Only log in debug mode and only errors
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: false, // Tắt log request body
          responseBody: false, // Tắt log response body
          error: true, // Chỉ log errors
          requestHeader: false, // Tắt log headers
          responseHeader: false, // Tắt log headers
        ),
      );
    }

    return dio;
  }
}
