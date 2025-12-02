import 'package:flutter/foundation.dart';

/// Service for managing call security measures
///
/// Handles:
/// - Token lifecycle management
/// - Secure protocol verification
/// - Sensitive data cleanup
///
/// Requirements: 10.1, 10.2, 10.3, 10.5
class CallSecurityService {
  // In-memory storage for active call tokens
  // These are cleared when calls end
  final Map<String, String> _activeCallTokens = {};

  /// Stores an Agora token for an active call session
  ///
  /// Requirement 10.2: Use unique Agora token for each call session
  /// Tokens are stored in memory only and never persisted
  void storeCallToken(String callId, String agoraToken) {
    _activeCallTokens[callId] = agoraToken;
    debugPrint('CallSecurityService: Stored token for call $callId (length: ${agoraToken.length})');
  }

  /// Retrieves an Agora token for an active call
  ///
  /// Returns null if no token exists for the given call ID
  String? getCallToken(String callId) {
    return _activeCallTokens[callId];
  }

  /// Clears the Agora token for a specific call
  ///
  /// Requirement 10.3: Clear all tokens from memory when call ends
  /// This ensures tokens cannot be reused or leaked
  void clearCallToken(String callId) {
    final removed = _activeCallTokens.remove(callId);
    if (removed != null) {
      debugPrint('CallSecurityService: Cleared token for call $callId');
    }
  }

  /// Clears all stored call tokens
  ///
  /// Requirement 10.3: Clear all tokens from memory when call ends
  /// Used for cleanup when disposing the service or on logout
  void clearAllTokens() {
    final count = _activeCallTokens.length;
    _activeCallTokens.clear();
    debugPrint('CallSecurityService: Cleared all tokens ($count total)');
  }

  /// Verifies that a URL uses a secure protocol (HTTPS or WSS)
  ///
  /// Requirement 10.5: Verify HTTPS is used for all API calls
  /// Requirement 10.5: Verify WSS is used for WebSocket connection
  ///
  /// Returns true if the URL uses https:// or wss://
  /// Returns false for http:// or ws:// (insecure protocols)
  ///
  /// Note: In development, localhost connections may use http/ws
  bool isSecureProtocol(String url) {
    final uri = Uri.parse(url);
    final scheme = uri.scheme.toLowerCase();

    // Check for secure protocols
    final isSecure = scheme == 'https' || scheme == 'wss';

    // In development, allow localhost with insecure protocols
    if (!isSecure && kDebugMode) {
      final isLocalhost =
          uri.host == 'localhost' ||
          uri.host == '127.0.0.1' ||
          uri.host == '10.0.2.2' || // Android emulator
          uri.host == '0.0.0.0';

      if (isLocalhost) {
        debugPrint('CallSecurityService: WARNING - Using insecure protocol for localhost: $url');
        return true; // Allow in development
      }
    }

    if (!isSecure) {
      debugPrint('CallSecurityService: ERROR - Insecure protocol detected: $scheme in $url');
    }

    return isSecure;
  }

  /// Validates that API and WebSocket URLs use secure protocols
  ///
  /// Requirement 10.5: Verify HTTPS is used for all API calls
  /// Requirement 10.5: Verify WSS is used for WebSocket connection
  ///
  /// Throws an exception if insecure protocols are detected in production
  void validateSecureProtocols({required String apiBaseUrl, required String wsBaseUrl}) {
    final apiSecure = isSecureProtocol(apiBaseUrl);
    final wsSecure = isSecureProtocol(wsBaseUrl);

    // In production (release mode), enforce secure protocols
    if (!kDebugMode) {
      if (!apiSecure) {
        throw SecurityException('API must use HTTPS in production. Current URL: $apiBaseUrl');
      }
      if (!wsSecure) {
        throw SecurityException('WebSocket must use WSS in production. Current URL: $wsBaseUrl');
      }
    }

    // Log warnings in debug mode
    if (kDebugMode) {
      if (!apiSecure) {
        debugPrint('CallSecurityService: WARNING - API using insecure protocol: $apiBaseUrl');
      }
      if (!wsSecure) {
        debugPrint('CallSecurityService: WARNING - WebSocket using insecure protocol: $wsBaseUrl');
      }
    }
  }

  /// Sanitizes a token for logging purposes
  ///
  /// Returns a safe representation showing only the first and last 4 characters
  /// This prevents accidental token leakage in logs while still being useful for debugging
  ///
  /// Example: "abc123...xyz789" instead of the full token
  String sanitizeTokenForLogging(String token) {
    if (token.length <= 8) {
      return '***';
    }
    final prefix = token.substring(0, 4);
    final suffix = token.substring(token.length - 4);
    return '$prefix...$suffix';
  }

  /// Disposes the service and clears all sensitive data
  void dispose() {
    clearAllTokens();
    debugPrint('CallSecurityService: Disposed');
  }
}

/// Exception thrown when security validation fails
class SecurityException implements Exception {
  final String message;

  SecurityException(this.message);

  @override
  String toString() => 'SecurityException: $message';
}
