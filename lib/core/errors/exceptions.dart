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

class ServerException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;

  ServerException({required this.message, this.errorCode, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $errorCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}
