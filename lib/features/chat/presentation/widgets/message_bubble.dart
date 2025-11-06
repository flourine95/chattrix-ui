import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/audio_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/document_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/image_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/location_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/text_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/video_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_reactions.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:flutter/material.dart';

/// Main message bubble widget that renders different types of messages
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    // Determine message type and render appropriate bubble
    final messageType = message.type.toUpperCase();

    // Wrap in RepaintBoundary to isolate repaints and improve scroll performance
    return RepaintBoundary(
      child: switch (messageType) {
        'IMAGE' => ImageMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        'VIDEO' => VideoMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        'AUDIO' || 'VOICE' => AudioMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        'DOCUMENT' || 'FILE' => DocumentMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        'LOCATION' => LocationMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        _ => TextMessageBubble(
            message: message,
            isMe: isMe,
            onReply: onReply,
            onReactionTap: onReactionTap,
            onAddReaction: onAddReaction,
            currentUserId: currentUserId,
            replyToMessage: replyToMessage,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
      },
    );
  }
}

/// Base bubble container for all message types with reply and reaction support
class BaseBubbleContainer extends StatelessWidget {
  const BaseBubbleContainer({
    super.key,
    required this.isMe,
    required this.child,
    this.maxWidth = 280,
    this.message,
    this.onReply,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
  });

  final bool isMe;
  final Widget child;
  final double maxWidth;
  final Message? message;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bg = isMe
        ? (isDark ? colors.primary : Colors.grey.shade200)
        : (isDark ? colors.surface : Colors.black);

    return GestureDetector(
      onLongPress: () => _showMessageOptions(context),
      child: Container(
        margin: EdgeInsets.only(
          left: isMe ? 48 : 8,
          right: isMe ? 8 : 48,
          top: 6,
          bottom: 6,
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
                border: isMe ? Border.all(color: Colors.grey.shade300) : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show quoted message if this is a reply
                  if (replyToMessage != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: QuotedMessageWidget(
                        replyToMessage: replyToMessage!,
                        onTap: null,
                      ),
                    ),
                  child,
                ],
              ),
            ),
            // Reactions
            if (message != null && currentUserId != null)
              MessageReactions(
                reactions: message!.reactions,
                currentUserId: currentUserId!,
                onReactionTap: onReactionTap ?? (_) {},
                onAddReaction: onAddReaction ?? () {},
              ),
          ],
        ),
      ),
    );
  }

  void _showMessageOptions(BuildContext context) {
    if (onReply == null && onAddReaction == null && onEdit == null && onDelete == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onReply != null)
              ListTile(
                leading: const Icon(Icons.reply),
                title: const Text('Reply'),
                onTap: () {
                  Navigator.pop(context);
                  onReply!();
                },
              ),
            if (onAddReaction != null)
              ListTile(
                leading: const Icon(Icons.add_reaction_outlined),
                title: const Text('Add Reaction'),
                onTap: () {
                  Navigator.pop(context);
                  onAddReaction!();
                },
              ),
            if (isMe && onEdit != null && message?.type == 'TEXT')
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit!();
                },
              ),
            if (isMe && onDelete != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  onDelete!();
                },
              ),
          ],
        ),
      ),
    );
  }
}

