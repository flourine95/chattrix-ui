import 'package:chattrix_ui/features/agora_call/presentation/providers/call_controls_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget displaying call control buttons
/// Provides mute, video, speaker, and camera switch controls
/// Requirements: 5.3, 5.4, 5.5
class CallControlsWidget extends HookConsumerWidget {
  final bool isVideoCall;

  const CallControlsWidget({super.key, required this.isVideoCall});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controlsState = ref.watch(callControlsProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Mute/Unmute button (Requirement 5.3)
        _CallControlButton(
          icon: controlsState.isMuted ? FontAwesomeIcons.microphoneSlash : FontAwesomeIcons.microphone,
          label: controlsState.isMuted ? 'Unmute' : 'Mute',
          isActive: !controlsState.isMuted,
          onPressed: () => ref.read(callControlsProvider.notifier).toggleMute(),
        ),

        // Video enable/disable button (Requirement 5.4) - only for video calls
        if (isVideoCall)
          _CallControlButton(
            icon: controlsState.isVideoEnabled ? FontAwesomeIcons.video : FontAwesomeIcons.videoSlash,
            label: controlsState.isVideoEnabled ? 'Video' : 'No Video',
            isActive: controlsState.isVideoEnabled,
            onPressed: () => ref.read(callControlsProvider.notifier).toggleVideo(),
          ),

        // Speaker toggle button
        _CallControlButton(
          icon: controlsState.isSpeakerOn ? FontAwesomeIcons.volumeHigh : FontAwesomeIcons.volumeLow,
          label: controlsState.isSpeakerOn ? 'Speaker' : 'Earpiece',
          isActive: controlsState.isSpeakerOn,
          onPressed: () => ref.read(callControlsProvider.notifier).toggleSpeaker(),
        ),

        // Camera switch button (Requirement 5.5) - only for video calls
        if (isVideoCall)
          _CallControlButton(
            icon: FontAwesomeIcons.cameraRotate,
            label: 'Switch',
            isActive: true,
            onPressed: () => ref.read(callControlsProvider.notifier).switchCamera(),
          ),
      ],
    );
  }
}

/// Individual call control button
class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _CallControlButton({required this.icon, required this.label, required this.isActive, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular button
        Material(
          color: isActive ? Colors.white.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.1),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              child: FaIcon(icon, color: isActive ? Colors.white : Colors.white70, size: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Label
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}
