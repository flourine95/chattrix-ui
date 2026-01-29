import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        contentType: AppConstants.contentTypeJson,
        validateStatus: (status) => status != null && status >= 200 && status < 300,
      ),
    );
    return dio;
  }
}
