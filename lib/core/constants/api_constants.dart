import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get _host => dotenv.env['API_HOST'] ?? 'localhost';

  static String get _port => dotenv.env['API_PORT'] ?? '8080';

  static String get _apiPath => dotenv.env['API_PATH'] ?? '/chattrix-api/api';

  static String get _wsPath => dotenv.env['WS_PATH'] ?? '/chattrix-api';

  static const String _androidEmulatorHost = '10.0.2.2';

  static String get _baseUrl {
    final host = kIsWeb ? _host : _androidEmulatorHost;
    return 'http://$host:$_port$_apiPath';
  }

  static String get _wsBaseUrl {
    final host = kIsWeb ? _host : _androidEmulatorHost;
    return 'ws://$host:$_port$_wsPath';
  }

  static const String _v1 = 'v1';

  // Auth endpoints
  static String get register => '$_baseUrl/$_v1/auth/register';

  static String get verifyEmail => '$_baseUrl/$_v1/auth/verify-email';

  static String get resendVerification => '$_baseUrl/$_v1/auth/resend-verification';

  static String get login => '$_baseUrl/$_v1/auth/login';

  static String get me => '$_baseUrl/$_v1/auth/me';

  static String get refresh => '$_baseUrl/$_v1/auth/refresh';

  static String get changePassword => '$_baseUrl/$_v1/auth/change-password';

  static String get forgotPassword => '$_baseUrl/$_v1/auth/forgot-password';

  static String get resetPassword => '$_baseUrl/$_v1/auth/reset-password';

  static String get logout => '$_baseUrl/$_v1/auth/logout';

  static String get logoutAll => '$_baseUrl/$_v1/auth/logout-all';

  // Conversation endpoints
  static String get conversations => '$_baseUrl/$_v1/conversations';

  static String conversationById(String id) => '$_baseUrl/$_v1/conversations/$id';

  static String messagesInConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages';

  // User endpoints
  static String get searchUsers => '$_baseUrl/$_v1/users/search';

  static String get onlineUsers => '$_baseUrl/$_v1/users/status/online';

  static String onlineUsersInConversation(String conversationId) =>
      '$_baseUrl/$_v1/users/status/online/conversation/$conversationId';

  static String userStatus(String userId) => '$_baseUrl/$_v1/users/status/$userId';

  // Message endpoints
  static String messageReactions(String messageId) => '$_baseUrl/$_v1/messages/$messageId/reactions';

  static String deleteReaction(String messageId, String emoji) => '$_baseUrl/$_v1/messages/$messageId/reactions/$emoji';

  static String messageEdit(String messageId) => '$_baseUrl/$_v1/messages/$messageId/edit';

  static String messageDelete(String messageId) => '$_baseUrl/$_v1/messages/$messageId';

  static String messageEditHistory(String messageId) => '$_baseUrl/$_v1/messages/$messageId/edit-history';

  // Typing endpoints
  static String get typingStart => '$_baseUrl/$_v1/typing/start';

  static String get typingStop => '$_baseUrl/$_v1/typing/stop';

  static String typingStatus(String conversationId) => '$_baseUrl/$_v1/typing/status/$conversationId';

  // Friend Request endpoints
  static String get sendFriendRequest => '$_baseUrl/$_v1/friend-requests/send';

  static String get receivedFriendRequests => '$_baseUrl/$_v1/friend-requests/received';

  static String get sentFriendRequests => '$_baseUrl/$_v1/friend-requests/sent';

  static String acceptFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId/accept';

  static String rejectFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId/reject';

  static String cancelFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId/cancel';

  // Contact endpoints
  static String get contacts => '$_baseUrl/$_v1/contacts';

  static String contactById(int contactId) => '$_baseUrl/$_v1/contacts/$contactId';

  static String updateContactNickname(int contactId) => '$_baseUrl/$_v1/contacts/$contactId/nickname';

  static String deleteContact(int contactId) => '$_baseUrl/$_v1/contacts/$contactId';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
