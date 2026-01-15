import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:flutter/material.dart';

/// Helper function to detect correct message type from reply message
String _detectMessageTypeFromReply(ReplyToMessage replyToMessage) {
  var type = replyToMessage.type.toUpperCase();
  
  // 🔧 FIX: Backend sometimes returns wrong type - detect from mediaUrl and duration
  if (type == 'TEXT' && replyToMessage.mediaUrl != null) {
    if (replyToMessage.duration != null) {
      type = 'VOICE';
    } else {
      final url = replyToMessage.mediaUrl!.toLowerCase();
      if (url.contains('.mp3') || url.contains('.m4a') || url.contains('/audio/')) {
        type = 'AUDIO';
      } else if (url.contains('.jpg') || url.contains('.png') || url.contains('/image/')) {
        type = 'IMAGE';
      } else if (url.contains('.mp4') || url.contains('/video/')) {
        type = 'VIDEO';
      }
    }
  }
  
  return type;
}

/// Helper function to detect correct message type from full message
String _detectMessageTypeFromMessage(Message message) {
  var type = message.type.toUpperCase();
  
  // 🔧 FIX: Backend sometimes returns wrong type - detect from mediaUrl and duration
  if (type == 'TEXT' && message.mediaUrl != null) {
    if (message.duration != null) {
      type = 'VOICE';
    } else {
      final url = message.mediaUrl!.toLowerCase();
      if (url.contains('.mp3') || url.contains('.m4a') || url.contains('/audio/')) {
        type = 'AUDIO';
      } else if (url.contains('.jpg') || url.contains('.png') || url.contains('/image/')) {
        type = 'IMAGE';
      } else if (url.contains('.mp4') || url.contains('/video/')) {
        type = 'VIDEO';
      }
    }
  }
  
  return type;
}

/// Widget to show the message being replied to
class ReplyMessagePreview extends StatelessWidget {
  const ReplyMessagePreview({super.key, required this.replyToMessage, required this.onCancel});

  final Message replyToMessage;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        children: [
          // Reply indicator line
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 12),
          // Message preview
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  replyToMessage.senderFullName ?? replyToMessage.senderUsername ?? 'User',
                  style: textTheme.labelMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _getMessagePreview(),
                  style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Cancel button
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: onCancel,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  String _getMessagePreview() {
    final type = _detectMessageTypeFromMessage(replyToMessage);
    
    // If content is not empty, show it for text messages
    if (type == 'TEXT' && replyToMessage.content.isNotEmpty) {
      return replyToMessage.content;
    }
    
    // For other types or empty content, show type-specific preview
    switch (type) {
      case 'EMOJI':
        return replyToMessage.content.isNotEmpty ? replyToMessage.content : '😊 Emoji';
      case 'STICKER':
        return '🎭 Sticker';
      case 'IMAGE':
        return '📷 Photo';
      case 'VIDEO':
        return '🎥 Video';
      case 'AUDIO':
      case 'VOICE':
        return '🎤 Voice message';
      case 'DOCUMENT':
      case 'FILE':
        return '📄 ${replyToMessage.fileName ?? 'Document'}';
      case 'LOCATION':
        return '📍 ${replyToMessage.locationName ?? 'Location'}';
      case 'TEXT':
      default:
        return replyToMessage.content.isNotEmpty ? replyToMessage.content : 'Message';
    }
  }
}

/// Widget to show quoted message inside a message bubble
class QuotedMessageWidget extends StatelessWidget {
  const QuotedMessageWidget({super.key, required this.replyToMessage, required this.onTap});

  final ReplyToMessage replyToMessage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: colors.primary, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              replyToMessage.senderFullName ?? replyToMessage.senderUsername,
              style: textTheme.labelSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              _getMessagePreview(),
              style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getMessagePreview() {
    final type = _detectMessageTypeFromReply(replyToMessage);
    
    // If content is not empty, show it for text messages
    if (type == 'TEXT' && replyToMessage.content.isNotEmpty) {
      return replyToMessage.content;
    }
    
    // For other types or empty content, show type-specific preview
    switch (type) {
      case 'EMOJI':
        return replyToMessage.content.isNotEmpty ? replyToMessage.content : '😊 Emoji';
      case 'STICKER':
        return '🎭 Sticker';
      case 'IMAGE':
        return '📷 Photo';
      case 'VIDEO':
        return '🎥 Video';
      case 'AUDIO':
      case 'VOICE':
        return '🎤 Voice message';
      case 'DOCUMENT':
      case 'FILE':
        return '📄 ${replyToMessage.fileName ?? 'Document'}';
      case 'LOCATION':
        return '📍 ${replyToMessage.locationName ?? 'Location'}';
      case 'TEXT':
      default:
        return replyToMessage.content.isNotEmpty ? replyToMessage.content : 'Message';
    }
  }
}
