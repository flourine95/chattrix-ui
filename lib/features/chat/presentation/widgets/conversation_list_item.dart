import 'package:flutter/material.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';

/// Widget to display a conversation item in the list
///
/// Features:
/// - Avatar with online indicator (for DIRECT conversations)
/// - Conversation name (uses ConversationUtils.getConversationTitle)
/// - Last message with sender name (for groups)
/// - Timestamp (uses ConversationUtils.formatTimeAgo)
/// - Unread count badge (if unreadCount > 0)
/// - Typing indicator (if user is typing)
/// - Tap to navigate to chat detail
class ConversationListItem extends StatelessWidget {
  final Conversation conversation;
  final User? currentUser;
  final VoidCallback onTap;
  final bool isTyping;

  const ConversationListItem({
    super.key,
    required this.conversation,
    required this.currentUser,
    required this.onTap,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get conversation title
    final title = ConversationUtils.getConversationTitle(conversation, currentUser);

    // Get last message preview
    final lastMessagePreview = _getLastMessagePreview();

    // Get timestamp
    final timestamp = _getTimestamp();

    // Check if user is online (for DIRECT conversations)
    final isOnline =
        conversation.type == ConversationType.direct && ConversationUtils.isUserOnline(conversation, currentUser);

    // Build semantic label for screen readers
    final semanticLabel = _buildSemanticLabel(title, lastMessagePreview, timestamp, isOnline);

    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: true,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Avatar with online indicator
              Stack(
                children: [
                  _buildAvatar(title),

                  // Online indicator (only for DIRECT conversations)
                  if (isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF31A24C),
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 12),

              // Conversation details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and timestamp row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Timestamp
                        Text(
                          timestamp,
                          style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Last message and unread badge row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessagePreview,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                              fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Unread count badge
                        if (conversation.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              conversation.unreadCount > 99 ? '99+' : conversation.unreadCount.toString(),
                              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build avatar based on conversation type
  Widget _buildAvatar(String title) {
    if (conversation.type == ConversationType.direct) {
      // For DIRECT conversations, use other participant's avatar
      final otherParticipant = ConversationUtils.getOtherParticipant(conversation, currentUser);

      return UserAvatar(avatarUrl: otherParticipant?.avatarUrl, displayName: title, radius: 24);
    } else {
      // For GROUP conversations, use group avatar or default
      return UserAvatar(avatarUrl: conversation.avatarUrl, displayName: title, radius: 24);
    }
  }

  /// Get last message preview text
  String _getLastMessagePreview() {
    // If typing, show typing indicator
    if (isTyping) {
      return 'Đang soạn tin...';
    }

    // If no last message
    if (conversation.lastMessage == null) {
      return 'No messages yet';
    }

    final lastMessage = conversation.lastMessage!;

    // Format message content based on type
    String content;
    switch (lastMessage.type.toUpperCase()) {
      case 'IMAGE':
        content = '📷 Photo';
        break;
      case 'VIDEO':
        content = '🎥 Video';
        break;
      case 'AUDIO':
        content = '🎵 Audio';
        break;
      case 'FILE':
        content = '📎 File';
        break;
      case 'LOCATION':
        content = '📍 Location';
        break;
      default:
        content = lastMessage.content;
    }

    // For GROUP conversations, add sender name
    if (conversation.type == ConversationType.group) {
      final senderName = _getSenderName(lastMessage);
      if (senderName != null) {
        return '$senderName: $content';
      }
    }

    // For DIRECT conversations or if sender is current user
    if (currentUser != null && lastMessage.senderId == currentUser!.id) {
      return 'You: $content';
    }

    return content;
  }

  /// Get sender name for group messages
  String? _getSenderName(dynamic lastMessage) {
    // Check if sender is current user
    if (currentUser != null && lastMessage.senderId == currentUser!.id) {
      return 'You';
    }

    // Use senderFullName if available, otherwise senderUsername
    if (lastMessage.senderFullName != null && lastMessage.senderFullName!.isNotEmpty) {
      // Return first name only
      final parts = lastMessage.senderFullName!.split(' ');
      return parts.first;
    }

    if (lastMessage.senderUsername != null && lastMessage.senderUsername!.isNotEmpty) {
      return lastMessage.senderUsername;
    }

    return null;
  }

  /// Get formatted timestamp
  String _getTimestamp() {
    if (conversation.lastMessage == null) {
      return ConversationUtils.formatTimeAgo(conversation.updatedAt);
    }

    return ConversationUtils.formatTimeAgo(conversation.lastMessage!.createdAt);
  }

  /// Build semantic label for screen readers
  String _buildSemanticLabel(String title, String lastMessage, String timestamp, bool isOnline) {
    final buffer = StringBuffer();

    // Conversation title
    buffer.write('Conversation with $title. ');

    // Online status for direct conversations
    if (conversation.type == ConversationType.direct) {
      buffer.write(isOnline ? 'Online. ' : 'Offline. ');
    }

    // Last message
    if (isTyping) {
      buffer.write('Typing. ');
    } else {
      buffer.write('Last message: $lastMessage. ');
    }

    // Timestamp
    buffer.write('$timestamp. ');

    // Unread count
    if (conversation.unreadCount > 0) {
      buffer.write('${conversation.unreadCount} unread ${conversation.unreadCount == 1 ? 'message' : 'messages'}. ');
    }

    buffer.write('Double tap to open.');

    return buffer.toString();
  }
}
