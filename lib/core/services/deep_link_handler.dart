import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';
import 'deep_link_service.dart';

/// Handler for deep links using app_links package
///
/// Supports:
/// - Custom scheme: chattrix://invite/{token}
/// - Universal link: https://chattrix.app/invite/{token} (requires platform config)
class DeepLinkHandler {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  bool _initialLinkHandled = false;

  /// Initialize deep link handling
  ///
  /// Call this in main() or app initialization
  Future<void> initialize(GoRouter router) async {
    debugPrint('🔗 Initializing deep link handler...');

    // Handle initial link (app opened from deep link)
    await _handleInitialLink(router);

    // Handle links while app is running
    _handleIncomingLinks(router);

    debugPrint('✅ Deep link handler initialized');
  }

  /// Handle initial link when app is opened from a deep link
  Future<void> _handleInitialLink(GoRouter router) async {
    if (_initialLinkHandled) return;

    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint('📱 Initial deep link: $initialUri');
        _navigateFromDeepLink(router, initialUri);
        _initialLinkHandled = true;
      } else {
        debugPrint('ℹ️ No initial deep link');
      }
    } catch (e) {
      debugPrint('❌ Error handling initial link: $e');
    }
  }

  /// Handle incoming links while app is running
  void _handleIncomingLinks(GoRouter router) {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        debugPrint('📱 Incoming deep link: $uri');
        _navigateFromDeepLink(router, uri);
      },
      onError: (err) {
        debugPrint('❌ Error handling incoming link: $err');
      },
    );
  }

  /// Navigate from deep link URI
  void _navigateFromDeepLink(GoRouter router, Uri uri) {
    final route = DeepLinkService.handleDeepLink(uri);
    if (route != null) {
      debugPrint('✅ Navigating to: $route');
      router.go(route);
    } else {
      debugPrint('⚠️ Deep link not recognized: $uri');
    }
  }

  /// Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
    debugPrint('🔗 Deep link handler disposed');
  }
}
