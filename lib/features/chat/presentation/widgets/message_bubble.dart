import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/audio_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/document_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/image_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/location_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/text_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/video_message_bubble.dart';
import 'package:flutter/material.dart';

/// Main message bubble widget that renders different types of messages
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    // Determine message type and render appropriate bubble
    final messageType = message.type.toUpperCase();

    switch (messageType) {
      case 'IMAGE':
        return ImageMessageBubble(message: message, isMe: isMe);
      case 'VIDEO':
        return VideoMessageBubble(message: message, isMe: isMe);
      case 'AUDIO':
      case 'VOICE':
        return AudioMessageBubble(message: message, isMe: isMe);
      case 'DOCUMENT':
      case 'FILE':
        return DocumentMessageBubble(message: message, isMe: isMe);
      case 'LOCATION':
        return LocationMessageBubble(message: message, isMe: isMe);
      case 'TEXT':
      default:
        return TextMessageBubble(message: message, isMe: isMe);
    }
  }
}

/// Base bubble container for all message types
class BaseBubbleContainer extends StatelessWidget {
  const BaseBubbleContainer({
    super.key,
    required this.isMe,
    required this.child,
    this.maxWidth = 280,
  });

  final bool isMe;
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bg = isMe
        ? (isDark ? colors.primary : Colors.grey.shade200)
        : (isDark ? colors.surface : Colors.black);

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 48 : 8,
        right: isMe ? 8 : 48,
        top: 6,
        bottom: 6,
      ),
      constraints: BoxConstraints(maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isMe ? 16 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 16),
        ),
        border: isMe
            ? Border.all(color: Colors.grey.shade300)
            : null,
      ),
      child: child,
    );
  }
}

/// Helper to get text color based on theme and sender
Color getTextColor(BuildContext context, bool isMe) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;
  final isDark = theme.brightness == Brightness.dark;

  return isMe
      ? (isDark ? colors.onPrimary : Colors.black)
      : (isDark ? colors.onSurface : Colors.white);
}

/// Helper to format file size
String formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
}

/// Helper to format duration
String formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

