import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/agora_call/data/services/call_security_service.dart';
import 'package:flutter/foundation.dart';

/// Utility class for validating call security requirements
///
/// Requirements: 10.1, 10.5
class CallSecurityValidator {
  /// Validates that all security requirements are met
  ///
  /// Requirement 10.5: Verify HTTPS is used for all API calls
  /// Requirement 10.5: Verify WSS is used for WebSocket connection
  ///
  /// Should be called at app startup to ensure secure configuration
  /// Throws SecurityException in production if insecure protocols are detected
  static void validateSecurityRequirements() {
    final securityService = CallSecurityService();

    try {
      // Get the base URLs from API constants
      final apiBaseUrl = _getApiBaseUrl();
      final wsBaseUrl = _getWebSocketBaseUrl();

      debugPrint('CallSecurityValidator: Validating security requirements...');
      debugPrint('CallSecurityValidator: API Base URL: $apiBaseUrl');
      debugPrint('CallSecurityValidator: WebSocket Base URL: $wsBaseUrl');

      // Validate secure protocols
      securityService.validateSecureProtocols(apiBaseUrl: apiBaseUrl, wsBaseUrl: wsBaseUrl);

      debugPrint('CallSecurityValidator: Security validation passed');
    } catch (e) {
      debugPrint('CallSecurityValidator: Security validation failed: $e');
      rethrow;
    } finally {
      securityService.dispose();
    }
  }

  /// Extracts the base URL from API constants
  static String _getApiBaseUrl() {
    // Use any endpoint to extract the base URL
    final fullUrl = ApiConstants.callsInitiate;
    final uri = Uri.parse(fullUrl);
    return '${uri.scheme}://${uri.host}:${uri.port}';
  }

  /// Extracts the WebSocket base URL from API constants
  static String _getWebSocketBaseUrl() {
    final fullUrl = ApiConstants.chatWebSocket;
    final uri = Uri.parse(fullUrl);
    return '${uri.scheme}://${uri.host}:${uri.port}';
  }

  /// Validates that JWT token is present in request headers
  ///
  /// Requirement 10.1: JWT token must be included in all API requests
  /// This is handled by AuthInterceptor, but this method can be used
  /// for additional validation if needed
  static bool hasAuthorizationHeader(Map<String, dynamic> headers) {
    return headers.containsKey('Authorization') || headers.containsKey('authorization');
  }

  /// Checks if a token appears to be a valid JWT format
  ///
  /// Basic validation: JWT tokens have 3 parts separated by dots
  /// This doesn't validate the signature, just the format
  static bool isValidJwtFormat(String token) {
    final parts = token.split('.');
    return parts.length == 3;
  }
}
