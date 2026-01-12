import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? _getDefaultBaseUrl(),
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        contentType: AppConstants.contentTypeJson,
        validateStatus: (status) => status != null && status >= 200 && status < 300,
      ),
    );
    return dio;
  }

  static String _getDefaultBaseUrl() {
    // Use ApiConstants to get the base URL with /api prefix
    return ApiConstants.me.replaceAll(RegExp(r'/v1/auth/me$'), '');
  }
}
