import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/system_message_formatter.dart';
import 'package:flutter/material.dart';

/// System message bubble - centered, gray text, no avatar
/// Used for events like: user joined, user left, name changed, etc.
/// Similar to Messenger/Zalo system messages
class SystemMessageBubble extends StatelessWidget {
  const SystemMessageBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Format message content using formatter
    final formattedContent = message.systemMessageType != null
        ? SystemMessageFormatter.format(
            type: message.systemMessageType!,
            content: message.content,
            actorName: message.senderFullName ?? message.senderUsername,
          )
        : message.content;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon based on system message type
          if (message.systemMessageType != null) ...[
            Icon(
              _getIconForSystemMessageType(message.systemMessageType!),
              size: 13,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
          ],
          // Message text with rich formatting (bold names)
          Flexible(child: _buildRichText(formattedContent, isDark, message.mentionedUsers)),
        ],
      ),
    );
  }

  /// Build rich text with bold names for mentioned users
  Widget _buildRichText(String text, bool isDark, List<dynamic> mentionedUsers) {
    // Extract all names that should be bold (names in quotes or mentioned users)
    final List<String> namesToBold = [];

    // Add mentioned user names
    for (var user in mentionedUsers) {
      if (user.fullName != null && user.fullName.isNotEmpty) {
        namesToBold.add(user.fullName);
      }
      if (user.username != null && user.username.isNotEmpty) {
        namesToBold.add(user.username);
      }
    }

    // If no names to bold, return simple text
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

    // Build TextSpan with bold names
    final List<TextSpan> spans = [];
    String remainingText = text;

    while (remainingText.isNotEmpty) {
      // Find the earliest occurrence of any name
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
        // No more names found, add remaining text
        spans.add(TextSpan(text: remainingText));
        break;
      }

      // Add text before the name
      if (earliestIndex > 0) {
        spans.add(TextSpan(text: remainingText.substring(0, earliestIndex)));
      }

      // Add the name in bold
      spans.add(
        TextSpan(
          text: foundName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

      // Continue with remaining text
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

  /// Get icon based on system message type
  IconData _getIconForSystemMessageType(String type) {
    switch (type.toUpperCase()) {
      case 'USER_JOINED':
        return Icons.person_add_rounded;
      case 'USER_LEFT':
        return Icons.person_remove_rounded;
      case 'USER_ADDED':
        return Icons.group_add_rounded;
      case 'USER_REMOVED':
        return Icons.group_remove_rounded;
      case 'NAME_CHANGED':
        return Icons.edit_rounded;
      case 'AVATAR_CHANGED':
        return Icons.image_rounded;
      case 'ADMIN_PROMOTED':
        return Icons.admin_panel_settings_rounded;
      case 'ADMIN_DEMOTED':
        return Icons.remove_moderator_rounded;
      case 'MESSAGE_PINNED':
        return Icons.push_pin_rounded;
      case 'MESSAGE_UNPINNED':
        return Icons.push_pin_outlined;
      case 'GROUP_CREATED':
        return Icons.group_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }
}
