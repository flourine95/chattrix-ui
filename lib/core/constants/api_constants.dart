import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  static const String localhostHost = 'localhost';
  static const String lanIpAddress = '172.19.240.1';

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

  // Chat API endpoints
  static const String conversationsBase = '$apiVersion/conversations';

  static String conversationById(String id) => '$conversationsBase/$id';

  static String messagesInConversation(String conversationId) =>
      '$conversationsBase/$conversationId/messages';

  // User Status API endpoints
  static const String userStatusBase = '$apiVersion/users/status';
  static const String onlineUsers = '$userStatusBase/online';

  static String onlineUsersInConversation(String conversationId) =>
      '$userStatusBase/online/conversation/$conversationId';

  static String userStatus(String userId) => '$userStatusBase/$userId';

  // User Search API endpoints
  static const String usersBase = '$apiVersion/users';
  static const String searchUsers = '$usersBase/search';

  // Typing API endpoints (HTTP test endpoints)
  static const String typingBase = '$apiVersion/typing';
  static const String typingStart = '$typingBase/start';
  static const String typingStop = '$typingBase/stop';

  static String typingStatus(String conversationId) =>
      '$typingBase/status/$conversationId';

  // WebSocket endpoint
  static String get wsBaseUrl {
    // WebSocket base URL: ws://host:port/chattrix-api
    if (kIsWeb) {
      return 'ws://$localhostHost:$port/chattrix-api';
    } else {
      return 'ws://$lanIpAddress:$port/chattrix-api';
    }
  }

  static const String chatWebSocket = 'ws/chat';

  static const String contentTypeJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
