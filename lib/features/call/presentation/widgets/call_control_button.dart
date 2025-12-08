import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernCallButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool isDestructive;

  const ModernCallButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
    this.activeColor,
    this.inactiveColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDestructive
        ? const Color(0xFFFF3B30)
        : isActive
        ? (activeColor ?? const Color(0xFF2C2C2E))
        : (inactiveColor ?? const Color(0xFFF2F2F7));

    final iconColor = isDestructive
        ? Colors.white
        : isActive
        ? Colors.white
        : Colors.black;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: isDestructive
                  ? [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))]
                  : [],
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
