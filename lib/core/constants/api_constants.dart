import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  static const String localhostHost = 'localhost';
  static const String lanIpAddress = '10.238.54.212';

  static const String port = '8080';
  static const String apiPrefix = '/chattrix-api/api';

  static const String localhostBaseUrl =
      'http://$localhostHost:$port$apiPrefix';
  static const String lanBaseUrl = 'http://$lanIpAddress:$port$apiPrefix';

  static String get baseUrl {
    if (kIsWeb) {
      return localhostBaseUrl;
    } else {
      return lanBaseUrl;
    }
  }

  static const String apiVersion = 'v1';

  static const String authBase = '$apiVersion/auth';
  static const String register = '$authBase/register';
  static const String verifyEmail = '$authBase/verify-email';
  static const String resendVerification = '$authBase/resend-verification';
  static const String login = '$authBase/login';
  static const String me = '$authBase/me';
  static const String refresh = '$authBase/refresh';
  static const String changePassword = '$authBase/change-password';
  static const String forgotPassword = '$authBase/forgot-password';
  static const String resetPassword = '$authBase/reset-password';
  static const String logout = '$authBase/logout';
  static const String logoutAll = '$authBase/logout-all';

  static const String contentTypeJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
