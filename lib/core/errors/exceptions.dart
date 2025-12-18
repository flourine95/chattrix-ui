/// API Exception thrown by Dio interceptor when parsing error response
///
/// This exception is thrown when the API returns an error response with structure:
/// {success: false, message: string, code: string, details?: Map<String, String>, requestId: string}
class ApiException implements Exception {
  final String message;
  final String code;
  final int statusCode;
  final Map<String, String>? details;
  final String? requestId;

  ApiException({required this.message, required this.code, required this.statusCode, this.details, this.requestId});

  @override
  String toString() => 'ApiException($code): $message${requestId != null ? ' [RequestID: $requestId]' : ''}';
}

/// Server Exception for unexpected server errors
class ServerException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;

  ServerException({required this.message, this.errorCode, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $errorCode)';
}

/// Network Exception for connectivity issues
class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}
