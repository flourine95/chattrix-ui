import 'package:chattrix_ui/core/services/online_status_cache.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';

/// Extension to check online status for User, Contact, and Participant
/// 
/// Since `online` field is removed from entities, we use OnlineStatusCache
extension UserOnlineExtension on User {
  /// Check if this user is online
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(id);
  }

  /// Check if this user is online (with fallback to lastSeen)
  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();
    
    // First check cache
    if (cache.isOnline(id)) return true;
    
    // Fallback: Calculate from lastSeen (< 60s = online)
    return cache.isOnlineFromLastSeen(lastSeen);
  }
}

extension ContactOnlineExtension on Contact {
  /// Check if this contact is online
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(contactUserId);
  }

  /// Check if this contact is online (with fallback to lastSeen)
  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();
    
    // First check cache
    if (cache.isOnline(contactUserId)) return true;
    
    // Fallback: Calculate from lastSeen (< 60s = online)
    return cache.isOnlineFromLastSeen(lastSeen);
  }
}

extension ParticipantOnlineExtension on Participant {
  /// Check if this participant is online
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(userId);
  }

  /// Check if this participant is online (with fallback to lastSeen)
  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();
    
    // First check cache
    if (cache.isOnline(userId)) return true;
    
    // Fallback: Calculate from lastSeen (< 60s = online)
    return cache.isOnlineFromLastSeen(lastSeen);
  }
}
