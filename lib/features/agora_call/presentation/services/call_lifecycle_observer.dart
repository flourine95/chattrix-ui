import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Observer for handling app lifecycle changes during active calls
///
/// Manages:
/// - App backgrounding during active call (keep call running)
/// - App foregrounding with active call (restore UI state)
/// - Media resource management during lifecycle changes
///
/// Requirements: 3.4, 6.4
class CallLifecycleObserver with WidgetsBindingObserver {
  final Ref _ref;
  AppLifecycleState? _lastState;

  CallLifecycleObserver(this._ref) {
    WidgetsBinding.instance.addObserver(this);
    _lastState = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('CallLifecycleObserver: App lifecycle changed to $state');

    final previousState = _lastState;
    _lastState = state;

    // Get current call state
    final callState = _ref.read(callStateProvider);
    final call = switch (callState) {
      AsyncData(:final value) => value,
      _ => null,
    };

    // Only handle lifecycle changes if there's an active call
    if (call == null) return;

    switch (state) {
      case AppLifecycleState.paused:
        _handleAppBackgrounded(call);
        break;

      case AppLifecycleState.resumed:
        if (previousState == AppLifecycleState.paused) {
          _handleAppForegrounded(call);
        }
        break;

      case AppLifecycleState.inactive:
        // App is transitioning - no action needed
        break;

      case AppLifecycleState.detached:
        // App is being terminated - cleanup will be handled by dispose
        break;

      case AppLifecycleState.hidden:
        // App window is hidden but still running
        break;
    }
  }

  /// Handle app backgrounding during active call
  /// Requirement 3.4: Handle app backgrounding during active call
  void _handleAppBackgrounded(CallEntity call) {
    debugPrint('CallLifecycleObserver: App backgrounded during call ${call.id}');

    // For audio calls, we can continue in background
    // For video calls, we should pause local video to save battery
    if (call.callType == CallType.video) {
      final callControls = _ref.read(callControlsProvider.notifier);
      final currentState = _ref.read(callControlsProvider);

      // Only disable video if it's currently enabled
      if (currentState.isVideoEnabled) {
        debugPrint('CallLifecycleObserver: Disabling video due to backgrounding');
        callControls.toggleVideo();
      }
    }

    // Note: Agora SDK continues to work in background for audio
    // iOS background modes (audio, voip) allow this
    // Android foreground service would be needed for production
  }

  /// Handle app foregrounding with active call
  /// Requirement 3.4: Handle app foregrounding with active call
  void _handleAppForegrounded(CallEntity call) {
    debugPrint('CallLifecycleObserver: App foregrounded during call ${call.id}');

    // Check if call is still active
    if (call.status != CallStatus.connected && call.status != CallStatus.connecting) {
      debugPrint('CallLifecycleObserver: Call is no longer active');
      return;
    }

    // For video calls, we can optionally re-enable video
    // But we don't do it automatically - let user decide
    if (call.callType == CallType.video) {
      debugPrint('CallLifecycleObserver: Video call resumed - user can re-enable video');
    }

    // Verify Agora connection is still active
    _verifyAgoraConnection(call);
  }

  /// Verify Agora connection is still active after foregrounding
  Future<void> _verifyAgoraConnection(CallEntity call) async {
    try {
      // Check if we're still in the channel
      // If not, we may need to rejoin
      // Note: Agora SDK should maintain connection automatically
      // This is just a safety check

      debugPrint('CallLifecycleObserver: Verifying Agora connection for call ${call.id}');

      // The Agora SDK handles reconnection automatically
      // We just log for monitoring purposes
    } catch (e) {
      debugPrint('CallLifecycleObserver: Error verifying Agora connection: $e');

      // If there's a connection issue, the Agora error handler will handle it
      // through the onError callback registered in ActiveCallScreen
    }
  }

  /// Dispose the observer
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}

/// Provider for CallLifecycleObserver
/// Automatically disposes when provider is disposed
final callLifecycleObserverProvider = Provider<CallLifecycleObserver>((ref) {
  final observer = CallLifecycleObserver(ref);
  ref.onDispose(() => observer.dispose());
  return observer;
});
