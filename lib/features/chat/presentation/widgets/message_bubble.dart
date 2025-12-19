import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/audio_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/document_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/image_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/location_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/text_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubbles/video_message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_long_press_overlay.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_reactions.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/seen_status_widget.dart';
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
    this.isGroup = false,
    this.isLastMessage = false,
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
  final bool isGroup;
  final bool isLastMessage;

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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
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
          isGroup: isGroup,
          isLastMessage: isLastMessage,
        ),
      },
    );
  }
}

/// Base bubble container for all message types with reply and reaction support
class BaseBubbleContainer extends StatefulWidget {
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
    this.isGroup = false,
    this.isLastMessage = false,
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
  final bool isGroup;
  final bool isLastMessage;

  @override
  State<BaseBubbleContainer> createState() => _BaseBubbleContainerState();
}

class _BaseBubbleContainerState extends State<BaseBubbleContainer> with AutomaticKeepAliveClientMixin {
  final GlobalKey _messageKey = GlobalKey();
  double _dragDistance = 0;
  double _initialDragDirection = 0;
  bool _isDragging = false;

  // Cache colors to avoid rebuilding
  static final _greyLight = Colors.grey.shade200;
  static final _greyBorder = Colors.grey.shade300;

  @override
  bool get wantKeepAlive => true;

  void _handleQuickReaction(String emoji) {
    if (widget.onReactionTap != null) {
      widget.onReactionTap!(emoji);
    }
  }

  void _handleSwipeReply() {
    if (widget.onReply != null) {
      widget.onReply!();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bg = widget.isMe ? (isDark ? colors.primary : _greyLight) : (isDark ? colors.surface : Colors.black);

    return Container(
      key: _messageKey,
      margin: EdgeInsets.only(left: widget.isMe ? 48 : 8, right: widget.isMe ? 8 : 48, top: 1, bottom: 1),
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: GestureDetector(
        onDoubleTap: () {
          if (widget.onReactionTap != null) {
            widget.onReactionTap!('❤️');
          }
        },
        onHorizontalDragStart: (details) {
          if (widget.onReply == null) return;
          setState(() {
            _isDragging = true;
            _initialDragDirection = 0;
          });
        },
        onHorizontalDragUpdate: (details) {
          if (widget.onReply == null || !_isDragging) return;

          setState(() {
            // Track initial direction
            if (_initialDragDirection == 0 && details.delta.dx.abs() > 2) {
              _initialDragDirection = details.delta.dx > 0 ? 1 : -1;
            }

            // Only allow dragging in the initial direction
            final currentDirection = details.delta.dx > 0 ? 1 : -1;
            if (_initialDragDirection != 0 && currentDirection == _initialDragDirection) {
              _dragDistance += details.delta.dx;
              _dragDistance = _dragDistance.clamp(-100.0, 100.0);
            } else if (_initialDragDirection != 0 && currentDirection != _initialDragDirection) {
              // Dragging back - cancel the swipe
              _dragDistance += details.delta.dx * 1.5;
              if ((_initialDragDirection > 0 && _dragDistance < 0) ||
                  (_initialDragDirection < 0 && _dragDistance > 0)) {
                _dragDistance = 0;
                _initialDragDirection = 0;
              }
            }
          });
        },
        onHorizontalDragEnd: (details) {
          if (widget.onReply == null) return;

          // Only trigger reply if dragged in consistent direction and > threshold
          if (_dragDistance.abs() > 50 &&
              ((_initialDragDirection > 0 && _dragDistance > 0) || (_initialDragDirection < 0 && _dragDistance < 0))) {
            _handleSwipeReply();
          }

          setState(() {
            _dragDistance = 0;
            _initialDragDirection = 0;
            _isDragging = false;
          });
        },
        onLongPress: () {
          if (widget.onReply == null &&
              widget.onAddReaction == null &&
              widget.onEdit == null &&
              widget.onDelete == null) {
            return;
          }

          showMessageLongPressOverlay(
            context: context,
            messageKey: _messageKey,
            isMe: widget.isMe,
            onReply: widget.onReply,
            onAddReaction: widget.onAddReaction,
            onEdit: widget.onEdit,
            onDelete: widget.onDelete,
            onQuickReaction: _handleQuickReaction,
            canEdit: widget.message?.type == 'TEXT',
          );
        },
        child: Stack(
          children: [
            if (_dragDistance.abs() > 10)
              Positioned(
                left: widget.isMe ? null : 0,
                right: widget.isMe ? 0 : null,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Opacity(
                    opacity: (_dragDistance.abs() / 50).clamp(0.0, 1.0),
                    child: Icon(Icons.reply, color: colors.primary, size: 24),
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(_dragDistance * 0.5, 0),
              child: Column(
                crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(16),
                      border: widget.isMe ? Border.all(color: _greyBorder) : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Show quoted message if this is a reply
                        if (widget.replyToMessage != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                            child: QuotedMessageWidget(replyToMessage: widget.replyToMessage!, onTap: null),
                          ),
                        widget.child,
                      ],
                    ),
                  ),
                  // Reactions
                  if (widget.message != null && widget.currentUserId != null)
                    MessageReactions(
                      reactions: widget.message!.reactions,
                      currentUserId: widget.currentUserId!,
                      onReactionTap: widget.onReactionTap ?? (_) {},
                      onAddReaction: widget.onAddReaction ?? () {},
                    ),
                  // Seen Status - Only show for messages sent by current user AND only on last message
                  if (widget.isMe && widget.message != null && widget.isLastMessage)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SeenStatusWidget(message: widget.message!, isGroup: widget.isGroup, compact: false),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
