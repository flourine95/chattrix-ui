import 'package:chattrix_ui/features/chat/domain/entities/mentioned_user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';

/// Helper class to create test system messages
/// Use this for testing system message UI
class TestSystemMessages {
  /// Create a USER_JOINED system message
  static Message userJoined({required int id, required int conversationId, required String userName, int? userId}) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: userId ?? 999,
      senderFullName: userName,
      content: '$userName joined the group',
      type: 'SYSTEM',
      systemMessageType: 'USER_JOINED',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(userId: userId ?? 999, username: userName.toLowerCase().replaceAll(' ', '_'), fullName: userName),
      ],
    );
  }

  /// Create a USER_LEFT system message
  static Message userLeft({required int id, required int conversationId, required String userName, int? userId}) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: userId ?? 999,
      senderFullName: userName,
      content: '$userName left the group',
      type: 'SYSTEM',
      systemMessageType: 'USER_LEFT',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(userId: userId ?? 999, username: userName.toLowerCase().replaceAll(' ', '_'), fullName: userName),
      ],
    );
  }

  /// Create a USER_ADDED system message
  static Message userAdded({
    required int id,
    required int conversationId,
    required String actorName,
    required String targetName,
    int? actorId,
    int? targetId,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: actorId ?? 998,
      senderFullName: actorName,
      content: '$actorName added $targetName to the group',
      type: 'SYSTEM',
      systemMessageType: 'USER_ADDED',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(
          userId: actorId ?? 998,
          username: actorName.toLowerCase().replaceAll(' ', '_'),
          fullName: actorName,
        ),
        MentionedUser(
          userId: targetId ?? 999,
          username: targetName.toLowerCase().replaceAll(' ', '_'),
          fullName: targetName,
        ),
      ],
    );
  }

  /// Create a NAME_CHANGED system message
  static Message nameChanged({
    required int id,
    required int conversationId,
    required String actorName,
    required String newName,
    int? actorId,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: actorId ?? 998,
      senderFullName: actorName,
      content: '$actorName changed the group name to "$newName"',
      type: 'SYSTEM',
      systemMessageType: 'NAME_CHANGED',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(
          userId: actorId ?? 998,
          username: actorName.toLowerCase().replaceAll(' ', '_'),
          fullName: actorName,
        ),
      ],
    );
  }

  /// Create an ADMIN_PROMOTED system message
  static Message adminPromoted({
    required int id,
    required int conversationId,
    required String actorName,
    required String targetName,
    int? actorId,
    int? targetId,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: actorId ?? 998,
      senderFullName: actorName,
      content: '$actorName made $targetName a group admin',
      type: 'SYSTEM',
      systemMessageType: 'ADMIN_PROMOTED',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(
          userId: actorId ?? 998,
          username: actorName.toLowerCase().replaceAll(' ', '_'),
          fullName: actorName,
        ),
        MentionedUser(
          userId: targetId ?? 999,
          username: targetName.toLowerCase().replaceAll(' ', '_'),
          fullName: targetName,
        ),
      ],
    );
  }

  /// Create a MESSAGE_PINNED system message
  static Message messagePinned({
    required int id,
    required int conversationId,
    required String actorName,
    int? actorId,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: actorId ?? 998,
      senderFullName: actorName,
      content: '$actorName pinned a message',
      type: 'SYSTEM',
      systemMessageType: 'MESSAGE_PINNED',
      createdAt: DateTime.now(),
      mentionedUsers: [
        MentionedUser(
          userId: actorId ?? 998,
          username: actorName.toLowerCase().replaceAll(' ', '_'),
          fullName: actorName,
        ),
      ],
    );
  }

  /// Get a list of all test system messages
  static List<Message> getAllTestMessages({required int conversationId}) {
    return [
      userJoined(id: 1001, conversationId: conversationId, userName: 'John Doe', userId: 1),
      userAdded(
        id: 1002,
        conversationId: conversationId,
        actorName: 'Alice',
        targetName: 'Bob',
        actorId: 2,
        targetId: 3,
      ),
      nameChanged(id: 1003, conversationId: conversationId, actorName: 'Alice', newName: 'Team Chat', actorId: 2),
      adminPromoted(
        id: 1004,
        conversationId: conversationId,
        actorName: 'Alice',
        targetName: 'Bob',
        actorId: 2,
        targetId: 3,
      ),
      messagePinned(id: 1005, conversationId: conversationId, actorName: 'John Doe', actorId: 1),
      userLeft(id: 1006, conversationId: conversationId, userName: 'Bob', userId: 3),
    ];
  }
}
