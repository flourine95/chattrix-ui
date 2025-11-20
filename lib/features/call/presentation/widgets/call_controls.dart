import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bottom control bar with call action buttons
/// Provides controls for mute, video, camera switch, and end call
class CallControls extends HookConsumerWidget {
  const CallControls({super.key, required this.call});

  final CallEntity call;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Mute/Unmute button
          _buildControlButton(
            icon: call.isLocalAudioMuted ? Icons.mic_off : Icons.mic,
            label: call.isLocalAudioMuted ? 'Unmute' : 'Mute',
            isActive: !call.isLocalAudioMuted,
            onPressed: () => ref.read(callProvider.notifier).toggleMute(),
          ),

          // Video on/off button (only for video calls)
          if (call.callType == CallType.video)
            _buildControlButton(
              icon: call.isLocalVideoMuted ? Icons.videocam_off : Icons.videocam,
              label: call.isLocalVideoMuted ? 'Video Off' : 'Video On',
              isActive: !call.isLocalVideoMuted,
              onPressed: () => ref.read(callProvider.notifier).toggleVideo(),
            ),

          // Camera switch button (only for video calls)
          if (call.callType == CallType.video)
            _buildControlButton(
              icon: Icons.flip_camera_ios,
              label: 'Switch',
              isActive: true,
              onPressed: () => ref.read(callProvider.notifier).switchCamera(),
            ),

          // End call button
          _buildControlButton(
            icon: Icons.call_end,
            label: 'End',
            isActive: true,
            isEndCall: true,
            onPressed: () async {
              await ref.read(callProvider.notifier).endCall(call.callId);
              if (context.mounted) {
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
    bool isEndCall = false,
  }) {
    return _AnimatedControlButton(
      icon: icon,
      label: label,
      isActive: isActive,
      isEndCall: isEndCall,
      onPressed: onPressed,
    );
  }
}

/// Animated control button with press animation
class _AnimatedControlButton extends HookWidget {
  const _AnimatedControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isEndCall,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final bool isEndCall;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(milliseconds: 150));
    final scaleAnimation = useAnimation(
      Tween<double>(
        begin: 1.0,
        end: 0.9,
      ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut)),
    );

    return GestureDetector(
      onTapDown: (_) => animationController.forward(),
      onTapUp: (_) {
        animationController.reverse();
        onPressed();
      },
      onTapCancel: () => animationController.reverse(),
      child: Transform.scale(
        scale: scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: isEndCall
                  ? Colors.red
                  : isActive
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.1),
              shape: const CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: Icon(icon, color: Colors.white, size: 28),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
