import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/exceptions.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response!.data != null) {
      final data = err.response!.data;

      if (data is Map<String, dynamic>) {
        final message = data['message'] as String? ?? 'Unknown error';
        final code = data['code'] as String? ?? 'UNKNOWN_ERROR';
        final requestId = data['requestId'] as String?;

        Map<String, String>? details;
        if (data['details'] != null && data['details'] is Map) {
          details = (data['details'] as Map).map((key, value) => MapEntry(key.toString(), value.toString()));
        }

        debugPrint('🔴 API Error: $code - $message${requestId != null ? ' [RequestID: $requestId]' : ''}');
        if (details != null) {
          debugPrint('   Details: $details');
        }

        // Create ApiException and reject it through handler
        final apiException = ApiException(
          message: message,
          code: code,
          statusCode: err.response!.statusCode ?? 500,
          details: details,
          requestId: requestId,
        );

        // Reject with the ApiException instead of throwing
        handler.reject(
          DioException(requestOptions: err.requestOptions, response: err.response, type: err.type, error: apiException),
        );
        return;
      }
    }

    // Pass through other errors
    handler.next(err);
  }
}
