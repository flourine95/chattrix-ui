import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRedirectGuard {
  static Future<String?> redirect(WidgetRef ref, GoRouterState state) async {
    final currentLocation = state.matchedLocation;
    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();

    final authRoutes = {RoutePaths.login, RoutePaths.register, RoutePaths.forgotPassword, RoutePaths.otpVerification};

    final isGoingToAuth = authRoutes.contains(currentLocation);

    if (!isLoggedIn && !isGoingToAuth) {
      return RoutePaths.login;
    }

    if (isLoggedIn && isGoingToAuth) {
      return RoutePaths.chats;
    }

    return null;
  }
}

class CallRedirectGuard {
  static String? redirect(WidgetRef ref, String currentLocation) {
    final callState = ref.read(callProvider);
    final callRoutes = {RoutePaths.incomingCall, RoutePaths.outgoingCall, RoutePaths.activeCall};

    return callState.when(
      idle: () => _handleIdleState(currentLocation, callRoutes),
      initiating: (_, _, _, _) => _handleInitiatingState(currentLocation),
      ringing: (_) => _handleRingingState(currentLocation),
      connecting: (_, _, isOutgoing) => _handleConnectingState(currentLocation, isOutgoing),
      connected: (_, _, isOutgoing, _, _, _, _, _, _, _) => _handleConnectedState(currentLocation),
      ended: (_) => _handleEndedState(currentLocation, callRoutes),
      error: (_) => _handleErrorState(currentLocation, callRoutes),
    );
  }

  static String? _handleIdleState(String location, Set<String> callRoutes) {
    return callRoutes.contains(location) ? RoutePaths.chats : null;
  }

  static String? _handleInitiatingState(String location) {
    return location != RoutePaths.outgoingCall ? RoutePaths.outgoingCall : null;
  }

  static String? _handleRingingState(String location) {
    return location != RoutePaths.incomingCall ? RoutePaths.incomingCall : null;
  }

  static String? _handleConnectingState(String location, bool isOutgoing) {
    if (isOutgoing && location != RoutePaths.outgoingCall) {
      debugPrint('[Router] 🔀 Redirecting to ${RoutePaths.outgoingCall} (outgoing call connecting)');
      return RoutePaths.outgoingCall;
    } else if (!isOutgoing && location != RoutePaths.activeCall) {
      debugPrint('[Router] 🔀 Redirecting to ${RoutePaths.activeCall} (incoming call connecting)');
      return RoutePaths.activeCall;
    }
    return null;
  }

  static String? _handleConnectedState(String location) {
    final shouldRedirect = location != RoutePaths.activeCall;
    if (shouldRedirect) {
      debugPrint('[Router] 🔀 Redirecting from $location to ${RoutePaths.activeCall} (call connected)');
    }
    return shouldRedirect ? RoutePaths.activeCall : null;
  }

  static String? _handleEndedState(String location, Set<String> callRoutes) {
    return callRoutes.contains(location) ? RoutePaths.chats : null;
  }

  static String? _handleErrorState(String location, Set<String> callRoutes) {
    return callRoutes.contains(location) ? RoutePaths.chats : null;
  }
}
