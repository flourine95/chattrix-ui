import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/call_state_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A ChangeNotifier that bridges Riverpod providers with GoRouter's refreshListenable.
/// This notifier listens to Agora call state changes and app lifecycle changes,
/// triggering router refreshes when either changes occur.
///
/// This enables automatic navigation to the IncomingCallScreen when a call.incoming
/// event is received via WebSocket.
class AgoraCallRouterNotifier extends ChangeNotifier with WidgetsBindingObserver {
  final Ref _ref;
  AppLifecycleState? _lastLifecycleState;

  AgoraCallRouterNotifier(this._ref) {
    // Listen to call state provider changes
    _ref.listen<AsyncValue<CallEntity?>>(callStateProvider, (previous, next) {
      notifyListeners(); // Trigger router refresh
    });

    // Monitor app lifecycle
    WidgetsBinding.instance.addObserver(this);
    _lastLifecycleState = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    notifyListeners(); // Trigger router refresh when lifecycle changes
  }

  /// Returns true if the app is currently in the foreground (resumed state)
  bool get isAppInForeground => _lastLifecycleState == AppLifecycleState.resumed;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

/// Provider for AgoraCallRouterNotifier
/// Ensures proper disposal of the notifier when the provider is disposed
final agoraCallRouterNotifierProvider = Provider<AgoraCallRouterNotifier>((ref) {
  final notifier = AgoraCallRouterNotifier(ref);
  ref.onDispose(() => notifier.dispose());
  return notifier;
});
