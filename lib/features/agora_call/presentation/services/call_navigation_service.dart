import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Service for managing call-related navigation
///
/// Handles:
/// - Navigation to call screens
/// - Deep linking for incoming calls
/// - App backgrounding/foregrounding during calls
/// - Navigation stack management
///
/// Requirements: 1.5, 2.2, 3.4, 6.4
class CallNavigationService {
  final Ref _ref;
  final BuildContext _context;

  CallNavigationService(this._ref, this._context);

  /// Navigate to outgoing call screen
  /// Requirement 1.5: Display calling screen when initiating call
  void navigateToOutgoingCall() {
    if (!_context.mounted) return;
    _context.push('/agora-call/outgoing');
  }

  /// Navigate to incoming call screen
  /// Requirement 2.2: Display incoming call screen when call invitation received
  void navigateToIncomingCall() {
    if (!_context.mounted) return;
    _context.push('/agora-call/incoming');
  }

  /// Navigate to active call screen
  /// Requirement 3.4: Transition to active call screen when call is accepted
  void navigateToActiveCall() {
    if (!_context.mounted) return;
    _context.push('/agora-call/active');
  }

  /// Navigate back from call screen
  /// Requirement 6.4: Return to previous screen when call ends
  void navigateBackFromCall() {
    if (!_context.mounted) return;
    _context.pop();
  }

  /// Handle deep link for incoming call
  /// Parses deep link URI and navigates to appropriate screen
  ///
  /// Expected format: chattrix://call/incoming?callId=xxx
  ///
  /// Requirement 2.2: Handle deep linking for incoming calls
  Future<void> handleDeepLink(Uri uri) async {
    debugPrint('CallNavigationService: Handling deep link - $uri');

    if (uri.scheme != 'chattrix' || uri.host != 'call') {
      debugPrint('CallNavigationService: Invalid deep link scheme or host');
      return;
    }

    final path = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';

    switch (path) {
      case 'incoming':
        // Check if there's an active incoming call
        final callState = _ref.read(callStateProvider);
        final call = switch (callState) {
          AsyncData(:final value) => value,
          _ => null,
        };

        if (call != null && call.status == CallStatus.ringing) {
          navigateToIncomingCall();
        } else {
          debugPrint('CallNavigationService: No incoming call to show');
        }
        break;

      case 'active':
        // Navigate to active call if there's one
        final callState = _ref.read(callStateProvider);
        final call = switch (callState) {
          AsyncData(:final value) => value,
          _ => null,
        };

        if (call != null && call.status == CallStatus.connected) {
          navigateToActiveCall();
        } else {
          debugPrint('CallNavigationService: No active call to show');
        }
        break;

      default:
        debugPrint('CallNavigationService: Unknown deep link path - $path');
    }
  }

  /// Check if currently on a call screen
  /// Used to prevent unwanted navigation during calls
  bool isOnCallScreen() {
    final location = GoRouterState.of(_context).matchedLocation;
    return location.startsWith('/agora-call/');
  }

  /// Get current call screen type
  /// Returns null if not on a call screen
  CallScreenType? getCurrentCallScreen() {
    final location = GoRouterState.of(_context).matchedLocation;

    if (location == '/agora-call/outgoing') {
      return CallScreenType.outgoing;
    } else if (location == '/agora-call/incoming') {
      return CallScreenType.incoming;
    } else if (location == '/agora-call/active') {
      return CallScreenType.active;
    }

    return null;
  }

  /// Navigate to appropriate call screen based on call state
  /// Ensures user is on the correct screen for the current call status
  void syncNavigationWithCallState(CallEntity? call) {
    if (!_context.mounted) return;

    final currentScreen = getCurrentCallScreen();

    if (call == null) {
      // No call - navigate back if on call screen
      if (currentScreen != null) {
        navigateBackFromCall();
      }
      return;
    }

    // Navigate based on call status
    switch (call.status) {
      case CallStatus.initiating:
      case CallStatus.ringing:
        // Should be on outgoing or incoming screen
        if (currentScreen == null) {
          // Determine if we're caller or callee
          final currentUser = _ref.read(currentUserProvider);
          if (currentUser != null && currentUser.id == call.callerId) {
            navigateToOutgoingCall();
          } else {
            navigateToIncomingCall();
          }
        }
        break;

      case CallStatus.connecting:
      case CallStatus.connected:
        // Should be on active call screen
        if (currentScreen != CallScreenType.active) {
          navigateToActiveCall();
        }
        break;

      case CallStatus.rejected:
      case CallStatus.ended:
        // Should not be on any call screen
        if (currentScreen != null) {
          navigateBackFromCall();
        }
        break;
    }
  }
}

/// Types of call screens
enum CallScreenType { outgoing, incoming, active }

/// Provider for CallNavigationService
/// Must be used within a widget context
final callNavigationServiceProvider = Provider.family<CallNavigationService, BuildContext>((ref, context) {
  return CallNavigationService(ref, context);
});
