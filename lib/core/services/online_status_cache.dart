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

  /// Set user online status
  void setOnline(int userId, {DateTime? lastSeen}) {
    _onlineStatus[userId] = true;
    if (lastSeen != null) {
      _lastSeen[userId] = lastSeen;
    }
    // debugPrint('✅ [OnlineCache] User $userId is now ONLINE');
  }

  /// Set user offline status
  void setOffline(int userId, {DateTime? lastSeen}) {
    _onlineStatus[userId] = false;
    if (lastSeen != null) {
      _lastSeen[userId] = lastSeen;
    }
    // debugPrint('❌ [OnlineCache] User $userId is now OFFLINE');
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
  /// User is considered online if lastSeen < 60 seconds ago
  bool isOnlineFromLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return false;

    final secondsAgo = DateTime.now().difference(lastSeen).inSeconds;
    return secondsAgo < 60;
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
    return _onlineStatus.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
  }

  /// Get count of online users
  int getOnlineCount() {
    return _onlineStatus.values.where((online) => online).length;
  }

  /// Clear all cached data
  void clear() {
    _onlineStatus.clear();
    _lastSeen.clear();
    // debugPrint('🧹 [OnlineCache] Cleared all cached data');
  }

  /// Remove specific user from cache
  void remove(int userId) {
    _onlineStatus.remove(userId);
    _lastSeen.remove(userId);
    // debugPrint('🗑️ [OnlineCache] Removed user $userId from cache');
  }

  /// Bulk update online status (e.g., from initial API load)
  void bulkUpdate(Map<int, bool> statusMap) {
    _onlineStatus.addAll(statusMap);
    // debugPrint('📦 [OnlineCache] Bulk updated ${statusMap.length} users');
  }

  /// Debug: Print current cache state
  void printDebugInfo() {
    // debugPrint('📊 [OnlineCache] Current state:');
    // debugPrint('   Online users: ${getOnlineCount()}');
    // debugPrint('   Total cached: ${_onlineStatus.length}');
    // debugPrint('   Online IDs: ${getOnlineUserIds()}');
  }
}
