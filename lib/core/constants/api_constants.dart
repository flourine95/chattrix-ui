import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get _host => dotenv.env['API_HOST'] ?? 'localhost';

  static String get _port => dotenv.env['API_PORT'] ?? '8080';

  static String get _apiPath => dotenv.env['API_PATH'] ?? '/api';

  static String get _wsPath => dotenv.env['WS_PATH'] ?? '';

  static const String _androidEmulatorHost = '10.0.2.2';

  /// Get the appropriate host based on platform
  /// - Web: Use API_HOST from .env
  /// - Android Emulator: Use 10.0.2.2 (localhost from emulator perspective)
  /// - Other platforms (iOS, Windows, Mac, Linux): Use API_HOST from .env
  static String get _effectiveHost {
    if (kIsWeb) {
      return _host;
    }

    // Only use emulator host for Android
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _androidEmulatorHost;
    }

    // For iOS, Windows, macOS, Linux: use configured host
    return _host;
  }

  /// Determines if secure protocols (HTTPS/WSS) should be used
  ///
  /// Requirement 10.5: Use HTTPS for API calls and WSS for WebSocket in production
  /// In debug mode, allows HTTP/WS for localhost development
  /// In release mode, enforces HTTPS/WSS for security
  static bool get _useSecureProtocol {
    // Check if explicitly set in environment
    final useSecure = dotenv.env['USE_SECURE_PROTOCOL'];
    if (useSecure != null) {
      return useSecure.toLowerCase() == 'true';
    }

    // In release mode, always use secure protocols
    if (!kDebugMode) {
      return true;
    }

    // In debug mode, use secure protocols for non-localhost hosts
    final host = _effectiveHost;
    final isLocalhost = host == 'localhost' || host == '127.0.0.1' || host == '10.0.2.2' || host == '0.0.0.0';

    return !isLocalhost;
  }

  static String get _baseUrl {
    final host = _effectiveHost;
    final protocol = _useSecureProtocol ? 'https' : 'http';
    final url = '$protocol://$host:$_port$_apiPath';

    if (kDebugMode) {
      print('🌐 [ApiConstants] Platform: ${defaultTargetPlatform.name}');
      print('🌐 [ApiConstants] Effective Host: $host');
      print('🌐 [ApiConstants] HTTP Base URL: $url');
    }

    return url;
  }

  static String get _wsBaseUrl {
    final host = _effectiveHost;
    final protocol = _useSecureProtocol ? 'wss' : 'ws';
    final url = '$protocol://$host:$_port$_wsPath';

    if (kDebugMode) {
      print('🌐 [ApiConstants] WebSocket Base URL: $url');
    }

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

  // Call endpoints
  static String get initiateCall => '$_baseUrl/$_v1/calls/initiate';

  static String acceptCall(String callId) => '$_baseUrl/$_v1/calls/$callId/accept';

  static String rejectCall(String callId) => '$_baseUrl/$_v1/calls/$callId/reject';

  static String endCall(String callId) => '$_baseUrl/$_v1/calls/$callId/end';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
