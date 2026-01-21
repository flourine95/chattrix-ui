import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Custom toast helper matching Chattrix UI Design System
/// 
/// Design specs from UI_DESIGN_GLOSSARY.md:
/// - Minimal, clean design
/// - Solid background colors (not transparent)
/// - Border radius: 12px (consistent with cards)
/// - Font: Inter (from Google Fonts)
/// - Auto-dismiss: 3-5 seconds
/// - Position: Top-right
/// - Animation: Slide from right with fade
class AppToast {
  AppToast._();

  /// Show a success toast
  /// Background: Green (#31A24C from design system)
  static ToastificationItem success(
    BuildContext context, {
    required String title,
    String? description,
    Duration? autoCloseDuration,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      description: description != null
          ? Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            )
          : null,
      alignment: Alignment.topRight,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: 22,
      ),
      primaryColor: const Color(0xFF31A24C), // Success green from design system
      backgroundColor: const Color(0xFF31A24C), // Solid background
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, right: 12),
      borderRadius: BorderRadius.circular(12), // Consistent with cards
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  /// Show an error toast
  /// Background: Red (#EF5350 from design system)
  static ToastificationItem error(
    BuildContext context, {
    required String title,
    String? description,
    Duration? autoCloseDuration,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      description: description != null
          ? Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            )
          : null,
      alignment: Alignment.topRight,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 4),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 22,
      ),
      primaryColor: const Color(0xFFEF5350), // Error red from design system
      backgroundColor: const Color(0xFFEF5350), // Solid background
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, right: 12),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  /// Show a warning toast
  /// Background: Amber (#FFCA28 from design system)
  static ToastificationItem warning(
    BuildContext context, {
    required String title,
    String? description,
    Duration? autoCloseDuration,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      description: description != null
          ? Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            )
          : null,
      alignment: Alignment.topRight,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.black87,
        size: 22,
      ),
      primaryColor: const Color(0xFFFFCA28), // Warning amber from design system
      backgroundColor: const Color(0xFFFFCA28), // Solid background
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, right: 12),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  /// Show an info toast
  /// Background: Blue (#29B6F6 from design system)
  static ToastificationItem info(
    BuildContext context, {
    required String title,
    String? description,
    Duration? autoCloseDuration,
  }) {
    return toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      description: description != null
          ? Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            )
          : null,
      alignment: Alignment.topRight,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 22,
      ),
      primaryColor: const Color(0xFF29B6F6), // Info blue from design system
      backgroundColor: const Color(0xFF29B6F6), // Solid background
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, right: 12),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  /// Show a custom toast with full control
  static ToastificationItem custom(
    BuildContext context, {
    required String title,
    String? description,
    required Color backgroundColor,
    Color? foregroundColor,
    IconData? icon,
    Duration? autoCloseDuration,
  }) {
    final textColor = foregroundColor ?? Colors.white;
    
    return toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      description: description != null
          ? Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: textColor.withValues(alpha: 0.9),
              ),
            )
          : null,
      alignment: Alignment.topRight,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
      icon: icon != null
          ? Icon(
              icon,
              color: textColor,
              size: 22,
            )
          : null,
      primaryColor: backgroundColor,
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 12, right: 12),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
    );
  }

  /// Dismiss a specific toast
  static void dismiss(ToastificationItem item) {
    toastification.dismiss(item);
  }

  /// Dismiss all toasts
  static void dismissAll() {
    toastification.dismissAll();
  }
}
