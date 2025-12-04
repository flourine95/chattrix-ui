import 'package:chattrix_ui/core/constants/app_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        contentType: AppConstants.contentTypeJson,
        validateStatus: (status) => status != null && status >= 200 && status < 300,
      ),
    );
    return dio;
  }
}
