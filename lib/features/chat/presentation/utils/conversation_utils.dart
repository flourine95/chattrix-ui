import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';

/// Utility functions for conversation display logic
class ConversationUtils {
  /// Get conversation title based on type and participants
  ///
  /// Rules:
  /// - GROUP: Use conversation.name if available, otherwise combine participant names (max 3)
  /// - DIRECT: Use contact.nickname → contactUser.fullName → contactUser.username (priority order)
  static String getConversationTitle(Conversation conversation, User? currentUser) {
    if (conversation.type == ConversationType.group) {
      // For GROUP conversations
      if (conversation.name != null && conversation.name!.isNotEmpty) {
        return conversation.name!;
      }

      // Fallback: combine participant names (max 3)
      final otherParticipants = conversation.participants.where((p) => p.userId != currentUser?.id).take(3).toList();

      if (otherParticipants.isEmpty) {
        return 'Group Chat';
      }

      return otherParticipants.map((p) => p.fullName.isNotEmpty ? p.fullName : p.username).join(', ');
    } else {
      // For DIRECT conversations
      final otherParticipant = conversation.participants.firstWhere(
        (p) => p.userId != currentUser?.id,
        orElse: () => conversation.participants.first,
      );

      // Priority: nickname → fullName → username
      if (otherParticipant.nickname != null && otherParticipant.nickname!.isNotEmpty) {
        return otherParticipant.nickname!;
      }

      if (otherParticipant.fullName.isNotEmpty) {
        return otherParticipant.fullName;
      }

      return otherParticipant.username;
    }
  }

  /// Format last message for display in conversation list
  ///
  /// Rules:
  /// - If message is from current user, add "You: " prefix
  /// - If message is image, show "📷 Photo"
  /// - If message is file, show "📎 File"
  /// - Otherwise show content
  static String formatLastMessage(Message? lastMessage, User? currentUser) {
    if (lastMessage == null) {
      return 'No messages yet';
    }

    String content;

    // Check message type
    if (lastMessage.type.toUpperCase() == 'IMAGE') {
      content = '📷 Photo';
    } else if (lastMessage.type.toUpperCase() == 'FILE') {
      content = '📎 File';
    } else {
      content = lastMessage.content;
    }

    // Add "You: " prefix if message is from current user
    if (currentUser != null && lastMessage.senderId == currentUser.id) {
      return 'You: $content';
    }

    return content;
  }

