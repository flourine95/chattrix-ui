import 'dart:convert';

import 'package:flutter/foundation.dart';

class SystemMessageFormatter {
  static String format({
    required String type,
    required String content,
    String? actorName,
    String? targetName,
    String? additionalInfo,
  }) {
    Map<String, dynamic>? jsonData;
    try {
      if (content.startsWith('{')) {
        jsonData = jsonDecode(content);
      }
    } catch (e) {
      debugPrint('⚠️ Failed to parse system message JSON: $e');
    }
    debugPrint('jsonData: $jsonData');
    switch (type.toUpperCase()) {
      case 'USER_JOINED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        return '$userName joined the group';

      case 'USER_JOINED_VIA_LINK':
        try {
          final userName = jsonData?['userName'] as String?;
          final username = jsonData?['username'] as String?;
          final displayName = userName ?? username ?? actorName ?? 'Someone';
          final formattedMessage = '$displayName joined via invite link';
          return formattedMessage;
        } catch (e) {
          return '${actorName ?? 'Someone'} joined via invite link';
        }

      case 'USER_LEFT':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        return '$userName left the group';

      case 'USER_ADDED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        // addedBy is userId, we need to get name from somewhere else
        // For now, use a generic message since we don't have the actor's name
        return '$userName was added to the group';

      case 'USER_KICKED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        // kickedBy is userId, we need to get name from somewhere else
        return '$userName was removed from the group';

      case 'USER_REMOVED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor removed $target from the group';
        }
        return '${actor ?? 'Someone'} removed a member from the group';

      case 'GROUP_NAME_CHANGED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        final newName = jsonData?['newName'] ?? additionalInfo;
        final oldName = jsonData?['oldName'];
        if (newName != null) {
          if (oldName != null && oldName.toString().isNotEmpty) {
            return '$userName changed the group name from "$oldName" to "$newName"';
          }
          return '$userName changed the group name to "$newName"';
        }
        return '$userName changed the group name';

      case 'NAME_CHANGED':
        final actor = jsonData?['actorName'] ?? actorName;
        final newName = jsonData?['newName'] ?? additionalInfo;
        if (actor != null && newName != null) {
          return '$actor changed the group name to "$newName"';
        }
        return '${actor ?? 'Someone'} changed the group name';

      case 'GROUP_AVATAR_CHANGED':
        final userName = jsonData?['userName'] ?? actorName ?? 'Someone';
        return '$userName changed the group photo';

      case 'AVATAR_CHANGED':
        final actor = jsonData?['actorName'] ?? actorName ?? 'Someone';
        return '$actor changed the group photo';

      case 'USER_PROMOTED':
        final userName = jsonData?['userName'] ?? targetName ?? 'Someone';
        // promotedBy is userId, we need to get name from somewhere else
        return '$userName is now a group admin';

      case 'ADMIN_PROMOTED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor made $target a group admin';
        }
        return '${target ?? 'Someone'} is now a group admin';

      case 'USER_DEMOTED':
        final userName = jsonData?['userName'] ?? targetName ?? 'Someone';
        // demotedBy is userId, we need to get name from somewhere else
        return '$userName is no longer a group admin';

      case 'ADMIN_DEMOTED':
        final actor = jsonData?['actorName'] ?? actorName;
        final target = jsonData?['targetName'] ?? targetName;
        if (actor != null && target != null) {
          return '$actor removed $target as a group admin';
        }
        return '${target ?? 'Someone'} is no longer a group admin';

      case 'MEMBER_MUTED':
        final userName = jsonData?['userName'] ?? targetName ?? 'Someone';
        // mutedBy is userId, we need to get name from somewhere else
        final mutedUntil = jsonData?['mutedUntil'];
        if (mutedUntil != null) {
          return '$userName was muted temporarily';
        }
        return '$userName was muted';

      case 'MEMBER_UNMUTED':
        final userName = jsonData?['userName'] ?? targetName ?? 'Someone';
        // unmutedBy is userId, we need to get name from somewhere else
        return '$userName was unmuted';

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
        if (jsonData != null && jsonData['message'] != null) {
          return jsonData['message'].toString();
        }
        return content;
    }
  }
}
