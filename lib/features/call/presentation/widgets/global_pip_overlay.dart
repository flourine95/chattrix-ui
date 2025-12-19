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

    debugPrint('[GlobalPipOverlay] isPipMode: $isPipMode, callState: ${callState.runtimeType}');

    return Stack(
      children: [
        child,
        if (isPipMode)
          callState.maybeWhen(
            connected: (connection, callType, isOutgoing, _, _, _, _, _, _, _) {
              debugPrint('[GlobalPipOverlay] Rendering PiP overlay for call: ${connection.callInfo.id}');

              final remoteName = isOutgoing ? connection.callInfo.calleeName : connection.callInfo.callerName;
              final remoteAvatar = isOutgoing ? connection.callInfo.calleeAvatar : connection.callInfo.callerAvatar;
              final channelId = connection.callInfo.channelId;

              return PipCallOverlay(
                callType: callType,
                remoteName: remoteName,
                remoteAvatar: remoteAvatar,
                channelId: channelId,
              );
            },
            orElse: () {
              debugPrint('[GlobalPipOverlay] Call not connected, not showing PiP overlay');
              return const SizedBox.shrink();
            },
          ),
      ],
    );
  }
}