  /// Format time ago from DateTime for conversation list
  ///
  /// Rules (Requirements 11.1-11.5):
  /// - < 1 hour: relative time (e.g., "2m", "45m")
  /// - Today: time (e.g., "14:30")
  /// - Yesterday: "Yesterday"
  /// - This week: day name (e.g., "Mon", "Tue")
  /// - Earlier: date (e.g., "Dec 10")
  ///
  /// Examples:
  /// - "2m" (2 minutes ago)
  /// - "45m" (45 minutes ago)
  /// - "14:30" (today at 14:30)
  /// - "Yesterday"
  /// - "Mon" (this week)
  /// - "Dec 10" (earlier)
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // < 1 hour: relative time (e.g., "2m", "45m")
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      if (minutes < 1) {
        return '0m';
      }
      return '${minutes}m';
    }

    // Check if it's today
    final isToday = now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day;

    if (isToday) {
      // Today: time (e.g., "14:30")
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }

    // Check if it's yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday =
        yesterday.year == dateTime.year && yesterday.month == dateTime.month && yesterday.day == dateTime.day;

    if (isYesterday) {
      // Yesterday: "Yesterday"
      return 'Yesterday';
    }

    // Check if it's this week (within last 7 days)
    if (difference.inDays < 7) {
      // This week: day name (e.g., "Mon", "Tue")
      const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      // DateTime.weekday returns 1-7 (Monday-Sunday)
      return dayNames[dateTime.weekday - 1];
    }

    // Earlier: date (e.g., "Dec 10")
    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = monthNames[dateTime.month - 1];
    final day = dateTime.day;
    return '$month $day';
  }

  /// Format last seen status
  ///
  /// Examples:
  /// - "Active now" (if online)
  /// - "Active 5 minutes ago"
  /// - "Active 2 hours ago"
  /// - "Active yesterday"
  /// - "Active on Dec 10"
  static String formatLastSeen(bool isOnline, DateTime? lastSeen) {
    if (isOnline) {
      return 'Active now';
    }

    // Debug: Check if lastSeen is null
    if (lastSeen == null) {
      // Backend chưa gửi lastSeen, hiển thị "Offline" thôi
      return 'Offline';
    }

    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    // < 1 minute: "Active just now"
    if (difference.inMinutes < 1) {
      return 'Active just now';
    }

    // < 1 hour: "Active X minutes ago"
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return 'Active $minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    }

    // < 24 hours: "Active X hours ago"
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return 'Active $hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday =
        yesterday.year == lastSeen.year && yesterday.month == lastSeen.month && yesterday.day == lastSeen.day;

    if (isYesterday) {
      return 'Active yesterday';
    }

    // < 7 days: "Active on Monday"
    if (difference.inDays < 7) {
      const dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      return 'Active on ${dayNames[lastSeen.weekday - 1]}';
    }

    // Older: "Active on Dec 10"
    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = monthNames[lastSeen.month - 1];
    final day = lastSeen.day;
    return 'Active on $month $day';
  }

  /// Get other participant in DIRECT conversation
  static Participant? getOtherParticipant(Conversation conversation, User? currentUser) {
    if (conversation.type != ConversationType.direct) {
      return null;
    }

    try {
      return conversation.participants.firstWhere((p) => p.userId != currentUser?.id);
    } catch (e) {
      return conversation.participants.isNotEmpty ? conversation.participants.first : null;
    }
  }

  /// Get other participant's user ID in DIRECT conversation
  static String? getOtherParticipantId(Conversation? conversation, User? currentUser) {
    if (conversation == null) {
      return null;
    }

    final otherParticipant = getOtherParticipant(conversation, currentUser);
    return otherParticipant?.userId.toString();
  }

  /// Check if user is online in DIRECT conversation
  static bool isUserOnline(Conversation conversation, User? currentUser) {
    final otherParticipant = getOtherParticipant(conversation, currentUser);
    return otherParticipant?.online ?? false;
  }

  /// Get last seen of other user in DIRECT conversation
  static DateTime? getLastSeen(Conversation conversation, User? currentUser) {
    final otherParticipant = getOtherParticipant(conversation, currentUser);
    return otherParticipant?.lastSeen;
  }

  /// Get other user as User entity in DIRECT conversation
  /// Converts Participant to User for call functionality
  static User? getOtherUser(Conversation conversation, User? currentUser) {
    final otherParticipant = getOtherParticipant(conversation, currentUser);
    if (otherParticipant == null) {
      return null;
    }

    // Convert Participant to User
    return User(
      id: otherParticipant.userId,
      username: otherParticipant.username,
      email: otherParticipant.email ?? '', // Use participant email if available
      fullName: otherParticipant.fullName,
      avatarUrl: otherParticipant.avatarUrl, // Now available in Participant
      online: otherParticipant.online ?? false,
      lastSeen: otherParticipant.lastSeen,
      emailVerified: false, // Not available in Participant
      createdAt: DateTime.now(), // Not available in Participant
    );
  }

  /// Get avatar URL of other participant in DIRECT conversation
  /// Returns null for GROUP conversations or if no avatar is set
  static String? getOtherParticipantAvatarUrl(Conversation conversation, User? currentUser) {
    final otherParticipant = getOtherParticipant(conversation, currentUser);
    return otherParticipant?.avatarUrl;
  }

  /// Format last seen as short badge text (for avatar overlay)
  ///
  /// Examples:
  /// - "45m" (45 minutes ago)
  /// - "2h" (2 hours ago)
  /// - "3d" (3 days ago)
  /// - "1w" (1 week ago)
  /// - null (if online or > 1 week)
  static String? formatLastSeenBadge(bool isOnline, DateTime? lastSeen) {
    if (isOnline || lastSeen == null) {
      return null;
    }

    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    // < 1 hour: "Xm"
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      if (minutes < 1) return null; // Just now - don't show badge
      return '${minutes}m';
    }

    // < 24 hours: "Xh"
    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    }

    // < 7 days: "Xd"
    if (difference.inDays < 7) {
      return '${difference.inDays}d';
    }

    // < 4 weeks: "Xw"
    if (difference.inDays < 28) {
      return '${(difference.inDays / 7).floor()}w';
    }

    // > 4 weeks: don't show badge
    return null;
  }
}
