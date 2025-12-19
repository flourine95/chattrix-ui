import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_control_state_providers.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_selectors.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_control_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CallControlsPanel extends ConsumerWidget {
  final CallType callType;

  const CallControlsPanel({super.key, required this.callType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Chỉ watch để biết có đang connected không
    final isConnected = ref.watch(isCallConnectedProvider);

    if (!isConnected) return const SizedBox.shrink();

    final isVideoCall = callType == CallType.video;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, -4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _MuteButton(),
          if (isVideoCall) const _CameraButton(),
          if (isVideoCall) const _FlipCameraButton(),
          const _SpeakerButton(),
          const _EndCallButton(),
        ],
      ),
    );
  }
}

// Mute Button - Chỉ rebuild khi isMuted thay đổi
class _MuteButton extends ConsumerWidget {
  const _MuteButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muted = ref.watch(isMutedStateProvider);

    return ModernCallButton(
      icon: muted ? Icons.mic_off : Icons.mic,
      label: "Mute",
      isActive: muted,
      onPressed: () => ref.read(callProvider.notifier).toggleMute(),
    );
  }
}

// Camera Button - Chỉ rebuild khi isVideoEnabled thay đổi
class _CameraButton extends ConsumerWidget {
  const _CameraButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoEnabled = ref.watch(isVideoEnabledStateProvider);

    return ModernCallButton(
      icon: videoEnabled ? Icons.videocam : Icons.videocam_off,
      label: "Camera",
      isActive: !videoEnabled,
      onPressed: () => ref.read(callProvider.notifier).toggleVideo(),
    );
  }
}

// Flip Camera Button - Không cần watch state, luôn giống nhau
class _FlipCameraButton extends ConsumerWidget {
  const _FlipCameraButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModernCallButton(
      icon: Icons.flip_camera_ios,
      label: "Flip",
      onPressed: () => ref.read(callProvider.notifier).switchCamera(),
    );
  }
}

// Speaker Button - Chỉ rebuild khi isSpeakerEnabled thay đổi
class _SpeakerButton extends ConsumerWidget {
  const _SpeakerButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speakerEnabled = ref.watch(isSpeakerEnabledStateProvider);

    return ModernCallButton(
      icon: speakerEnabled ? Icons.volume_up : Icons.volume_off,
      label: "Speaker",
      isActive: speakerEnabled,
      activeColor: Colors.blue[100],
      onPressed: () => ref.read(callProvider.notifier).toggleSpeaker(),
    );
  }
}

// End Call Button - Không cần watch state, luôn giống nhau
class _EndCallButton extends ConsumerWidget {
  const _EndCallButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModernCallButton(
      icon: Icons.call_end,
      label: "End",
      isDestructive: true,
      onPressed: () => ref.read(callProvider.notifier).endCall(),
    );
  }
}
