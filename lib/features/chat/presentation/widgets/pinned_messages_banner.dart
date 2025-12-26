import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Banner hiển thị tin nhắn đã ghim ở dưới header
class PinnedMessagesBanner extends StatelessWidget {
  final List<Message> pinnedMessages;
  final String conversationId;

  const PinnedMessagesBanner({super.key, required this.pinnedMessages, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    if (pinnedMessages.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Hiển thị tin nhắn đầu tiên (mới nhất)
    final message = pinnedMessages.first;
    final content = _getMessagePreview(message);

    return Material(
      color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
      child: InkWell(
        onTap: () {
          // Navigate to pinned messages page
          context.push('/chat/$conversationId/pinned-messages');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.push_pin, size: 20, color: colors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pinnedMessages.length == 1 ? 'Pinned Message' : '${pinnedMessages.length} Pinned Messages',
                      style: textTheme.labelMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      content,
                      style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: colors.onSurface.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }

  String _getMessagePreview(Message message) {
    switch (message.type.toUpperCase()) {
      case 'TEXT':
        return message.content;
      case 'IMAGE':
        return '📷 Photo';
      case 'VIDEO':
        return '🎥 Video';
      case 'AUDIO':
      case 'VOICE':
        return '🎵 Audio';
      case 'FILE':
      case 'DOCUMENT':
        return '📄 ${message.fileName ?? 'File'}';
      case 'LOCATION':
        return '📍 Location';
      case 'POLL':
        return '📊 Poll';
      case 'EMOJI':
        return message.content;
      case 'STICKER':
        return '🎨 Sticker';
      default:
        return message.content;
    }
  }
}
