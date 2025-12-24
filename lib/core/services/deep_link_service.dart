import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

/// Service for handling deep links
class DeepLinkService {
  static const String _inviteLinkScheme = 'chattrix';
  static const String _inviteLinkHost = 'invite';
  static const String _webInviteLinkHost = 'chattrix.app';

  /// Handle deep link URI
  ///
  /// Supported formats:
  /// - chattrix://invite/{token}
  /// - https://chattrix.app/invite/{token}
  static String? handleDeepLink(Uri uri) {
    debugPrint('Handling deep link: $uri');

    // Handle custom scheme: chattrix://invite/{token}
    if (uri.scheme == _inviteLinkScheme && uri.host == _inviteLinkHost) {
      final token = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      if (token != null && token.isNotEmpty) {
        debugPrint('Extracted invite token from custom scheme: $token');
        return '/invite/$token';
      }
    }

    // Handle universal link: https://chattrix.app/invite/{token}
    if (uri.scheme == 'https' && uri.host == _webInviteLinkHost) {
      if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'invite') {
        final token = uri.pathSegments[1];
        if (token.isNotEmpty) {
          debugPrint('Extracted invite token from universal link: $token');
          return '/invite/$token';
        }
      }
    }

    debugPrint('Deep link not recognized or invalid');
    return null;
  }

  /// Initialize deep link handling
  ///
  /// This should be called in main() to set up deep link listeners
  static void initialize(GoRouter router) {
    // TODO: Add platform-specific deep link listeners
    // For Android: Use app_links package (already configured)
    // For iOS: Configure in Info.plist and use app_links
    debugPrint('Deep link service initialized');
  }
}
