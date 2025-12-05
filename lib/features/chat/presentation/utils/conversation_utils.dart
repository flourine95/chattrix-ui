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
    if (conversation.type.toUpperCase() == 'GROUP') {
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
    if (currentUser != null && lastMessage.sender.id == currentUser.id) {
      return 'You: $content';
    }

    return content;
  }

  /// Format time ago from DateTime
  ///
  /// Examples:
  /// - "Just now"
  /// - "5 minutes ago"
  /// - "2 hours ago"
  /// - "3 days ago"
  /// - "1 week ago"
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Format last seen status
  ///
  /// Examples:
  /// - "Active now" (if online)
  /// - "Active 5 minutes ago"
  /// - "Active 2 hours ago"
  static String formatLastSeen(bool isOnline, DateTime? lastSeen) {
    if (isOnline) {
      return 'Active now';
    }

    if (lastSeen == null) {
      return 'Offline';
    }

    return 'Active ${formatTimeAgo(lastSeen)}';
  }

  /// Get other participant in DIRECT conversation
  static Participant? getOtherParticipant(Conversation conversation, User? currentUser) {
    if (conversation.type.toUpperCase() != 'DIRECT') {
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
    return otherParticipant?.isOnline ?? false;
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
      email: '', // Not available in Participant
      fullName: otherParticipant.fullName,
      avatarUrl: null, // Not available in Participant
      isOnline: otherParticipant.isOnline ?? false,
      lastSeen: otherParticipant.lastSeen ?? DateTime.now(),
    );
  }
}
