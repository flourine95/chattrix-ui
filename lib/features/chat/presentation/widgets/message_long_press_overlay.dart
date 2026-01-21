import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageLongPressOverlay extends HookWidget {
  const MessageLongPressOverlay({
    super.key,
    required this.message,
    required this.messageKey,
    required this.isMe,
    required this.onReply,
    required this.onAddReaction,
    required this.onEdit,
    required this.onDelete,
    required this.onQuickReaction,
    required this.canEdit,
    this.onPin,
    this.onForward,
  });

  final Message message;
  final GlobalKey messageKey;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onAddReaction;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Function(String emoji) onQuickReaction;
  final bool canEdit;
  final VoidCallback? onPin;
  final VoidCallback? onForward;

  static const List<String> _quickEmojis = ['👍', '❤️', '😂', '😮', '😢', '🔥'];

  @override
  Widget build(BuildContext context) {
    // Use hooks for animation controller
    final animationController = useAnimationController(duration: const Duration(milliseconds: 200));
    
    final scaleAnimation = useMemoized(
      () => CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
      [animationController],
    );
    
    final fadeAnimation = useMemoized(
      () => CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      [animationController],
    );

    // Auto-start animation on mount
    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    void close() {
      FocusScope.of(context).unfocus();
      animationController.reverse().then((_) {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    void handleQuickReaction(String emoji) {
      Navigator.of(context).pop();
      onQuickReaction(emoji);
    }

    void handleAction(VoidCallback? action) {
      if (action != null) {
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 100), () {
          action();
        });
      }
    }

    void handleCopy() {
      String textToCopy = '';

      // Determine what to copy based on message type
      switch (message.type.toUpperCase()) {
        case 'TEXT':
          textToCopy = message.content;
          break;
        case 'EMOJI':
          textToCopy = message.content;
          break;
        case 'FILE':
        case 'DOCUMENT':
          textToCopy = message.fileName ?? message.content;
          break;
        case 'LOCATION':
          textToCopy = message.locationName ?? 'Location: ${message.latitude}, ${message.longitude}';
          break;
        default:
          textToCopy = message.content;
      }

      if (textToCopy.isNotEmpty) {
        Clipboard.setData(ClipboardData(text: textToCopy));
        Navigator.of(context).pop();

        // Show toast
        if (context.mounted) {
          AppToast.success(context, title: 'Copied to clipboard');
        }
      }
    }

    void handleMoreReactions() {
      Navigator.of(context).pop();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (onAddReaction != null) {
          onAddReaction!();
        }
      });
    }

    final RenderBox? renderBox = messageKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      return const SizedBox.shrink();
    }

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    final emojiBarWidth = 280.0;
    final emojiBarHeight = 56.0;
    final padding = 16.0;
    final spacing = 12.0;

    double emojiBarLeft;
    if (isMe) {
      emojiBarLeft = position.dx + size.width - emojiBarWidth;
      if (emojiBarLeft < padding) emojiBarLeft = padding;
    } else {
      emojiBarLeft = position.dx;
      if (emojiBarLeft + emojiBarWidth > screenSize.width - padding) {
        emojiBarLeft = screenSize.width - emojiBarWidth - padding;
      }
    }

    final spaceAbove = position.dy;
    final spaceBelow = screenSize.height - (position.dy + size.height);

    double emojiBarTop;
    if (spaceAbove >= emojiBarHeight + spacing + padding) {
      emojiBarTop = position.dy - emojiBarHeight - spacing;
    } else if (spaceBelow >= emojiBarHeight + spacing + padding) {
      emojiBarTop = position.dy + size.height + spacing;
    } else {
      emojiBarTop = padding;
    }

    if (emojiBarTop < padding) emojiBarTop = padding;
    if (emojiBarTop + emojiBarHeight > screenSize.height - padding) {
      emojiBarTop = screenSize.height - emojiBarHeight - padding;
    }

    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(onTap: close, behavior: HitTestBehavior.translucent),
          ),
          Positioned(
            left: emojiBarLeft,
            top: emojiBarTop,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: _EmojiBar(emojis: _quickEmojis, onEmojiTap: handleQuickReaction),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut)),
              child: _ActionBar(
                onReply: onReply != null ? () => handleAction(onReply) : null,
                onCopy: handleCopy,
                onEdit: canEdit && onEdit != null ? () => handleAction(onEdit) : null,
                onPin: onPin != null ? () => handleAction(onPin) : null,
                onForward: onForward != null ? () => handleAction(onForward) : null,
                onDelete: isMe && onDelete != null ? () => handleAction(onDelete) : null,
                onMoreReactions: onAddReaction != null ? handleMoreReactions : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmojiBar extends StatelessWidget {
  const _EmojiBar({required this.emojis, required this.onEmojiTap});

  final List<String> emojis;
  final Function(String emoji) onEmojiTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: emojis.map((emoji) {
            return _EmojiButton(emoji: emoji, onTap: () => onEmojiTap(emoji));
          }).toList(),
        ),
      ),
    );
  }
}

