/// Utility class for formatting system messages
/// Similar to Messenger/Zalo system message formatting
class SystemMessageFormatter {
  /// Format system message based on type and content
  ///
  /// Examples:
  /// - USER_JOINED: "John joined the group"
  /// - USER_LEFT: "John left the group"
  /// - USER_ADDED: "Alice added John to the group"
  /// - NAME_CHANGED: "Alice changed the group name to 'Team Chat'"
  static String format({
    required String type,
    required String content,
    String? actorName,
    String? targetName,
    String? additionalInfo,
  }) {
    switch (type.toUpperCase()) {
      case 'USER_JOINED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} joined the group';

      case 'USER_LEFT':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} left the group';

      case 'USER_ADDED':
        if (content.isNotEmpty) return content;
        if (actorName != null && targetName != null) {
          return '$actorName added $targetName to the group';
        }
        return '${actorName ?? 'Someone'} added a member to the group';

      case 'USER_REMOVED':
        if (content.isNotEmpty) return content;
        if (actorName != null && targetName != null) {
          return '$actorName removed $targetName from the group';
        }
        return '${actorName ?? 'Someone'} removed a member from the group';

      case 'NAME_CHANGED':
        if (content.isNotEmpty) return content;
        if (actorName != null && additionalInfo != null) {
          return '$actorName changed the group name to "$additionalInfo"';
        }
        return '${actorName ?? 'Someone'} changed the group name';

      case 'AVATAR_CHANGED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} changed the group photo';

      case 'ADMIN_PROMOTED':
        if (content.isNotEmpty) return content;
        if (actorName != null && targetName != null) {
          return '$actorName made $targetName a group admin';
        }
        return '${targetName ?? 'Someone'} is now a group admin';

      case 'ADMIN_DEMOTED':
        if (content.isNotEmpty) return content;
        if (actorName != null && targetName != null) {
          return '$actorName removed $targetName as a group admin';
        }
        return '${targetName ?? 'Someone'} is no longer a group admin';

      case 'MESSAGE_PINNED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} pinned a message';

      case 'MESSAGE_UNPINNED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} unpinned a message';

      case 'GROUP_CREATED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} created the group';

      case 'CALL_STARTED':
        return content.isNotEmpty ? content : '${actorName ?? 'Someone'} started a call';

      case 'CALL_ENDED':
        if (content.isNotEmpty) return content;
        if (additionalInfo != null) {
          return 'Call ended • $additionalInfo';
        }
        return 'Call ended';

      case 'CALL_MISSED':
        return content.isNotEmpty ? content : 'Missed call from ${actorName ?? 'someone'}';

      default:
        return content;
    }
  }
}
