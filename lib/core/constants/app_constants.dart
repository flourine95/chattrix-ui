class AppConstants {
  static const Duration connectTimeout = Duration(seconds: 30);

  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Duration reconnectDelay = Duration(seconds: 3);

  static const Duration heartbeatInterval = Duration(seconds: 30);

  static const int maxReconnectAttempts = 5;

  static const String contentTypeJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
