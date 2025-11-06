import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

/// Text message bubble
class TextMessageBubble extends StatelessWidget {
  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;

  @override
  Widget build(BuildContext context) {
    final textColor = FormatUtils.getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    return BaseBubbleContainer(
      isMe: isMe,
      message: message,
      onReply: onReply,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          message.content,
          style: textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ),
    );
  }
}

