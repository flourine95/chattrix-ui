import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:flutter/material.dart';

/// Widget to display typing indicator with animated dots
class TypingIndicatorWidget extends StatelessWidget {
  final List<TypingUser> typingUsers;

  const TypingIndicatorWidget({
    super.key,
    required this.typingUsers,
  });

  /// Generate typing text based on number of users
  String _getTypingText() {
    if (typingUsers.isEmpty) return '';

    if (typingUsers.length == 1) {
      return '${typingUsers[0].fullName} is typing';
    } else if (typingUsers.length == 2) {
      return '${typingUsers[0].fullName} and ${typingUsers[1].fullName} are typing';
    } else {
      return '${typingUsers[0].fullName} and ${typingUsers.length - 1} others are typing';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (typingUsers.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colors.onSurface.withOpacity(0.6),
          fontStyle: FontStyle.italic,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: colors.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(_getTypingText(), style: textStyle),
          const SizedBox(width: 4),
          const TypingDotsAnimation(),
        ],
      ),
    );
  }
}

/// Animated dots for typing indicator
class TypingDotsAnimation extends StatefulWidget {
  final Color? color;
  final double dotSize;

  const TypingDotsAnimation({
    super.key,
    this.color,
    this.dotSize = 4,
  });

  @override
  State<TypingDotsAnimation> createState() => _TypingDotsAnimationState();
}

class _TypingDotsAnimationState extends State<TypingDotsAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(color, 0),
            const SizedBox(width: 3),
            _buildDot(color, 1),
            const SizedBox(width: 3),
            _buildDot(color, 2),
          ],
        );
      },
    );
  }

  Widget _buildDot(Color color, int index) {
    // Calculate opacity based on animation progress
    // Each dot animates with a delay
    final delay = index * 0.2;
    final progress = (_controller.value + delay) % 1.0;

    // Fade in and out
    double opacity;
    if (progress < 0.5) {
      opacity = progress * 2; // Fade in
    } else {
      opacity = 2 - (progress * 2); // Fade out
    }

    opacity = opacity.clamp(0.2, 1.0);

    return Container(
      width: widget.dotSize,
      height: widget.dotSize,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}

