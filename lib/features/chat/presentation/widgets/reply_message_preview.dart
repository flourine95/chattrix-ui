import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';

/// Widget to show the message being replied to
class ReplyMessagePreview extends StatelessWidget {
  const ReplyMessagePreview({
    super.key,
    required this.replyToMessage,
    required this.onCancel,
  });

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
        border: Border(
          top: BorderSide(color: colors.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          // Reply indicator line
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          // Message preview
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  replyToMessage.sender.fullName,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _getMessagePreview(),
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
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
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ],
      ),
    );
  }

  String _getMessagePreview() {
    final type = replyToMessage.type.toUpperCase();
    switch (type) {
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
        return replyToMessage.content;
    }
  }
}

/// Widget to show quoted message inside a message bubble
class QuotedMessageWidget extends StatelessWidget {
  const QuotedMessageWidget({
    super.key,
    required this.replyToMessage,
    required this.onTap,
  });

  final Message replyToMessage;
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
          border: Border(
            left: BorderSide(
              color: colors.primary,
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              replyToMessage.sender.fullName,
              style: textTheme.labelSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              _getMessagePreview(),
              style: textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getMessagePreview() {
    final type = replyToMessage.type.toUpperCase();
    switch (type) {
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
        return replyToMessage.content;
    }
  }
}

