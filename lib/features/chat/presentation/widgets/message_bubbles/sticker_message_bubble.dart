import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_long_press_overlay.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_reactions.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/seen_status_widget.dart';
import 'package:flutter/material.dart';

/// Sticker Message Bubble
///
/// Displays animated stickers from Giphy in chat messages
/// Stickers are displayed without background bubble (like Telegram/WhatsApp)
class StickerMessageBubble extends StatefulWidget {
  const StickerMessageBubble({
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
  final ReplyToMessage? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isGroup;
  final bool isLastMessage;

  @override
  State<StickerMessageBubble> createState() => _StickerMessageBubbleState();
}

class _StickerMessageBubbleState extends State<StickerMessageBubble> {
  final GlobalKey _stickerKey = GlobalKey();
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
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      key: _stickerKey,
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
          showMessageLongPressOverlay(
            context: context,
            message: widget.message,
            messageKey: _stickerKey,
            isMe: widget.isMe,
            onReply: widget.onReply,
            onAddReaction: widget.onAddReaction,
            onEdit: null, // Stickers can't be edited
            onDelete: widget.onDelete,
            onQuickReaction: _handleQuickReaction,
            canEdit: false,
          );
        },
        child: Stack(
          children: [
            // Reply icon indicator
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
            // Sticker content
            Transform.translate(
              offset: Offset(_dragDistance * 0.5, 0),
              child: Column(
                crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Show quoted message if this is a reply
                  if (widget.replyToMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: QuotedMessageWidget(replyToMessage: widget.replyToMessage!, onTap: null),
                      ),
                    ),
                  // Sticker image without background bubble
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 120, maxWidth: 180, minHeight: 120, maxHeight: 180),
                    child: widget.message.mediaUrl != null && widget.message.mediaUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.message.mediaUrl!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => SizedBox(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 28,
                                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Failed to load',
                                    style: TextStyle(fontSize: 10, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            // Performance optimizations
                            memCacheWidth: 360, // 2x for retina
                            maxWidthDiskCache: 360,
                            fadeInDuration: const Duration(milliseconds: 150),
                            fadeOutDuration: const Duration(milliseconds: 100),
                          )
                        : SizedBox(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image_outlined,
                                  size: 28,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No sticker URL',
                                  style: TextStyle(fontSize: 10, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                                ),
                              ],
                            ),
                          ),
                  ),
                  // Reactions
                  if (widget.currentUserId != null)
                    MessageReactions(
                      reactions: widget.message.reactions,
                      currentUserId: widget.currentUserId!,
                      onReactionTap: widget.onReactionTap ?? (_) {},
                      onAddReaction: widget.onAddReaction ?? () {},
                    ),
                  // Seen Status - Only show for messages sent by current user AND only on last message
                  if (widget.isMe && widget.isLastMessage)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SeenStatusWidget(message: widget.message, isGroup: widget.isGroup, compact: false),
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
