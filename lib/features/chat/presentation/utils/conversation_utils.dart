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
      final otherParticipants = conversation.participants
          .where((p) => p.userId != currentUser?.id)
          .take(3)
          .toList();
      
      if (otherParticipants.isEmpty) {
        return 'Group Chat';
      }
      
      return otherParticipants
          .map((p) => p.fullName.isNotEmpty ? p.fullName : p.username)
          .join(', ');
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
  /// - If message is from current user, add "Bạn: " prefix
  /// - If message is image, show "📷 Ảnh"
  /// - If message is file, show "📎 Tệp"
  /// - Otherwise show content
  static String formatLastMessage(Message? lastMessage, User? currentUser) {
    if (lastMessage == null) {
      return 'No messages yet';
    }
    
    String content;
    
    // Check message type
    if (lastMessage.type.toUpperCase() == 'IMAGE') {
      content = '📷 Ảnh';
    } else if (lastMessage.type.toUpperCase() == 'FILE') {
      content = '📎 Tệp';
    } else {
      content = lastMessage.content;
    }
    
    // Add "Bạn: " prefix if message is from current user
    if (currentUser != null && lastMessage.sender.id == currentUser.id) {
      return 'Bạn: $content';
    }
    
    return content;
  }

  /// Format time ago from DateTime
  /// 
  /// Examples:
  /// - "Vừa xong" (just now)
  /// - "5 phút trước"
  /// - "2 giờ trước"
  /// - "3 ngày trước"
  /// - "1 tuần trước"
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years năm trước';
    }
  }

  /// Format last seen status
  /// 
  /// Examples:
  /// - "Đang hoạt động" (if online)
  /// - "Hoạt động 5 phút trước"
  /// - "Hoạt động 2 giờ trước"
  static String formatLastSeen(bool isOnline, DateTime? lastSeen) {
    if (isOnline) {
      return 'Đang hoạt động';
    }
    
    if (lastSeen == null) {
      return 'Offline';
    }
    
    return 'Hoạt động ${formatTimeAgo(lastSeen)}';
  }

  /// Get other participant in DIRECT conversation
  static Participant? getOtherParticipant(Conversation conversation, User? currentUser) {
    if (conversation.type.toUpperCase() != 'DIRECT') {
      return null;
    }
    
    try {
      return conversation.participants.firstWhere(
        (p) => p.userId != currentUser?.id,
      );
    } catch (e) {
      return conversation.participants.isNotEmpty ? conversation.participants.first : null;
    }
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
}

