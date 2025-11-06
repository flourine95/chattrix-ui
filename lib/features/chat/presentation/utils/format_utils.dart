import 'package:flutter/material.dart';

/// Utility functions for formatting various data types
class FormatUtils {
  /// Format file size in bytes to human-readable format
  ///
  /// Examples:
  /// - 512 → "512 B"
  /// - 1536 → "1.5 KB"
  /// - 1048576 → "1.0 MB"
  /// - 1073741824 → "1.0 GB"
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Format duration in seconds to MM:SS format
  ///
  /// Examples:
  /// - 0 → "00:00"
  /// - 65 → "01:05"
  /// - 3661 → "61:01"
  static String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Format DateTime to dd/MM/yyyy HH:mm format
  ///
  /// Examples:
  /// - DateTime(2024, 1, 15, 14, 30) → "15/01/2024 14:30"
  static String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  /// Format DateTime to dd/MM/yyyy format
  ///
  /// Examples:
  /// - DateTime(2024, 1, 15) → "15/01/2024"
  static String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  }

  /// Format time ago from DateTime (simplified version)
  ///
  /// Examples:
  /// - "just now"
  /// - "5 minutes ago"
  /// - "2 hours ago"
  /// - "3 days ago"
  /// - "15/01/2024" (if more than 7 days)
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inDays < 1) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else {
      return formatDate(dateTime);
    }
  }

  /// Get text color based on theme and sender
  ///
  /// Returns appropriate text color for message bubbles based on:
  /// - Whether the message is from current user (isMe)
  /// - Current theme brightness (dark/light)
  static Color getTextColor(BuildContext context, bool isMe) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return isMe
        ? (isDark ? colors.onPrimary : Colors.black)
        : (isDark ? colors.onSurface : Colors.white);
  }
}

