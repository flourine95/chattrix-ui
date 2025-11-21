import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_controls.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_error_view.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_info.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/local_video_preview.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/network_quality_banner.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/remote_video_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Call screen widget that displays the active call UI
/// Handles both video and audio calls with appropriate layouts
class CallScreen extends HookConsumerWidget {
  const CallScreen({super.key, required this.callId, required this.remoteUserId, required this.callType});

  final String callId;
  final String remoteUserId;
  final CallType callType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return callState.when(
      loading: () => _buildLoadingView(context),
      error: (error, stack) => _buildErrorView(context, error),
      data: (call) {
        if (call == null) {
          // No active call, navigate back
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.pop();
            }
          });
          return const SizedBox();
        }

        return _buildCallView(context, ref, call);
      },
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              const SizedBox(height: 24),
              Text('Connecting...', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, Object error) {
    return CallErrorView(error: error, onDismiss: () => context.pop());
  }

  Widget _buildCallView(BuildContext context, WidgetRef ref, CallEntity call) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    // Get remote UID from call entity (will be set when remote user joins)
    final remoteUid = call.remoteUid ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Remote video view (for video calls) with fade-in animation
            // Only show if remote user has joined (remoteUid > 0)
            if (call.callType == CallType.video && remoteUid > 0)
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: RemoteVideoView(remoteUid: remoteUid, channelId: call.channelId),
                ),
              ),

            // Show "Waiting for remote user" message if no remote user yet
            if (call.callType == CallType.video && remoteUid == 0)
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        const SizedBox(height: 24),
                        Text(
                          'Waiting for ${call.remoteUserId} to join...',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Audio call UI (for audio calls) with fade-in animation
            if (call.callType == CallType.audio)
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: _buildAudioCallBackground(context, call),
                ),
              ),

            // Local video preview (for video calls) with slide-in animation
            // Position changes based on orientation
            if (call.callType == CallType.video)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: isLandscape ? 20 : 50,
                right: isLandscape ? 20 : 20,
                child: TweenAnimationBuilder<Offset>(
                  tween: Tween(begin: const Offset(1.5, 0), end: Offset.zero),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(offset: value * 100, child: child);
                  },
                  child: const LocalVideoPreview(),
                ),
              ),

            // Network quality banner at the top with slide-down animation
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation),
                    child: child,
                  );
                },
                child: NetworkQualityBanner(
                  key: ValueKey(call.networkQuality),
                  networkQuality: call.networkQuality,
                  isReconnecting: call.status == CallStatus.connecting,
                ),
              ),
            ),

            // Call info below the banner with fade-in animation
            // Position adjusts based on orientation
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top:
                  call.networkQuality != null &&
                      (call.networkQuality == NetworkQuality.poor ||
                          call.networkQuality == NetworkQuality.bad ||
                          call.networkQuality == NetworkQuality.veryBad ||
                          call.status == CallStatus.connecting)
                  ? (isLandscape ? 50 : 60)
                  : (isLandscape ? 10 : 20),
              left: isLandscape ? 20 : 20,
              right: isLandscape ? null : 20,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 700),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
                  );
                },
                child: CallInfo(call: call),
              ),
            ),

            // Call controls at the bottom with slide-up animation
            // Layout changes based on orientation
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: isLandscape ? 20 : 50,
              left: isLandscape ? null : 0,
              right: isLandscape ? 20 : 0,
              child: TweenAnimationBuilder<Offset>(
                tween: Tween(begin: const Offset(0, 1.5), end: Offset.zero),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Transform.translate(offset: value * 100, child: child);
                },
                child: isLandscape ? _buildLandscapeControls(context, ref, call) : CallControls(call: call),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build controls for landscape orientation (vertical layout)
  Widget _buildLandscapeControls(BuildContext context, WidgetRef ref, CallEntity call) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mute/Unmute button
          _buildLandscapeControlButton(
            context: context,
            icon: call.isLocalAudioMuted ? Icons.mic_off : Icons.mic,
            isActive: !call.isLocalAudioMuted,
            onPressed: () => ref.read(callProvider.notifier).toggleMute(),
          ),
          const SizedBox(height: 12),

          // Video on/off button (only for video calls)
          if (call.callType == CallType.video) ...[
            _buildLandscapeControlButton(
              context: context,
              icon: call.isLocalVideoMuted ? Icons.videocam_off : Icons.videocam,
              isActive: !call.isLocalVideoMuted,
              onPressed: () => ref.read(callProvider.notifier).toggleVideo(),
            ),
            const SizedBox(height: 12),
          ],

          // Camera switch button (only for video calls)
          if (call.callType == CallType.video) ...[
            _buildLandscapeControlButton(
              context: context,
              icon: Icons.flip_camera_ios,
              isActive: true,
              onPressed: () => ref.read(callProvider.notifier).switchCamera(),
            ),
            const SizedBox(height: 12),
          ],

          // End call button
          _buildLandscapeControlButton(
            context: context,
            icon: Icons.call_end,
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

  /// Build control button for landscape orientation
  Widget _buildLandscapeControlButton({
    required BuildContext context,
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    bool isEndCall = false,
  }) {
    return Material(
      color: isEndCall
          ? Colors.red
          : isActive
          ? Colors.white.withValues(alpha: 0.2)
          : Colors.white.withValues(alpha: 0.1),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildAudioCallBackground(BuildContext context, CallEntity call) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade900, Colors.black],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User avatar placeholder
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.person, size: 64, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              call.remoteUserId,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
