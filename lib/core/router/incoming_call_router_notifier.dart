import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';
import 'package:chattrix_ui/features/call/presentation/providers/incoming_call_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A ChangeNotifier that bridges Riverpod providers with GoRouter's refreshListenable.
/// This notifier listens to incoming call state changes and app lifecycle changes,
/// triggering router refreshes when either changes occur.
class IncomingCallRouterNotifier extends ChangeNotifier with WidgetsBindingObserver {
  final Ref _ref;
  AppLifecycleState? _lastLifecycleState;

  IncomingCallRouterNotifier(this._ref) {
    // Listen to incoming call provider changes
    _ref.listen<CallInvitationData?>(currentIncomingCallProvider, (previous, next) {
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

/// Provider for IncomingCallRouterNotifier
/// Ensures proper disposal of the notifier when the provider is disposed
final incomingCallRouterNotifierProvider = Provider<IncomingCallRouterNotifier>((ref) {
  final notifier = IncomingCallRouterNotifier(ref);
  ref.onDispose(() => notifier.dispose());
  return notifier;
});
