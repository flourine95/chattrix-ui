import 'package:flutter/material.dart';

class CallControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isActive;
  final double size;

  const CallControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.isActive = false,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        (isActive
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.2));
    final fgColor = iconColor ?? Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (backgroundColor ?? Colors.white)
                      .withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: fgColor,
              size: size * 0.45,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: fgColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

