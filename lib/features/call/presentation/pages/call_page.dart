import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_control_state_providers.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_timer_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/pip_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/chat_view_helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
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
              // Get conversation info for group calls
              final callInfo = state.connection.callInfo;
              final currentUserId = ref.watch(currentUserProvider)?.id;
              final conversationId = callInfo.conversationId;
              
              // Get conversation to check if it's a group
              final conversationsAsync = ref.watch(conversationsProvider);
              final conversation = conversationsAsync.value?.lookup(conversationId);
              
              final isGroupCall = conversation?.type.name == 'group';
              
              String displayName;
              String? displayAvatar;
              
              if (isGroupCall && conversation != null) {
                // Group call: Show group name and avatar
                displayName = conversation.name ?? 'Group Call';
                displayAvatar = conversation.avatar;
              } else {
                // 1-1 call: Show remote participant
                if (currentUserId != null) {
                  final remoteParticipant = callInfo.participants.firstWhere(
                    (p) => p.userId != currentUserId,
                    orElse: () => callInfo.participants.first,
                  );
                  displayName = remoteParticipant.fullName;
                  displayAvatar = remoteParticipant.avatar;
                } else {
                  displayName = callInfo.callerName;
                  displayAvatar = callInfo.callerAvatar;
                }
              }

              return _ConnectedCallView(
                key: const ValueKey('connected_call'),
                callType: state.callType,
                displayName: displayName,
                displayAvatar: displayAvatar,
                callInfo: callInfo,
                isGroupCall: isGroupCall,
                currentUserId: currentUserId,
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
  final String displayName;
  final String? displayAvatar;
  final dynamic callInfo;
  final bool isGroupCall;
  final int? currentUserId;

  const _ConnectedCallView({
    super.key,
    required this.callType,
    required this.displayName,
    required this.displayAvatar,
    required this.callInfo,
    required this.isGroupCall,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVideoCall = callType == CallType.video;

    return Stack(
      children: [
        // 1. LAYER HIỂN THỊ (Video hoặc Avatar)
        if (isVideoCall)
          _RemoteVideoLayer(displayName: displayName, displayAvatar: displayAvatar)
        else
          Positioned.fill(
            child: _AudioContentView(name: displayName, avatar: displayAvatar),
          ),

        // 2. LAYER MINIMIZE BUTTON (Top Left)
        const _MinimizeButton(),

        // 3. LAYER HEADER (Tên + Thời gian + Participants)
        _CallHeader(
          displayName: displayName,
          isVideoCall: isVideoCall,
          isGroupCall: isGroupCall,
          callInfo: callInfo,
          currentUserId: currentUserId,
        ),

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
  final String displayName;
  final String? displayAvatar;

  const _RemoteVideoLayer({required this.displayName, required this.displayAvatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoEnabled = ref.watch(remoteIsVideoEnabledStateProvider);
    final uid = ref.watch(remoteUidStateProvider);

    return Positioned.fill(
      child: videoEnabled
          ? _RemoteVideoView(remoteUid: uid)
          : _AudioContentView(name: displayName, avatar: displayAvatar),
    );
  }
}

// Call Header - Hiển thị tên + participants list cho group call
class _CallHeader extends ConsumerWidget {
  final String displayName;
  final bool isVideoCall;
  final bool isGroupCall;
  final dynamic callInfo;
  final int? currentUserId;

  const _CallHeader({
    required this.displayName,
    required this.isVideoCall,
    required this.isGroupCall,
    required this.callInfo,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteMuted = ref.watch(remoteIsMutedStateProvider);
    
    // Get active participants (JOINED status)
    final activeParticipants = callInfo.participants
        .where((p) => p.status.name == 'JOINED')
        .toList();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              // Tên conversation/người
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayName,
                    style: GoogleFonts.inter(
                      color: isVideoCall ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      shadows: isVideoCall ? [const Shadow(blurRadius: 4, color: Colors.black54)] : null,
                    ),
                  ),
                  if (!isGroupCall && remoteMuted) ...[
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
              
              // Participants list for group call
              if (isGroupCall && activeParticipants.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isVideoCall 
                        ? Colors.black.withValues(alpha: 0.5)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${activeParticipants.length} người trong cuộc gọi',
                        style: GoogleFonts.inter(
                          color: isVideoCall ? Colors.white : Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: activeParticipants.map((p) {
                          final isCurrentUser = p.userId == currentUserId;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isVideoCall
                                  ? Colors.white.withValues(alpha: 0.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: isCurrentUser
                                  ? Border.all(color: Colors.green, width: 2)
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UserAvatar(
                                  displayName: p.fullName,
                                  avatarUrl: p.avatar,
                                  radius: 10,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isCurrentUser ? 'Bạn' : p.fullName,
                                  style: GoogleFonts.inter(
                                    color: isVideoCall ? Colors.white : Colors.black87,
                                    fontSize: 11,
                                    fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
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
