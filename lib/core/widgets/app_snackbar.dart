import 'package:flutter/material.dart';

/// Modern SnackBar helpers for consistent notifications across the app
/// 
/// Usage:
/// ```dart
/// AppSnackBar.success(context, 'Operation successful!');
/// AppSnackBar.error(context, 'Something went wrong');
/// AppSnackBar.info(context, 'New message received');
/// ```
class AppSnackBar {
  /// Show success SnackBar (green)
  static void success(BuildContext context, String message, {String? subtitle}) {
    _show(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.check_circle,
      backgroundColor: Colors.green.shade600,
      duration: const Duration(seconds: 2),
    );
  }

  /// Show error SnackBar (red)
  static void error(BuildContext context, String message, {String? subtitle}) {
    _show(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.error_outline,
      backgroundColor: Colors.red.shade600,
      duration: const Duration(seconds: 4),
    );
  }

  /// Show warning SnackBar (orange)
  static void warning(BuildContext context, String message, {String? subtitle}) {
    _show(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.warning_amber_rounded,
      backgroundColor: Colors.orange.shade700,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show info SnackBar (blue)
  static void info(BuildContext context, String message, {String? subtitle}) {
    _show(
      context,
      message: message,
      subtitle: subtitle,
      icon: Icons.info_outline,
      backgroundColor: Colors.blue.shade600,
      duration: const Duration(seconds: 3),
    );
  }

  /// Internal method to show SnackBar with consistent styling
  static void _show(
    BuildContext context, {
    required String message,
    String? subtitle,
    required IconData icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: subtitle != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration,
      ),
    );
  }
}
