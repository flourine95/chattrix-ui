import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_control_state_providers.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_timer_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/pip_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/call_controls_panel.dart';

class CallPage extends ConsumerWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main call view
          callState.map(
            idle: (_) => const Center(child: SizedBox()),
            initiating: (_) => const Center(child: CircularProgressIndicator()),
            ringing: (_) => const Center(child: CircularProgressIndicator()),
            connecting: (_) => const Center(child: CircularProgressIndicator()),
            connected: (state) {
              final remoteName = state.isOutgoing
                  ? state.connection.callInfo.calleeName
                  : state.connection.callInfo.callerName;
              final remoteAvatar = state.isOutgoing
                  ? state.connection.callInfo.calleeAvatar
                  : state.connection.callInfo.callerAvatar;

              // Key này giữ widget stable khi state fields thay đổi
              return _ConnectedCallView(
                key: const ValueKey('connected_call'),
                callType: state.callType,
                remoteName: remoteName,
                remoteAvatar: remoteAvatar,
              );
            },
            ended: (state) => Center(child: Text("Ended: ${state.reason}")),
            error: (state) => Center(child: Text(state.message)),
          ),
        ],
      ),
    );
  }
}

// Widget riêng cho connected state - tách biệt để tối ưu rebuild
class _ConnectedCallView extends ConsumerWidget {
  final CallType callType;
  final String remoteName;
  final String? remoteAvatar;

  const _ConnectedCallView({super.key, required this.callType, required this.remoteName, required this.remoteAvatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVideoCall = callType == CallType.video;

    return Stack(
      children: [
        // 1. LAYER HIỂN THỊ (Video hoặc Avatar)
        if (isVideoCall)
          _RemoteVideoLayer(remoteName: remoteName, remoteAvatar: remoteAvatar)
        else
          Positioned.fill(
            child: _AudioContentView(name: remoteName, avatar: remoteAvatar),
          ),

        // 2. LAYER MINIMIZE BUTTON (Top Left)
        const _MinimizeButton(),

        // 3. LAYER HEADER (Tên + Thời gian + Mute Indicator)
        _CallHeader(remoteName: remoteName, isVideoCall: isVideoCall),

        // 4. LAYER LOCAL VIDEO (Góc màn hình)
        if (isVideoCall) const _LocalVideoLayer(),

        // 5. LAYER CONTROLS (Bottom Sheet)
        Positioned(bottom: 0, left: 0, right: 0, child: CallControlsPanel(callType: callType)),
      ],
    );
  }
}

// Remote Video Layer - Chỉ rebuild khi remoteIsVideoEnabled hoặc remoteUid thay đổi
class _RemoteVideoLayer extends ConsumerWidget {
  final String remoteName;
  final String? remoteAvatar;

  const _RemoteVideoLayer({required this.remoteName, required this.remoteAvatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoEnabled = ref.watch(remoteIsVideoEnabledStateProvider);
    final uid = ref.watch(remoteUidStateProvider);

    return Positioned.fill(
      child: videoEnabled
          ? _RemoteVideoView(remoteUid: uid)
          : _AudioContentView(name: remoteName, avatar: remoteAvatar),
    );
  }
}

// Call Header - Chỉ rebuild khi remoteIsMuted thay đổi
class _CallHeader extends ConsumerWidget {
  final String remoteName;
  final bool isVideoCall;

  const _CallHeader({required this.remoteName, required this.isVideoCall});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteMuted = ref.watch(remoteIsMutedStateProvider);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    remoteName,
                    style: GoogleFonts.inter(
                      color: isVideoCall ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      shadows: isVideoCall ? [const Shadow(blurRadius: 4, color: Colors.black54)] : null,
                    ),
                  ),
                  if (remoteMuted) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.mic_off, size: 16, color: Colors.white),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              _CallTimer(isVideoCall: isVideoCall),
            ],
          ),
        ),
      ),
    );
  }
}

// Local Video Layer - Chỉ rebuild khi isVideoEnabled thay đổi
class _LocalVideoLayer extends ConsumerWidget {
  const _LocalVideoLayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoEnabled = ref.watch(isVideoEnabledStateProvider);

    return Positioned(
      top: 100,
      right: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 100,
          height: 150,
          child: videoEnabled
              ? const _LocalVideoPreview()
              : Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.videocam_off, color: Colors.black54),
                ),
        ),
      ),
    );
  }
}

// Call Timer - Chỉ rebuild khi timer thay đổi
class _CallTimer extends ConsumerWidget {
  final bool isVideoCall;

  const _CallTimer({required this.isVideoCall});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(callTimerProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isVideoCall ? Colors.black26 : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(time, style: GoogleFonts.inter(color: isVideoCall ? Colors.white : Colors.black54, fontSize: 12)),
    );
  }
}

// Audio Content View - Widget tĩnh, không rebuild
class _AudioContentView extends StatelessWidget {
  final String name;
  final String? avatar;

  const _AudioContentView({required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 30, spreadRadius: 10)],
              ),
              child: UserAvatar(displayName: name, avatarUrl: avatar, radius: 80),
            ),
          ],
        ),
      ),
    );
  }
}

// Remote Video View - Chỉ rebuild khi remoteUid thay đổi
class _RemoteVideoView extends ConsumerWidget {
  final int? remoteUid;

  const _RemoteVideoView({required this.remoteUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraServiceProvider);

    if (remoteUid != null && agoraService.engine != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraService.engine!,
          canvas: VideoCanvas(uid: remoteUid),
          connection: const RtcConnection(channelId: ''),
        ),
      );
    }

    // Fallback: Đang kết nối hoặc chưa có hình
    return Container(
      color: const Color(0xFF2C2C2E),
      child: const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}

class _LocalVideoPreview extends ConsumerWidget {
  const _LocalVideoPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraServiceProvider);
    if (agoraService.engine == null) return const SizedBox();

    return AgoraVideoView(
      controller: VideoViewController(rtcEngine: agoraService.engine!, canvas: const VideoCanvas(uid: 0)),
    );
  }
}

// Minimize Button - Góc trên bên trái
class _MinimizeButton extends ConsumerWidget {
  const _MinimizeButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 0,
      left: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {
                debugPrint('[PiP] Minimize button tapped');

                // Enable PiP mode first (synchronous)
                ref.read(pipStateProvider.notifier).enable();
                debugPrint('[PiP] PiP mode enabled');

                // Navigate back to previous page
                // The redirect guard will allow navigation because isPipMode is now true
                if (context.mounted) {
                  debugPrint('[PiP] Navigating back to previous page');
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    // If can't pop, go to home
                    context.go('/');
                  }
                } else {
                  debugPrint('[PiP] Context not mounted, cannot navigate');
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
