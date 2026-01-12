import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/mention_text_field.dart';
import 'package:flutter/material.dart';

/// Text message bubble
class TextMessageBubble extends StatelessWidget {
  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onPin,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
    this.isGroup = false,
    this.isLastMessage = false,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onPin;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final ReplyToMessage? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isGroup;
  final bool isLastMessage;

  @override
  Widget build(BuildContext context) {
    final textColor = FormatUtils.getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    // Extract mentioned user names from message
    final mentionedNames = message.mentionedUsers
        .map((user) => user.fullName.isNotEmpty ? user.fullName : user.username)
        .toList();

    return BaseBubbleContainer(
      isMe: isMe,
      message: message,
      onReply: onReply,
      onPin: onPin,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      onEdit: onEdit,
      onDelete: onDelete,
      isGroup: isGroup,
      isLastMessage: isLastMessage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: MentionText(
          text: message.content,
          style: textTheme.bodyMedium?.copyWith(color: textColor),
          mentionedUserNames: mentionedNames,
        ),
      ),
    );
  }
}
