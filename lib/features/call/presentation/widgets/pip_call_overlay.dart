import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_control_state_providers.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_timer_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/pip_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Picture-in-Picture floating call overlay
class PipCallOverlay extends ConsumerStatefulWidget {
  final CallType callType;
  final String remoteName;
  final String? remoteAvatar;
  final String channelId;

  const PipCallOverlay({
    super.key,
    required this.callType,
    required this.remoteName,
    required this.remoteAvatar,
    required this.channelId,
  });

  @override
  ConsumerState<PipCallOverlay> createState() => _PipCallOverlayState();
}

class _PipCallOverlayState extends ConsumerState<PipCallOverlay> {
  late double _xPosition;
  late double _yPosition;
  double _dragStartX = 0;
  double _dragStartY = 0;

  @override
  void initState() {
    super.initState();
    final position = ref.read(pipPositionProvider);
    _xPosition = position.x;
    _yPosition = position.y;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final pipWidth = 120.0;
    final pipHeight = 160.0;

    return Positioned(
      left: _xPosition,
      top: _yPosition,
      child: GestureDetector(
        onPanStart: (details) {
          _dragStartX = details.globalPosition.dx - _xPosition;
          _dragStartY = details.globalPosition.dy - _yPosition;
        },
        onPanUpdate: (details) {
          setState(() {
            _xPosition = (details.globalPosition.dx - _dragStartX).clamp(0, screenWidth - pipWidth);
            _yPosition = (details.globalPosition.dy - _dragStartY).clamp(0, screenHeight - pipHeight);
          });
        },
        onPanEnd: (_) {
          ref.read(pipPositionProvider.notifier).update(_xPosition, _yPosition);
        },
        onTap: () {
          debugPrint('[PiP] Overlay tapped - expanding to full screen');
          ref.read(pipStateProvider.notifier).expandToFullScreen('/call');
        },
        child: Container(
          width: pipWidth,
          height: pipHeight,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 2)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Video or Avatar
                if (widget.callType == CallType.video)
                  _PipVideoView(channelId: widget.channelId)
                else
                  _PipAudioView(name: widget.remoteName, avatar: widget.remoteAvatar),

                // Top bar with timer and close
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _PipTimer(),
                        GestureDetector(
                          onTap: () {
                            ref.read(callProvider.notifier).endCall();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.8), shape: BoxShape.circle),
                            child: const Icon(Icons.call_end, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Mute indicator
                _PipMuteIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PipTimer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(callTimerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8)),
      child: Text(
        time,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _PipMuteIndicator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muted = ref.watch(isMutedStateProvider);

    if (!muted) return const SizedBox.shrink();

    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.8), shape: BoxShape.circle),
        child: const Icon(Icons.mic_off, size: 14, color: Colors.white),
      ),
    );
  }
}

class _PipVideoView extends ConsumerWidget {
  final String channelId;

  const _PipVideoView({required this.channelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteUid = ref.watch(remoteUidStateProvider);
    final remoteVideoEnabled = ref.watch(remoteIsVideoEnabledStateProvider);
    final agoraService = ref.watch(agoraServiceProvider);

    if (remoteVideoEnabled && remoteUid != null && agoraService.engine != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraService.engine!,
          canvas: VideoCanvas(uid: remoteUid),
          connection: RtcConnection(channelId: channelId),
        ),
      );
    }

    return Container(
      color: const Color(0xFF2C2C2E),
      child: const Center(child: Icon(Icons.videocam_off, color: Colors.white54, size: 32)),
    );
  }
}

class _PipAudioView extends StatelessWidget {
  final String name;
  final String? avatar;

  const _PipAudioView({required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: UserAvatar(displayName: name, avatarUrl: avatar, radius: 30),
      ),
    );
  }
}
