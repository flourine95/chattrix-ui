import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/call_models.dart';
import '../providers/call_provider.dart';

class CallScreen extends ConsumerStatefulWidget {
  final CallInvitation? invitation;
  final int? calleeId;
  final CallType callType;

  const CallScreen({
    super.key,
    this.invitation,
    this.calleeId,
    required this.callType,
  });

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initCall();
    });
  }

  void _initCall() {
    if (widget.invitation != null) {
      // Incoming call - show accept/reject UI
      appLogger.i('Incoming call from ${widget.invitation!.callerName}');
    } else if (widget.calleeId != null) {
      // Outgoing call - initiate
      ref.read(callControllerProvider.notifier).initiateCall(
            widget.calleeId!,
            widget.callType,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callControllerProvider);
    final agoraService = ref.watch(agoraServiceProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Video views
            if (widget.callType == CallType.video) ...[
              // Remote video (full screen)
              if (callState.remoteUid != null)
                AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: agoraService.engine!,
                    canvas: VideoCanvas(uid: callState.remoteUid),
                    connection: RtcConnection(
                      channelId: callState.connection?.callInfo.channelId ?? '',
                    ),
                  ),
                ),

              // Local video (small overlay)
              Positioned(
                top: 40,
                right: 16,
                child: Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: agoraService.engine!,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                ),
              ),
            ],

            // Call info overlay
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: _buildCallInfo(callState),
            ),

            // Controls
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: _buildControls(callState),
            ),

            // Incoming call overlay
            if (widget.invitation != null && callState.status == CallStateStatus.ringing)
              _buildIncomingCallOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildCallInfo(CallState callState) {
    String title = 'Connecting...';
    String subtitle = '';

    if (widget.invitation != null) {
      title = widget.invitation!.callerName;
      subtitle = widget.callType == CallType.video ? 'Video call' : 'Audio call';
    } else if (callState.connection != null) {
      final callee = callState.connection!.callInfo.callee;
      title = callee.name;
      subtitle = _getStatusText(callState.status);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(CallState callState) {
    if (widget.invitation != null && callState.status == CallStateStatus.ringing) {
      return const SizedBox.shrink(); // Hide controls during incoming call
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Mute button
          _buildControlButton(
            icon: callState.isMuted ? Icons.mic_off : Icons.mic,
            onPressed: () {
              ref.read(callControllerProvider.notifier).toggleMicrophone();
            },
            backgroundColor: callState.isMuted ? Colors.red : Colors.white24,
          ),

          // Camera button (video only)
          if (widget.callType == CallType.video)
            _buildControlButton(
              icon: callState.isCameraOn ? Icons.videocam : Icons.videocam_off,
              onPressed: () {
                ref.read(callControllerProvider.notifier).toggleCamera();
              },
              backgroundColor: callState.isCameraOn ? Colors.white24 : Colors.red,
            ),

          // End call button
          _buildControlButton(
            icon: Icons.call_end,
            onPressed: () async {
              await ref.read(callControllerProvider.notifier).endCall();
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            backgroundColor: Colors.red,
            size: 64,
          ),

          // Switch camera (video only)
          if (widget.callType == CallType.video)
            _buildControlButton(
              icon: Icons.flip_camera_ios,
              onPressed: () {
                ref.read(callControllerProvider.notifier).switchCamera();
              },
              backgroundColor: Colors.white24,
            ),

          // Speaker button
          _buildControlButton(
            icon: callState.isSpeakerOn ? Icons.volume_up : Icons.volume_off,
            onPressed: () {
              ref.read(callControllerProvider.notifier).toggleSpeaker();
            },
            backgroundColor: callState.isSpeakerOn ? Colors.white24 : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white24,
    double size = 56,
  }) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildIncomingCallOverlay() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              backgroundImage: widget.invitation!.callerAvatar != null
                  ? NetworkImage(widget.invitation!.callerAvatar!)
                  : null,
              child: widget.invitation!.callerAvatar == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 24),

            // Caller name
            Text(
              widget.invitation!.callerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Call type
            Text(
              widget.callType == CallType.video ? 'Video call' : 'Audio call',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 60),

            // Accept/Reject buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reject button
                Column(
                  children: [
                    Material(
                      color: Colors.red,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () async {
                          await ref.read(callControllerProvider.notifier).rejectCall(
                                widget.invitation!.callId,
                                RejectReason.declined,
                              );
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 72,
                          height: 72,
                          child: Icon(Icons.call_end, color: Colors.white, size: 36),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Decline',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(width: 80),

                // Accept button
                Column(
                  children: [
                    Material(
                      color: Colors.green,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(callControllerProvider.notifier)
                              .acceptCall(widget.invitation!);
                        },
                        customBorder: const CircleBorder(),
                        child: const SizedBox(
                          width: 72,
                          height: 72,
                          child: Icon(Icons.call, color: Colors.white, size: 36),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(CallStateStatus status) {
    switch (status) {
      case CallStateStatus.initiating:
        return 'Initiating...';
      case CallStateStatus.ringing:
        return 'Ringing...';
      case CallStateStatus.connecting:
        return 'Connecting...';
      case CallStateStatus.connected:
        return 'Connected';
      case CallStateStatus.ended:
        return 'Call ended';
      default:
        return '';
    }
  }
}

