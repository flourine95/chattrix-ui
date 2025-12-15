class ServerException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  ServerException({
    required this.message,
    this.errorCode,
    this.statusCode,
    this.errors,
  });

  @override
  String toString() => 'ServerException: $message (Code: $errorCode)';
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No internet connection'});
}