/// Emoji button with scale animation on tap
class _EmojiButton extends HookWidget {
  const _EmojiButton({required this.emoji, required this.onTap});

  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(milliseconds: 100));
    
    final scaleAnimation = useMemoized(
      () => Tween<double>(begin: 1.0, end: 1.3).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
      [controller],
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTapDown: (_) => controller.forward(),
        onTapUp: (_) {
          controller.reverse();
          onTap();
        },
        onTapCancel: () => controller.reverse(),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Text(
              emoji,
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'NotoColorEmoji',
                fontFamilyFallback: ['Segoe UI Emoji', 'Apple Color Emoji'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.onReply,
    required this.onCopy,
    required this.onEdit,
    required this.onPin,
    required this.onForward,
    required this.onDelete,
    required this.onMoreReactions,
  });

  final VoidCallback? onReply;
  final VoidCallback? onCopy;
  final VoidCallback? onEdit;
  final VoidCallback? onPin;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;
  final VoidCallback? onMoreReactions;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final actions = <Widget>[];

    if (onReply != null) {
      actions.add(
        _ActionButton(icon: Icons.reply, label: 'Reply', onTap: onReply!, textTheme: textTheme, colors: colors),
      );
    }

    if (onCopy != null) {
      actions.add(_ActionButton(icon: Icons.copy, label: 'Copy', onTap: onCopy!, textTheme: textTheme, colors: colors));
    }

    if (onForward != null) {
      actions.add(
        _ActionButton(icon: Icons.forward, label: 'Forward', onTap: onForward!, textTheme: textTheme, colors: colors),
      );
    }

    if (onEdit != null) {
      actions.add(_ActionButton(icon: Icons.edit, label: 'Edit', onTap: onEdit!, textTheme: textTheme, colors: colors));
    }

    if (onPin != null) {
      actions.add(
        _ActionButton(icon: Icons.push_pin, label: 'Pin', onTap: onPin!, textTheme: textTheme, colors: colors),
      );
    }

    if (onMoreReactions != null) {
      actions.add(
        _ActionButton(
          icon: Icons.add_reaction_outlined,
          label: 'More',
          onTap: onMoreReactions!,
          textTheme: textTheme,
          colors: colors,
        ),
      );
    }

    if (onDelete != null) {
      actions.add(
        _ActionButton(
          icon: Icons.delete,
          label: 'Delete',
          onTap: onDelete!,
          textTheme: textTheme,
          colors: colors,
          isDestructive: true,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: actions),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.textTheme,
    required this.colors,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final TextTheme textTheme;
  final ColorScheme colors;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : colors.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

void showMessageLongPressOverlay({
  required BuildContext context,
  required Message message,
  required GlobalKey messageKey,
  required bool isMe,
  VoidCallback? onReply,
  VoidCallback? onAddReaction,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
  VoidCallback? onForward,
  required Function(String emoji) onQuickReaction,
  required bool canEdit,
  VoidCallback? onPin,
}) {
  FocusScope.of(context).unfocus();
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    useSafeArea: false,
    builder: (context) => MessageLongPressOverlay(
      message: message,
      messageKey: messageKey,
      isMe: isMe,
      onReply: onReply,
      onAddReaction: onAddReaction,
      onEdit: onEdit,
      onDelete: onDelete,
      onForward: onForward,
      onQuickReaction: onQuickReaction,
      canEdit: canEdit,
      onPin: onPin,
    ),
  );
}
