import 'package:flutter/material.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';

/// Utility class for handling seen status display
class SeenStatusUtils {
  /// Get seen status text for a message
  ///
  /// Returns:
  /// - "Seen" for direct chats when read
  /// - "Seen by [Name]" for groups with 1 reader
  /// - "Seen by [Name] and [Name]" for groups with 2 readers
  /// - "Seen by [Name] and X others" for groups with 3+ readers
  /// - "Sent" when not read yet
  static String getSeenStatusText(Message message, bool isGroup) {
    if (message.readCount == 0) {
      return 'Sent';
    }

    if (!isGroup) {
      return 'Seen';
    }

    // Group chat
    if (message.readCount == 1) {
      final firstName = _getFirstName(message.readBy.first.fullName);
      return 'Seen by $firstName';
    } else if (message.readCount == 2) {
      final firstName1 = _getFirstName(message.readBy[0].fullName);
      final firstName2 = _getFirstName(message.readBy[1].fullName);
      return 'Seen by $firstName1 and $firstName2';
    } else {
      final firstName = _getFirstName(message.readBy.first.fullName);
      final othersCount = message.readCount - 1;
      return 'Seen by $firstName and $othersCount ${othersCount == 1 ? 'other' : 'others'}';
    }
  }

  /// Get compact seen status text for chat list
  ///
  /// Returns:
  /// - "Seen" for direct chats when read
  /// - "Seen by X" for groups
  /// - "Sent" when not read yet
  static String getCompactSeenStatusText(Message message, bool isGroup) {
    if (message.readCount == 0) {
      return 'Sent';
    }

    if (!isGroup) {
      return 'Seen';
    }

    // Group chat - show count
    return 'Seen by ${message.readCount}';
  }

  /// Get seen status icon
  ///
  /// Returns:
  /// - Icons.done_all (double check) when read
  /// - Icons.done (single check) when sent but not read
  static IconData getSeenStatusIcon(Message message) {
    return message.readCount > 0 ? Icons.done_all : Icons.done;
  }

  /// Get seen status color
  ///
  /// Returns:
  /// - Blue when read (seen)
  /// - Grey when sent but not read
  static Color getSeenStatusColor(Message message, bool isDark) {
    if (message.readCount > 0) {
      return Colors.blue; // Seen - blue checkmark
    }
    return isDark ? Colors.grey[400]! : Colors.grey[600]!; // Sent - grey checkmark
  }

  /// Extract first name from full name
  static String _getFirstName(String fullName) {
    final parts = fullName.trim().split(' ');
    return parts.first;
  }
}
