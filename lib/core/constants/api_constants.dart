import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get _host => dotenv.env['API_HOST'] ?? 'localhost';

  static String get _port => dotenv.env['API_PORT'] ?? '8080';
  static const String _apiPath = '/api';
  static const String _wsPath = '';
  static const String _v1 = 'v1';

  static bool get _useSecureProtocol {
    return !kDebugMode;
  }

  static String get _baseUrl {
    final protocol = _useSecureProtocol ? 'https' : 'http';
    return '$protocol://$_host:$_port$_apiPath';
  }

  static String get _wsBaseUrl {
    final protocol = _useSecureProtocol ? 'wss' : 'ws';
    final path = _wsPath.isNotEmpty ? _wsPath : '';
    return '$protocol://$_host:$_port$path';
  }

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

  static String joinCall(String callId) => '$_baseUrl/$_v1/calls/$callId/join';

  static String rejectCall(String callId) => '$_baseUrl/$_v1/calls/$callId/reject';

  static String endCall(String callId) => '$_baseUrl/$_v1/calls/$callId/end';

  static String activeCall(int conversationId) => '$_baseUrl/$_v1/calls/active/$conversationId';

  // Call History endpoints
  static String get callHistory => '$_baseUrl/$_v1/calls/history';

  static String callHistoryWithFilter(String filter) => '$_baseUrl/$_v1/calls/history?filter=$filter';

  // Conversation Actions endpoints (NEW API)
  static String muteConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/mute';

  static String unmuteConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/unmute';

  static String pinConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/pin';

  static String unpinConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/unpin';

  static String reorderPinnedConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/reorder';

  static String archiveConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/archive';

  static String unarchiveConversation(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/unarchive';

  // Note: Block/unblock and hide/unhide are not in the new API spec
  // These may need to be handled differently or removed

  static String conversationPermissions(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/permissions';

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

  // Poll & Event endpoints (New)
  static String createPoll(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/messages/poll';

  static String votePoll(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/poll/vote';

  static String createEvent(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/messages/event';

  static String rsvpEvent(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/event/rsvp';

  static String eventRsvps(int conversationId, int eventId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId/rsvps';

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

  // Poll & event endpoints

  static String polls(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/polls';

  static String pollById(int conversationId, int pollId) => '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId';

  static String closePoll(int conversationId, int pollId) => '$_baseUrl/$_v1/conversations/$conversationId/polls/$pollId/close';

  static String events(int conversationId) => '$_baseUrl/$_v1/conversations/$conversationId/events';

  static String event(int conversationId, int eventId) => '$_baseUrl/$_v1/conversations/$conversationId/events/$eventId';

  // Utils
  static String forwardMessage(int conversationId, int messageId) =>
      '$_baseUrl/$_v1/conversations/$conversationId/messages/$messageId/forward';

  static String get chatWebSocket => '$_wsBaseUrl/ws/chat';

  static String chatWebSocketWithToken(String token) => '$chatWebSocket?token=$token';
}
