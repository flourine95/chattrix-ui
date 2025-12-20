import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';

/// Messenger-style typing indicator widget
/// Shows animated dots when users are typing
class TypingIndicatorWidget extends StatefulWidget {
  final TypingIndicator typingIndicator;
  final int? currentUserId;

  const TypingIndicatorWidget({super.key, required this.typingIndicator, this.currentUserId});

  @override
  State<TypingIndicatorWidget> createState() => _TypingIndicatorWidgetState();
}

class _TypingIndicatorWidgetState extends State<TypingIndicatorWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getTypingText() {
    final typingUsers = widget.typingIndicator.typingUsers
        .where((user) => user.id != widget.currentUserId?.toString())
        .toList();

    if (typingUsers.isEmpty) return '';

    if (typingUsers.length == 1) {
      return '${typingUsers.first.fullName} is typing';
    } else if (typingUsers.length == 2) {
      return '${typingUsers[0].fullName} and ${typingUsers[1].fullName} are typing';
    } else {
      return '${typingUsers[0].fullName} and ${typingUsers.length - 1} others are typing';
    }
  }

  @override
  Widget build(BuildContext context) {
    final typingUsers = widget.typingIndicator.typingUsers
        .where((user) => user.id != widget.currentUserId?.toString())
        .toList();

    if (typingUsers.isEmpty) {
      return const SizedBox.shrink();
    }

    debugPrint('👁️ [Typing Widget] Showing typing indicator for ${typingUsers.length} user(s)');

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 16, bottom: 8),
      child: Row(
        children: [
          // Animated typing dots
          _TypingDots(controller: _controller, isDark: isDark),
          const SizedBox(width: 8),
          // Typing text
          Flexible(
            child: Text(
              _getTypingText(),
              style: TextStyle(color: textColor, fontSize: 13, fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated typing dots (Messenger-style)
class _TypingDots extends StatelessWidget {
  final AnimationController controller;
  final bool isDark;

  const _TypingDots({required this.controller, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final dotColor = isDark ? Colors.white70 : Colors.black54;

    return SizedBox(
      width: 40,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              // Stagger the animation for each dot
              final delay = index * 0.2;
              final value = (controller.value - delay).clamp(0.0, 1.0);

              // Create a bounce effect
              final scale = 1.0 + (0.5 * (1.0 - (value * 2 - 1).abs()));

              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
