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

  static String conversationById(int id) => '$_baseUrl/$_v1/conversations/$id';

  static String messagesInConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/messages';

  static String conversationMembers(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/members';

  // User endpoints
  static String get searchUsers => '$_baseUrl/$_v1/users/search';

  static String get onlineUsers => '$_baseUrl/$_v1/users/status/online';

  static String onlineUsersInConversation(int conversationId) =>
      '$_baseUrl/$_v1/users/status/online/conversation/$conversationId';

  static String userStatus(int userId) => '$_baseUrl/$_v1/users/status/$userId';

  // Message endpoints
  static String messageReactions(int messageId) => '$_baseUrl/$_v1/messages/$messageId/reactions';

  static String deleteReaction(int messageId, String emoji) => '$_baseUrl/$_v1/messages/$messageId/reactions/$emoji';

  static String messageEdit(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId';

  static String messageDelete(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId';

  static String messageEditHistory(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/history';

  static String messageRead(int messageId) => '$_baseUrl/$_v1/messages/$messageId/read';

  // Read Receipts endpoints
  static String markConversationAsRead(int conversationId) =>
      '$_baseUrl/$_v1/read-receipts/conversations/$conversationId';

  static String markConversationAsUnread(int conversationId) =>
      '$_baseUrl/$_v1/read-receipts/conversations/$conversationId/unread';

  static String get globalUnreadCount => '$_baseUrl/$_v1/read-receipts/unread-count';

  // Typing endpoints
  static String get typingStart => '$_baseUrl/$_v1/typing/start';

  static String get typingStop => '$_baseUrl/$_v1/typing/stop';

  static String typingStatus(int conversationId) => '$_baseUrl/$_v1/typing/status/$conversationId';

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
  static String conversationSettings(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings';

  static String muteConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/mute';

  static String unmuteConversation(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unmute';

  static String pinConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/pin';

  static String unpinConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/unpin';

  static String hideConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/hide';

  static String unhideConversation(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unhide';

  static String archiveConversation(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/archive';

  static String unarchiveConversation(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/unarchive';

  static String blockUser(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/block';

  static String unblockUser(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/settings/unblock';

  static String muteMember(int conversationId, int userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/members/$userId/mute';

  static String unmuteMember(int conversationId, int userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/members/$userId/unmute';

  static String conversationPermissions(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/settings/permissions';

  static String conversationAvatar(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/avatar';

  // Member Management endpoints
  static String addMembers(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/members';

  static String removeMember(int conversationId, int userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members/$userId';

  static String updateMemberRole(int conversationId, int userId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/members/$userId/role';

  static String leaveConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/members/leave';

  // Pinned Messages endpoints
  static String pinnedMessages(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/messages/pinned';

  static String pinMessage(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/pin';

  static String unpinMessage(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/pin';

  // Scheduled Messages endpoints
  static String scheduleMessage(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/messages/schedule';

  static String scheduledMessages(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled';

  static String scheduledMessageById(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled/$messageId';

  static String cancelScheduledMessagesBulk(int conversationId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/scheduled/bulk';

  // Search endpoints
  static String searchMessages(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/search/messages';

  static String searchMedia(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/search/media';

  // Poll endpoints
  static String polls(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/polls';

  static String pollById(int conversationId, int pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId';

  static String votePoll(int conversationId, int pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId/vote';

  static String closePoll(int conversationId, int pollId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId/close';

  // Event endpoints
  static String events(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/events';

  static String eventById(int conversationId, int eventId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId';

  static String rsvpEvent(int conversationId, int eventId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId/rsvp';

  // Invite Link endpoints
  static String inviteLinks(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/invite-links';

  static String inviteLinkById(int conversationId, int linkId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/invite-links/$linkId';

  static String inviteLinkInfo(String token) => '$_baseUrl/$_v1/invite-links/$token';

  static String joinViaInviteLink(String token) => '$_baseUrl/$_v1/invite-links/$token/join';

  // Birthday endpoints
  static String get birthdaysToday => '$_baseUrl/$_v1/birthdays/today';

  static String get sendBirthdayWishes => '$_baseUrl/$_v1/birthdays/send-wishes';

  // Announcement endpoints
  static String announcements(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/announcements';

  // Mutual Groups endpoints
  static String mutualGroups(int userId) => '$_baseUrl/$_v1/users/$userId/mutual-groups';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
