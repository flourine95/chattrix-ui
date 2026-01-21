import 'package:chattrix_ui/core/constants/app_constants.dart';

/// Service to cache online status of users in memory
///
/// Backend no longer provides `online` field in User entity.
/// Instead, online status is tracked via WebSocket events:
/// - `user.status` events for real-time updates
/// - Fallback: Calculate from `lastSeen` (< 60s = online)
class OnlineStatusCache {
  // Singleton pattern
  static final OnlineStatusCache _instance = OnlineStatusCache._internal();

  factory OnlineStatusCache() => _instance;

  OnlineStatusCache._internal();

  /// Map of userId -> online status
  final Map<int, bool> _onlineStatus = {};

  /// Map of userId -> lastSeen timestamp
  final Map<int, DateTime> _lastSeen = {};

  /// Get online status for a user
  ///
  /// Returns:
  /// - true if user is in online cache
  /// - false if user is offline or not in cache
  bool isOnline(int userId) {
    return _onlineStatus[userId] ?? false;
  }

  /// Check if we have explicit status for a user
  ///
  /// Returns:
  /// - true if user status has been set (either online or offline)
  /// - false if user status has never been set
  bool hasStatus(int userId) {
    return _onlineStatus.containsKey(userId);
  }

  /// Set user online status
  void setOnline(int userId, {DateTime? lastSeen}) {
    _onlineStatus[userId] = true;
    if (lastSeen != null) {
      _lastSeen[userId] = lastSeen;
    }
  }

  /// Set user offline status
  void setOffline(int userId, {DateTime? lastSeen}) {
    _onlineStatus[userId] = false;
    if (lastSeen != null) {
      _lastSeen[userId] = lastSeen;
    }
  }

  /// Update user status from WebSocket event
  void updateStatus(int userId, bool online, {DateTime? lastSeen}) {
    if (online) {
      setOnline(userId, lastSeen: lastSeen);
    } else {
      setOffline(userId, lastSeen: lastSeen);
    }
  }

  /// Calculate online status from lastSeen timestamp
  ///
  /// User is considered online if lastSeen < grace period (configured in AppConstants)
  ///
  /// Grace period: Configurable via AppConstants.onlineGracePeriod
  bool isOnlineFromLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return false;

    final now = DateTime.now();
    final secondsAgo = now.difference(lastSeen).inSeconds;
    final gracePeriodSeconds = AppConstants.onlineGracePeriod.inSeconds;
    final isOnline = secondsAgo < gracePeriodSeconds;

    return isOnline;
  }

  /// Get last seen timestamp for a user
  DateTime? getLastSeen(int userId) {
    return _lastSeen[userId];
  }

  /// Update last seen timestamp
  void updateLastSeen(int userId, DateTime lastSeen) {
    _lastSeen[userId] = lastSeen;
  }

  /// Get all online user IDs
  List<int> getOnlineUserIds() {
    return _onlineStatus.entries.where((entry) => entry.value == true).map((entry) => entry.key).toList();
  }

  /// Get count of online users
  int getOnlineCount() {
    return _onlineStatus.values.where((online) => online).length;
  }

  /// Clear all cached data
  void clear() {
    _onlineStatus.clear();
    _lastSeen.clear();
  }

  /// Remove specific user from cache
  void remove(int userId) {
    _onlineStatus.remove(userId);
    _lastSeen.remove(userId);
  }

  /// Bulk update online status (e.g., from initial API load)
  void bulkUpdate(Map<int, bool> statusMap) {
    _onlineStatus.addAll(statusMap);
  }
}
