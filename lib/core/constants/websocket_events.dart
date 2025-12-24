/// WebSocket event type constants
class WebSocketEvents {
  // Message Events
  static const String chatMessage = 'chat.message';
  static const String messageUpdated = 'message.updated';
  static const String messageDeleted = 'message.deleted';
  static const String messageReaction = 'message.reaction';

  // Conversation Events
  static const String conversationUpdate = 'conversation.update';
  static const String typingIndicator = 'typing.indicator';

  // User Events
  static const String userStatus = 'user.status';

  // Friend Request Events
  static const String friendRequestReceived = 'friend.request.received';
  static const String friendRequestAccepted = 'friend.request.accepted';
  static const String friendRequestRejected = 'friend.request.rejected';
  static const String friendRequestCancelled = 'friend.request.cancelled';

  // Note Events
  static const String noteCreated = 'note.created';
  static const String noteUpdated = 'note.updated';
  static const String noteDeleted = 'note.deleted';

  // Call Events
  static const String callIncoming = 'call.incoming';
  static const String callAccepted = 'call.accepted';
  static const String callRejected = 'call.rejected';
  static const String callEnded = 'call.ended';
  static const String callTimeout = 'call.timeout';

  // Invite Link Events
  static const String inviteLinkCreated = 'invite_link.created';
  static const String inviteLinkRevoked = 'invite_link.revoked';
  static const String inviteLinkUsed = 'invite_link.used';
}
