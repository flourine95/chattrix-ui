class ServerException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;

  ServerException({required this.message, this.errorCode, this.statusCode});
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});
}

