import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_control_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Page for active call - shows video/audio call interface
class CallPage extends ConsumerWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: callState.when(
          idle: () => const Center(
            child: Text(
              'No active call',
              style: TextStyle(color: Colors.white),
            ),
          ),
          initiating: (calleeId, callType) => const Center(
            child: Text(
              'Initiating call...',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ringing: (invitation) => const Center(
            child: Text(
              'Ringing...',
              style: TextStyle(color: Colors.white),
            ),
          ),
          connecting: (connection, callType, isOutgoing) => _buildConnectingView(
            userName: isOutgoing
                ? connection.callInfo.calleeName
                : connection.callInfo.callerName,
            userAvatar: isOutgoing
                ? connection.callInfo.calleeAvatar
                : connection.callInfo.callerAvatar,
            callType: callType,
            isOutgoing: isOutgoing,
            ref: ref,
          ),
          connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled,
                  isSpeakerEnabled, isFrontCamera, remoteUid) =>
              _buildConnectedView(
            context,
            ref,
            userName: isOutgoing
                ? connection.callInfo.calleeName
                : connection.callInfo.callerName,
            userAvatar: isOutgoing
                ? connection.callInfo.calleeAvatar
                : connection.callInfo.callerAvatar,
            callType: callType,
            isMuted: isMuted,
            isVideoEnabled: isVideoEnabled,
            isSpeakerEnabled: isSpeakerEnabled,
            isFrontCamera: isFrontCamera,
            remoteUid: remoteUid,
          ),
          ended: (reason) => const Center(
            child: Text(
              'Call ended',
              style: TextStyle(color: Colors.white),
            ),
          ),
          error: (message) => Center(
            child: Text(
              'Error: $message',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectingView({
    required String userName,
    String? userAvatar,
    required CallType callType,
    required bool isOutgoing,
    required WidgetRef ref,
  }) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[800],
                backgroundImage:
                    userAvatar != null ? NetworkImage(userAvatar) : null,
                child: userAvatar == null
                    ? Text(
                        userName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 64),
                      )
                    : null,
              ),
              const SizedBox(height: 32),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Connecting...',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // End call button
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () => ref.read(callProvider.notifier).endCall(),
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectedView(
    BuildContext context,
    WidgetRef ref, {
    required String userName,
    String? userAvatar,
    required CallType callType,
    required bool isMuted,
    required bool isVideoEnabled,
    required bool isSpeakerEnabled,
    required bool isFrontCamera,
    int? remoteUid,
  }) {
    final isVideoCall = callType == CallType.video;
    final agoraService = ref.watch(agoraServiceProvider);

    return Stack(
      children: [
        // Remote video or avatar
        if (isVideoCall && remoteUid != null && isVideoEnabled)
          _buildRemoteVideo(agoraService, remoteUid)
        else
          _buildAvatarView(userName, userAvatar),

        // Local video preview (for video calls)
        if (isVideoCall && isVideoEnabled)
          Positioned(
            top: 40,
            right: 20,
            child: _buildLocalVideoPreview(agoraService),
          ),

        // User info overlay
        Positioned(
          top: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    isVideoCall ? Icons.videocam : Icons.phone,
                    color: Colors.grey[300],
                    size: 16,
                    shadows: const [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isVideoCall ? 'Video Call' : 'Voice Call',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      shadows: const [
                        Shadow(blurRadius: 10, color: Colors.black)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Controls at bottom
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: _buildControls(
            ref: ref,
            isMuted: isMuted,
            isVideoEnabled: isVideoEnabled,
            isSpeakerEnabled: isSpeakerEnabled,
            isVideoCall: isVideoCall,
          ),
        ),
      ],
    );
  }

  Widget _buildRemoteVideo(dynamic agoraService, int remoteUid) {
    return SizedBox.expand(
      child: agoraService.engine != null
          ? AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: agoraService.engine!,
                canvas: VideoCanvas(uid: remoteUid),
                connection: const RtcConnection(channelId: ''),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildLocalVideoPreview(dynamic agoraService) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: agoraService.engine != null
            ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: agoraService.engine!,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
      ),
    );
  }

  Widget _buildAvatarView(String userName, String? userAvatar) {
    return Center(
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey[800],
        backgroundImage: userAvatar != null ? NetworkImage(userAvatar) : null,
        child: userAvatar == null
            ? Text(
                userName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 64, color: Colors.white),
              )
            : null,
      ),
    );
  }

  Widget _buildControls({
    required WidgetRef ref,
    required bool isMuted,
    required bool isVideoEnabled,
    required bool isSpeakerEnabled,
    required bool isVideoCall,
  }) {
    final notifier = ref.read(callProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Mute button
          CallControlButton(
            icon: isMuted ? Icons.mic_off : Icons.mic,
            label: isMuted ? 'Unmute' : 'Mute',
            onPressed: notifier.toggleMute,
            isActive: isMuted,
          ),

          // Video button (only for video calls)
          if (isVideoCall)
            CallControlButton(
              icon: isVideoEnabled ? Icons.videocam : Icons.videocam_off,
              label: isVideoEnabled ? 'Stop' : 'Start',
              onPressed: notifier.toggleVideo,
              isActive: !isVideoEnabled,
            ),

          // End call button
          GestureDetector(
            onTap: notifier.endCall,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.5),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          // Speaker button
          CallControlButton(
            icon: isSpeakerEnabled ? Icons.volume_up : Icons.volume_off,
            label: isSpeakerEnabled ? 'Speaker' : 'Earpiece',
            onPressed: notifier.toggleSpeaker,
            isActive: isSpeakerEnabled,
          ),

          // Switch camera button (only for video calls)
          if (isVideoCall)
            CallControlButton(
              icon: Icons.flip_camera_ios,
              label: 'Flip',
              onPressed: notifier.switchCamera,
            ),
        ],
      ),
    );
  }
}

