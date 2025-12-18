import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../errors/exceptions.dart';

/// Dio interceptor for parsing API error responses
///
/// Parses error response structure:
/// {success: false, message: string, code: string, details?: Map<String, String>, requestId: string}
///
/// Throws ApiException with parsed data for BaseRepository to handle
class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response!.data != null) {
      final data = err.response!.data;

      if (data is Map<String, dynamic>) {
        // Parse error response structure
        final message = data['message'] as String? ?? 'Unknown error';
        final code = data['code'] as String? ?? 'UNKNOWN_ERROR';
        final requestId = data['requestId'] as String?;

        // Parse details map for validation errors
        Map<String, String>? details;
        if (data['details'] != null && data['details'] is Map) {
          details = (data['details'] as Map).map((key, value) => MapEntry(key.toString(), value.toString()));
        }

        debugPrint('API Error: $code - $message${requestId != null ? ' [RequestID: $requestId]' : ''}');
        if (details != null) {
          debugPrint('Details: $details');
        }

        throw ApiException(
          message: message,
          code: code,
          statusCode: err.response!.statusCode ?? 500,
          details: details,
          requestId: requestId,
        );
      }
    }

    // If not a structured error response, pass through
    super.onError(err, handler);
  }
}
