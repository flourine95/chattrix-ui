import 'package:chattrix_ui/features/call/presentation/providers/pip_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/pip_call_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlobalPipOverlay extends ConsumerWidget {
  final Widget child;

  const GlobalPipOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPipMode = ref.watch(pipStateProvider);
    final callState = ref.watch(callProvider);

    return Stack(
      children: [
        child,
        if (isPipMode)
          callState.maybeWhen(
            connected: (connection, callType, isOutgoing, _, _, _, _, _, _, _) {
              final remoteName = isOutgoing ? connection.callInfo.calleeName : connection.callInfo.callerName;
              final remoteAvatar = isOutgoing ? connection.callInfo.calleeAvatar : connection.callInfo.callerAvatar;

              return PipCallOverlay(callType: callType, remoteName: remoteName, remoteAvatar: remoteAvatar);
            },
            orElse: () => const SizedBox.shrink(),
          ),
      ],
    );
  }
}
