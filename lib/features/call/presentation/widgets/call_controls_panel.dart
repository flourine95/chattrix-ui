import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_control_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/call_state.dart';

/// Optimized controls panel that only rebuilds when control states change
class CallControlsPanel extends ConsumerWidget {
  final CallType callType;

  const CallControlsPanel({
    super.key,
    required this.callType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    // Extract control states only when connected
    return callState.when(
      idle: () => const SizedBox.shrink(),
      initiating: (_, __) => const SizedBox.shrink(),
      ringing: (_) => const SizedBox.shrink(),
      connecting: (_, __, ___) => const SizedBox.shrink(),
      connected: (_, __, ___, isMuted, isVideoEnabled, isSpeakerEnabled, ______, _______, ________, _________) {
        final isVideoCall = callType == CallType.video;

        return Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nút Mic
              ModernCallButton(
                icon: isMuted ? Icons.mic_off : Icons.mic,
                label: "Mute",
                isActive: isMuted,
                onPressed: ref.read(callProvider.notifier).toggleMute,
              ),

              // Nút Camera (Chỉ hiện nếu là video call)
              if (isVideoCall)
                ModernCallButton(
                  icon: isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                  label: "Camera",
                  isActive: !isVideoEnabled,
                  onPressed: ref.read(callProvider.notifier).toggleVideo,
                ),

              if (isVideoCall)
                ModernCallButton(
                  icon: Icons.flip_camera_ios,
                  label: "Flip",
                  onPressed: ref.read(callProvider.notifier).switchCamera,
                ),

              // Nút Loa
              ModernCallButton(
                icon: isSpeakerEnabled ? Icons.volume_up : Icons.volume_off,
                label: "Speaker",
                isActive: isSpeakerEnabled,
                activeColor: Colors.blue[100],
                onPressed: ref.read(callProvider.notifier).toggleSpeaker,
              ),

              // Nút End Call
              ModernCallButton(
                icon: Icons.call_end,
                label: "End",
                isDestructive: true,
                onPressed: ref.read(callProvider.notifier).endCall,
              ),
            ],
          ),
        );
      },
      ended: (_) => const SizedBox.shrink(),
      error: (_) => const SizedBox.shrink(),
    );
  }
}

