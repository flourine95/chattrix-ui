import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/presentation/providers/incoming_call_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget that listens to incoming call invitations and navigates to the incoming call screen
class IncomingCallListener extends ConsumerStatefulWidget {
  final Widget child;

  const IncomingCallListener({super.key, required this.child});

  @override
  ConsumerState<IncomingCallListener> createState() => _IncomingCallListenerState();
}

class _IncomingCallListenerState extends ConsumerState<IncomingCallListener> with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastLifecycleState = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;

    // When app comes to foreground, check if there's a pending invitation
    if (state == AppLifecycleState.resumed) {
      final currentInvitation = ref.read(currentIncomingCallProvider);
      if (currentInvitation != null && mounted) {
        // Navigate to incoming call screen if there's a pending invitation
        context.push('/incoming-call', extra: currentInvitation);
      }
    }
  }

  bool _isAppInForeground() {
    return _lastLifecycleState == AppLifecycleState.resumed;
  }

  @override
  Widget build(BuildContext context) {
    // Listen to incoming call invitations
    ref.listen<CallInvitation?>(currentIncomingCallProvider, (previous, next) {
      if (next != null && previous?.callId != next.callId) {
        // Only navigate if app is in foreground
        // If in background, notification will be shown instead
        if (_isAppInForeground()) {
          context.push('/incoming-call', extra: next);
        }
      }
    });

    return widget.child;
  }
}
