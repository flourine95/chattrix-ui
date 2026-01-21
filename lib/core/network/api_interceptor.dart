import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';

class ApiInterceptor extends Interceptor {
  // List of error codes that are expected/normal and shouldn't be logged as errors
  static const _expectedErrorCodes = {
    'NO_ACTIVE_INVITE_LINK', // Normal when no invite link exists
    'ALREADY_MEMBER', // Normal when user is already in group
    'CONVERSATION_ALREADY_PINNED', // Normal when trying to pin already pinned conversation
    'CONVERSATION_NOT_PINNED', // Normal when trying to unpin non-pinned conversation
    'MESSAGE_ALREADY_PINNED', // Normal when trying to pin already pinned message
    'MESSAGE_NOT_PINNED', // Normal when trying to unpin non-pinned message
    'CONVERSATION_ALREADY_MUTED', // Normal when trying to mute already muted conversation
    'CONVERSATION_NOT_MUTED', // Normal when trying to unmute non-muted conversation
    'CONVERSATION_ALREADY_ARCHIVED', // Normal when trying to archive already archived conversation
    'CONVERSATION_NOT_ARCHIVED', // Normal when trying to unarchive non-archived conversation
  };

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

        // Only log unexpected errors
        if (!_expectedErrorCodes.contains(code)) {
          debugPrint('🔴 API Error: $code - $message${requestId != null ? ' [RequestID: $requestId]' : ''}');
          if (details != null) {
            debugPrint('   Details: $details');
          }
        } else {
          // Log expected errors at debug level (optional)
          debugPrint('ℹ️ API Info: $code - $message');
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
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            type: err.type,
            error: apiException,
          ),
        );
        return;
      }
    }

    // Pass through other errors
    handler.next(err);
  }
}
