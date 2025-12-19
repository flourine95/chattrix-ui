import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get _host => dotenv.env['API_HOST'] ?? 'localhost';

  static String get _port => dotenv.env['API_PORT'] ?? '8080';

  static String get _apiPath => dotenv.env['API_PATH'] ?? '/api';

  static String get _wsPath => dotenv.env['WS_PATH'] ?? '';

  static const String _androidEmulatorHost = '10.0.2.2';

  static String get _effectiveHost {
    if (kIsWeb) {
      return _host;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return _androidEmulatorHost;
    }

    return _host;
  }

  static bool get _useSecureProtocol {
    final useSecure = dotenv.env['USE_SECURE_PROTOCOL'];
    if (useSecure != null) {
      return useSecure.toLowerCase() == 'true';
    }

    if (!kDebugMode) {
      return true;
    }

    final host = _effectiveHost;
    final isLocalhost = host == 'localhost' || host == '127.0.0.1' || host == '10.0.2.2' || host == '0.0.0.0';

    return !isLocalhost;
  }

  static String get _baseUrl {
    final host = _effectiveHost;
    final protocol = _useSecureProtocol ? 'https' : 'http';
    final url = '$protocol://$host:$_port$_apiPath';

    return url;
  }

  static String get _wsBaseUrl {
    final host = _effectiveHost;
    final protocol = _useSecureProtocol ? 'wss' : 'ws';
    final url = '$protocol://$host:$_port$_wsPath';

    return url;
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

  // Profile endpoints
  static String get getProfile => '$_baseUrl/$_v1/profile/me';

  static String get updateProfile => '$_baseUrl/$_v1/profile/me';

  static String profileByUserId(int userId) => '$_baseUrl/$_v1/profile/$userId';

  static String profileByUsername(String username) => '$_baseUrl/$_v1/profile/username/$username';

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

  static String messageRead(String messageId) => '$_baseUrl/$_v1/messages/$messageId/read';

  // Read Receipts endpoints
  static String markConversationAsRead(int conversationId) =>
      '$_baseUrl/$_v1/read-receipts/conversations/$conversationId';

  static String get globalUnreadCount => '$_baseUrl/$_v1/read-receipts/unread-count';

  // Typing endpoints
  static String get typingStart => '$_baseUrl/$_v1/typing/start';

  static String get typingStop => '$_baseUrl/$_v1/typing/stop';

  static String typingStatus(String conversationId) => '$_baseUrl/$_v1/typing/status/$conversationId';

  // Friend Request endpoints
  static String get sendFriendRequest => '$_baseUrl/$_v1/friend-requests';

  static String get receivedFriendRequests => '$_baseUrl/$_v1/friend-requests/received';

  static String get sentFriendRequests => '$_baseUrl/$_v1/friend-requests/sent';

  static String acceptFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId/accept';

  static String rejectFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId/reject';

  static String cancelFriendRequest(int requestId) => '$_baseUrl/$_v1/friend-requests/$requestId';

  // Contact endpoints
  static String get contacts => '$_baseUrl/$_v1/contacts';

  static String contactById(int contactId) => '$_baseUrl/$_v1/contacts/$contactId';

  static String updateContactNickname(int contactId) => '$_baseUrl/$_v1/contacts/$contactId/nickname';

  static String deleteContact(int contactId) => '$_baseUrl/$_v1/contacts/$contactId';

  static String get favoriteContacts => '$_baseUrl/$_v1/contacts/favorites';

  static String toggleContactFavorite(int contactId) => '$_baseUrl/$_v1/contacts/$contactId/favorite';

  // Notes endpoints
  static String get notes => '$_baseUrl/$_v1/notes';

  static String get myNotes => '$_baseUrl/$_v1/notes/me';

  static String notesByUserId(int userId) => '$_baseUrl/$_v1/notes/$userId';

  static String noteReplies(int noteId) => '$_baseUrl/$_v1/notes/$noteId/replies';

  static String noteReact(int noteId) => '$_baseUrl/$_v1/notes/$noteId/react';

  // Call endpoints
  static String get initiateCall => '$_baseUrl/$_v1/calls/initiate';

  static String acceptCall(String callId) => '$_baseUrl/$_v1/calls/$callId/accept';

  static String rejectCall(String callId) => '$_baseUrl/$_v1/calls/$callId/reject';

  static String endCall(String callId) => '$_baseUrl/$_v1/calls/$callId/end';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
