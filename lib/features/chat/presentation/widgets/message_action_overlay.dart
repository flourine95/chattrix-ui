import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';

class MessageActionOverlay extends StatefulWidget {
  const MessageActionOverlay({
    super.key,
    required this.message,
    required this.isMe,
    required this.messageWidget,
    required this.messagePosition,
    required this.onReply,
    required this.onReaction,
    this.onEdit,
    this.onDelete,
    this.onCopy,
  });

  final Message message;
  final bool isMe;
  final Widget messageWidget;
  final Offset messagePosition;
  final VoidCallback? onReply;
  final Function(String emoji) onReaction;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCopy;

  @override
  State<MessageActionOverlay> createState() => _MessageActionOverlayState();
}

class _MessageActionOverlayState extends State<MessageActionOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  static const List<String> _quickEmojis = ['❤️', '👍', '😂', '😮', '😢', '🙏'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _handleEmojiTap(String emoji) {
    debugPrint('🎯 [MessageActionOverlay] Emoji tapped: $emoji');
    widget.onReaction(emoji);
    _close();
  }

  void _handleAction(VoidCallback? action, String actionName) async {
    debugPrint('🎯 [MessageActionOverlay] Action tapped: $actionName');
    if (action != null) {
      debugPrint('✅ [MessageActionOverlay] Executing $actionName action');
      // Close overlay first
      await _controller.reverse();
      if (mounted) {
        Navigator.of(context).pop();
      }
      // Then execute action after a small delay to ensure overlay is fully closed
      await Future.delayed(const Duration(milliseconds: 100));
      action();
    } else {
      debugPrint('❌ [MessageActionOverlay] $actionName action is null!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: _close,
        child: Stack(
          children: [
            // Backdrop dim (no blur, just darken)
            Container(color: Colors.black.withValues(alpha: 0.5)),

            // Message and actions
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        // Quick emoji reactions
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: _quickEmojis.map((emoji) {
                                return InkWell(
                                  onTap: () => _handleEmojiTap(emoji),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: colors.surfaceContainerHighest,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      emoji,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'NotoColorEmoji',
                                        color: Colors.transparent,
                                        shadows: [Shadow(offset: Offset.zero, blurRadius: 0, color: Color(0xFF000000))],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        // Message bubble (highlighted)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: colors.primary.withValues(alpha: 0.3), blurRadius: 12, spreadRadius: 2),
                            ],
                          ),
                          child: widget.messageWidget,
                        ),

                        const SizedBox(height: 8),

                        // Action buttons
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Reply
                                if (widget.onReply != null)
                                  _ActionButton(
                                    icon: Icons.reply,
                                    label: 'Reply',
                                    onTap: () => _handleAction(widget.onReply, 'Reply'),
                                  ),

                                // Copy
                                if (widget.onCopy != null)
                                  _ActionButton(
                                    icon: Icons.copy,
                                    label: 'Copy',
                                    onTap: () => _handleAction(widget.onCopy, 'Copy'),
                                  ),

                                // Edit (only for text messages from current user)
                                if (widget.isMe && widget.onEdit != null && widget.message.type == 'TEXT')
                                  _ActionButton(
                                    icon: Icons.edit,
                                    label: 'Edit',
                                    onTap: () => _handleAction(widget.onEdit, 'Edit'),
                                  ),

                                // Delete (only for current user's messages)
                                if (widget.isMe && widget.onDelete != null)
                                  _ActionButton(
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    color: Colors.red,
                                    onTap: () => _handleAction(widget.onDelete, 'Delete'),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Action button widget
class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.color});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Use proper colors based on theme
    final buttonColor = color ?? (isDark ? colors.onSurface : colors.onSurface);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: buttonColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: buttonColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

/// Show message action overlay
Future<void> showMessageActionOverlay({
  required BuildContext context,
  required Message message,
  required bool isMe,
  required Widget messageWidget,
  required Offset messagePosition,
  required VoidCallback? onReply,
  required Function(String emoji) onReaction,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
  VoidCallback? onCopy,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return MessageActionOverlay(
          message: message,
          isMe: isMe,
          messageWidget: messageWidget,
          messagePosition: messagePosition,
          onReply: onReply,
          onReaction: onReaction,
          onEdit: onEdit,
          onDelete: onDelete,
          onCopy: onCopy,
        );
      },
    ),
  );
}
