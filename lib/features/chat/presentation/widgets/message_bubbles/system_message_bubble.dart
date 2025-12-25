import 'dart:convert';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/system_message_formatter.dart';
import 'package:flutter/material.dart';

class SystemMessageBubble extends StatelessWidget {
  const SystemMessageBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    String? systemMessageType;

    if (message.content.startsWith('{')) {
      try {
        final jsonData = jsonDecode(message.content);
        systemMessageType = jsonData['type'] as String?;
      } catch (e) {
        debugPrint('❌ Failed to parse system message JSON: $e');
      }
    }

    final formattedContent = systemMessageType != null
        ? SystemMessageFormatter.format(
            type: systemMessageType,
            content: message.content,
            actorName: message.senderFullName ?? message.senderUsername,
          )
        : message.content;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (systemMessageType != null) ...[
            Icon(
              _getIconForSystemMessageType(systemMessageType),
              size: 13,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
          ],
          Flexible(child: _buildRichText(formattedContent, isDark, message.mentionedUsers)),
        ],
      ),
    );
  }

  Widget _buildRichText(String text, bool isDark, List<dynamic> mentionedUsers) {
    final List<String> namesToBold = [];

    for (var user in mentionedUsers) {
      if (user.fullName != null && user.fullName.isNotEmpty) {
        namesToBold.add(user.fullName);
      }
      if (user.username != null && user.username.isNotEmpty) {
        namesToBold.add(user.username);
      }
    }

    if (namesToBold.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      );
    }

    final List<TextSpan> spans = [];
    String remainingText = text;

    while (remainingText.isNotEmpty) {
      int earliestIndex = -1;
      String? foundName;

      for (var name in namesToBold) {
        final index = remainingText.indexOf(name);
        if (index != -1 && (earliestIndex == -1 || index < earliestIndex)) {
          earliestIndex = index;
          foundName = name;
        }
      }

      if (earliestIndex == -1) {
        spans.add(TextSpan(text: remainingText));
        break;
      }

      if (earliestIndex > 0) {
        spans.add(TextSpan(text: remainingText.substring(0, earliestIndex)));
      }

      spans.add(
        TextSpan(
          text: foundName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

      remainingText = remainingText.substring(earliestIndex + foundName!.length);
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
          fontWeight: FontWeight.w400,
        ),
        children: spans,
      ),
      textAlign: TextAlign.center,
    );
  }

  IconData _getIconForSystemMessageType(String type) {
    switch (type.toUpperCase()) {
      case 'USER_JOINED':
        return Icons.person_add_rounded;
      case 'USER_JOINED_VIA_LINK':
        return Icons.link_rounded;
      case 'USER_LEFT':
        return Icons.person_remove_rounded;
      case 'USER_ADDED':
        return Icons.group_add_rounded;
      case 'USER_KICKED':
        return Icons.person_remove_rounded;
      case 'USER_REMOVED':
        return Icons.group_remove_rounded;
      case 'GROUP_NAME_CHANGED':
      case 'NAME_CHANGED':
        return Icons.edit_rounded;
      case 'GROUP_AVATAR_CHANGED':
      case 'AVATAR_CHANGED':
        return Icons.image_rounded;
      case 'USER_PROMOTED':
      case 'ADMIN_PROMOTED':
        return Icons.admin_panel_settings_rounded;
      case 'USER_DEMOTED':
      case 'ADMIN_DEMOTED':
        return Icons.remove_moderator_rounded;
      case 'MEMBER_MUTED':
        return Icons.mic_off_rounded;
      case 'MEMBER_UNMUTED':
        return Icons.mic_rounded;
      case 'MESSAGE_PINNED':
        return Icons.push_pin_rounded;
      case 'MESSAGE_UNPINNED':
        return Icons.push_pin_outlined;
      case 'GROUP_CREATED':
        return Icons.group_rounded;
      case 'MUTED':
      case 'CONVERSATION_MUTED':
        return Icons.notifications_off_rounded;
      case 'UNMUTED':
      case 'CONVERSATION_UNMUTED':
        return Icons.notifications_active_rounded;
      case 'CALL_STARTED':
        return Icons.call_rounded;
      case 'CALL_ENDED':
        return Icons.call_end_rounded;
      case 'CALL_MISSED':
        return Icons.phone_missed_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }
}
