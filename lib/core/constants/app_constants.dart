class AppConstants {
  // ============================================================================
  // Network Timeouts
  // ============================================================================
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration reconnectDelay = Duration(seconds: 3);
  static const int maxReconnectAttempts = 5;


  /// Interval for sending heartbeat to keep WebSocket connection alive
  /// Backend timeout is 30s, so we send every 15s to be safe
  static const Duration heartbeatInterval = Duration(seconds: 15);

  /// Grace period for showing user as "online" after they go offline
  /// User is considered online if lastSeen < this duration
  static const Duration onlineGracePeriod = Duration(seconds: 30);

  /// Polling interval when WebSocket is disconnected (fast polling)
  /// Used as backup to fetch fresh data from API
  static const Duration fastPollingInterval = Duration(seconds: 10);

  /// Polling interval when WebSocket is connected (slow polling)
  /// Used as backup to sync data periodically
  static const Duration slowPollingInterval = Duration(seconds: 60);

  /// UI refresh interval to update time-based displays
  /// Updates "2m ago" → "3m ago", online badges, etc.
  static const Duration uiRefreshInterval = Duration(seconds: 60);

  static const String contentTypeJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
