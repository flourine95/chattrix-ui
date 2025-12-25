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

  static String conversationMembers(String conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/members';

  // User endpoints
  static String get searchUsers => '$_baseUrl/$_v1/users/search';

  static String get onlineUsers => '$_baseUrl/$_v1/users/status/online';

  static String onlineUsersInConversation(String conversationId) =>
      '$_baseUrl/$_v1/users/status/online/conversation/$conversationId';

  static String userStatus(String userId) => '$_baseUrl/$_v1/users/status/$userId';

  // Message endpoints
  static String messageReactions(String messageId) => '$_baseUrl/$_v1/messages/$messageId/reactions';

  static String deleteReaction(String messageId, String emoji) => '$_baseUrl/$_v1/messages/$messageId/reactions/$emoji';

  static String messageEdit(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId';

  static String messageDelete(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId';

  static String messageEditHistory(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/history';

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

  // Conversation Settings endpoints
  static String conversationSettings(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings';

  static String muteConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/mute';

  static String unmuteConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unmute';

  static String pinConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/pin';

  static String unpinConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unpin';

  static String hideConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/hide';

  static String unhideConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unhide';

  static String archiveConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/archive';

  static String unarchiveConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unarchive';

  static String blockUser(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/block';

  static String unblockUser(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unblock';

  static String muteMember(String conversationId, String userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/members/$userId/mute';

  static String unmuteMember(String conversationId, String userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/members/$userId/unmute';

  static String conversationPermissions(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/permissions';

  static String conversationAvatar(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/avatar';

  // Member Management endpoints
  static String addMembers(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members';

  static String removeMember(String conversationId, String userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members/$userId';

  static String updateMemberRole(String conversationId, String userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members/$userId/role';

  static String leaveConversation(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members/leave';

  // Pinned Messages endpoints
  static String pinnedMessages(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/pinned';

  static String pinMessage(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/pin';

  static String unpinMessage(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/pin';

  // Scheduled Messages endpoints
  static String scheduleMessage(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/schedule';

  static String scheduledMessages(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled';

  static String scheduledMessageById(String conversationId, String messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled/$messageId';

  static String cancelScheduledMessagesBulk(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled/bulk';

  // Search endpoints
  static String searchMessages(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/search/messages';

  static String searchMedia(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/search/media';

  // Poll endpoints
  static String polls(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls';

  static String pollById(String conversationId, String pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId';

  static String votePoll(String conversationId, String pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId/vote';

  static String closePoll(String conversationId, String pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId/close';

  // Event endpoints
  static String events(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events';

  static String eventById(String conversationId, String eventId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId';

  static String rsvpEvent(String conversationId, String eventId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId/rsvp';

  // Invite Link endpoints
  static String inviteLinks(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/invite-links';

  static String inviteLinkById(String conversationId, String linkId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/invite-links/$linkId';

  static String inviteLinkInfo(String token) =>
      '$_baseUrl/$_v1/invite-links/$token';

  static String joinViaInviteLink(String token) =>
      '$_baseUrl/$_v1/invite-links/$token/join';

  // Birthday endpoints
  static String get birthdaysToday => '$_baseUrl/$_v1/birthdays/today';

  static String get sendBirthdayWishes => '$_baseUrl/$_v1/birthdays/send-wishes';

  // Announcement endpoints
  static String announcements(String conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/announcements';

  // Mutual Groups endpoints
  static String mutualGroups(String userId) =>
      '$_baseUrl/$_v1/users/$userId/mutual-groups';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
