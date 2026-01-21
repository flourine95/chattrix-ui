import 'package:chattrix_ui/core/services/online_status_cache.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';

/// Extension to check online status for User, Contact, and Participant
extension UserOnlineExtension on User {
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(id);
  }

  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();

    if (cache.hasStatus(id)) {
      if (cache.isOnline(id)) {
        return true;
      }

      final cachedLastSeen = cache.getLastSeen(id);
      if (cachedLastSeen != null) {
        return cache.isOnlineFromLastSeen(cachedLastSeen);
      }

      return false;
    }

    final cachedLastSeen = cache.getLastSeen(id);
    if (cachedLastSeen != null) {
      return cache.isOnlineFromLastSeen(cachedLastSeen);
    }

    if (lastSeen != null) {
      return cache.isOnlineFromLastSeen(lastSeen!);
    }

    return false;
  }
}

extension ContactOnlineExtension on Contact {
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(contactUserId);
  }

  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();

    if (cache.hasStatus(contactUserId)) {
      if (cache.isOnline(contactUserId)) {
        return true;
      }

      final cachedLastSeen = cache.getLastSeen(contactUserId);
      if (cachedLastSeen != null) {
        return cache.isOnlineFromLastSeen(cachedLastSeen);
      }

      return false;
    }

    final cachedLastSeen = cache.getLastSeen(contactUserId);
    if (cachedLastSeen != null) {
      return cache.isOnlineFromLastSeen(cachedLastSeen);
    }

    if (lastSeen != null) {
      return cache.isOnlineFromLastSeen(lastSeen!);
    }

    return false;
  }
}

extension ParticipantOnlineExtension on Participant {
  bool get isOnline {
    final cache = OnlineStatusCache();
    return cache.isOnline(userId);
  }

  bool get isOnlineWithFallback {
    final cache = OnlineStatusCache();

    if (cache.hasStatus(userId)) {
      if (cache.isOnline(userId)) {
        return true;
      }

      final cachedLastSeen = cache.getLastSeen(userId);
      if (cachedLastSeen != null) {
        return cache.isOnlineFromLastSeen(cachedLastSeen);
      }

      return false;
    }

    final cachedLastSeen = cache.getLastSeen(userId);
    if (cachedLastSeen != null) {
      return cache.isOnlineFromLastSeen(cachedLastSeen);
    }

    if (lastSeen != null) {
      return cache.isOnlineFromLastSeen(lastSeen!);
    }

    return false;
  }
}
