import 'dart:convert';
import 'package:flutter/foundation.dart';

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
  /// - USER_JOINED_VIA_LINK: "John joined via invite link"
  /// - MUTED: "Alice muted the conversation"
  /// - UNMUTED: "Alice unmuted the conversation"
  static String format({
    required String type,
    required String content,
    String? actorName,
    String? targetName,
    String? additionalInfo,
  }) {
    // Try to parse JSON content for additional data
    Map<String, dynamic>? jsonData;
    try {
      if (content.startsWith('{')) {
        jsonData = jsonDecode(content);
      }
    } catch (e) {
      debugPrint('⚠️ Failed to parse system message JSON: $e');
    }

    switch (type.toUpperCase()) {
      case 'USER_JOINED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        return '$userName joined the group';

      case 'USER_JOINED_VIA_LINK':
        debugPrint('🔍 USER_JOINED_VIA_LINK - Raw content: $content');
        debugPrint('🔍 USER_JOINED_VIA_LINK - actorName: $actorName');
        try {
          final userName = jsonData?['userName'] as String?;
          final username = jsonData?['username'] as String?;
          final displayName = userName ?? username ?? actorName ?? 'Someone';
          final formattedMessage = '$displayName joined via invite link';
          debugPrint('🔍 USER_JOINED_VIA_LINK - Formatted: $formattedMessage');
          return formattedMessage;
        } catch (e) {
          debugPrint('❌ Error parsing user_joined_via_link content: $e');
          return '${actorName ?? 'Someone'} joined via invite link';
        }

      case 'USER_LEFT':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        return '$userName left the group';

      case 'USER_ADDED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor added $target to the group';
        }
        return '${actor ?? 'Someone'} added a member to the group';

      case 'USER_REMOVED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor removed $target from the group';
        }
        return '${actor ?? 'Someone'} removed a member from the group';

      case 'NAME_CHANGED':
        final actor = jsonData?['actorName'] ?? actorName;
        final newName = jsonData?['newName'] ?? additionalInfo;
        if (actor != null && newName != null) {
          return '$actor changed the group name to "$newName"';
        }
        return '${actor ?? 'Someone'} changed the group name';

      case 'AVATAR_CHANGED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor changed the group photo';

      case 'ADMIN_PROMOTED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor made $target a group admin';
        }
        return '${target ?? 'Someone'} is now a group admin';

      case 'ADMIN_DEMOTED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor removed $target as a group admin';
        }
        return '${target ?? 'Someone'} is no longer a group admin';

      case 'MESSAGE_PINNED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor pinned a message';

      case 'MESSAGE_UNPINNED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor unpinned a message';

      case 'GROUP_CREATED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor created the group';

      case 'MUTED':
      case 'CONVERSATION_MUTED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor muted the conversation';

      case 'UNMUTED':
      case 'CONVERSATION_UNMUTED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor unmuted the conversation';

      case 'CALL_STARTED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor started a call';

      case 'CALL_ENDED':
        final duration = jsonData?['duration'] ?? additionalInfo;
        if (duration != null) {
          return 'Call ended • $duration';
        }
        return 'Call ended';

      case 'CALL_MISSED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'someone';
        return 'Missed call from $actor';

      default:
        // If we have JSON data, try to extract a message
        if (jsonData != null && jsonData['message'] != null) {
          return jsonData['message'].toString();
        }
        return content;
    }
  }
}
