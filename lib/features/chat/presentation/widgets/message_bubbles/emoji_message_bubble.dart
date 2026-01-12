import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:flutter/material.dart';

/// Emoji message bubble - displays standalone emoji (larger size, no background)
/// Similar to Telegram/WhatsApp emoji messages
class EmojiMessageBubble extends StatefulWidget {
  const EmojiMessageBubble({
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
  State<EmojiMessageBubble> createState() => _EmojiMessageBubbleState();
}

class _EmojiMessageBubbleState extends State<EmojiMessageBubble> {
  double _dragDistance = 0;
  double _initialDragDirection = 0;
  bool _isDragging = false;

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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(left: widget.isMe ? 48 : 8, right: widget.isMe ? 8 : 48, top: 1, bottom: 1),
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
            if (_initialDragDirection == 0 && details.delta.dx.abs() > 2) {
              _initialDragDirection = details.delta.dx > 0 ? 1 : -1;
            }

            final currentDirection = details.delta.dx > 0 ? 1 : -1;
            if (_initialDragDirection != 0 && currentDirection == _initialDragDirection) {
              _dragDistance += details.delta.dx;
              _dragDistance = _dragDistance.clamp(-100.0, 100.0);
            } else if (_initialDragDirection != 0 && currentDirection != _initialDragDirection) {
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
          if (widget.onReply == null && widget.onAddReaction == null && widget.onDelete == null) {
            return;
          }

          // Show context menu
          _showContextMenu(context);
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
                  // Emoji - displayed large without background
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.message.content,
                      style: const TextStyle(fontSize: 72), // Large emoji
                    ),
                  ),
                  // Timestamp
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                    child: Text(
                      _formatTime(widget.message.createdAt),
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.onReply != null)
              ListTile(
                leading: const Icon(Icons.reply),
                title: const Text('Reply'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onReply!();
                },
              ),
            if (widget.onAddReaction != null)
              ListTile(
                leading: const Icon(Icons.add_reaction_outlined),
                title: const Text('Add Reaction'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onAddReaction!();
                },
              ),
            // Quick reactions
            if (widget.onReactionTap != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['👍', '❤️', '😂', '😮', '😢', '😡']
                      .map(
                        (emoji) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _handleQuickReaction(emoji);
                          },
                          child: Text(emoji, style: const TextStyle(fontSize: 28)),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (widget.onDelete != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDelete!();
                },
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
