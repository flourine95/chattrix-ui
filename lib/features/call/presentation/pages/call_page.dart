import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/call_controls_panel.dart';

class CallPage extends ConsumerWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Nền sáng
      body: callState.when(
        idle: () => const Center(child: SizedBox()),
        initiating: (_, __) => const Center(child: CircularProgressIndicator()),
        ringing: (_) => const Center(child: CircularProgressIndicator()),
        connecting: (_, __, ___) => const Center(child: CircularProgressIndicator()),

        // --- TRẠNG THÁI KẾT NỐI ---
        connected:
            (
              connection,
              callType,
              isOutgoing,
              isMuted,
              isVideoEnabled,
              isSpeakerEnabled,
              isFrontCamera,
              remoteUid,
              remoteIsMuted,
              remoteIsVideoEnabled,
            ) {
              final remoteName = isOutgoing ? connection.callInfo.calleeName : connection.callInfo.callerName;
              final remoteAvatar = isOutgoing ? connection.callInfo.calleeAvatar : connection.callInfo.callerAvatar;
              final isVideoCall = callType == CallType.video;

              return Stack(
                children: [
                  // 1. LAYER HIỂN THỊ (Video hoặc Avatar)
                  if (isVideoCall)
                    // Nếu là video call: Hiển thị Video Remote nếu họ bật cam, Avatar nếu tắt
                    Positioned.fill(
                      child: remoteIsVideoEnabled
                          ? _buildVideoContent(ref, remoteUid, remoteName, remoteAvatar)
                          : _buildAudioContent(remoteName, remoteAvatar),
                    )
                  else
                    // Nếu là Audio call: Hiển thị nền sáng + Avatar
                    Positioned.fill(child: _buildAudioContent(remoteName, remoteAvatar)),

                  // 2. LAYER HEADER (Tên + Thời gian + Mute Indicator)
                  Positioned(
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
                                    // Nếu là video call thì text trắng có shadow, audio call thì text đen
                                    color: isVideoCall ? Colors.white : Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    shadows: isVideoCall ? [const Shadow(blurRadius: 4, color: Colors.black54)] : null,
                                  ),
                                ),
                                if (remoteIsMuted) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.mic_off, size: 16, color: Colors.white),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: isVideoCall ? Colors.black26 : Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "00:00", // Cần thêm logic timer vào đây
                                style: GoogleFonts.inter(
                                  color: isVideoCall ? Colors.white : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3. LAYER LOCAL VIDEO (Góc màn hình) - Chỉ hiện khi là Video Call và Camera CỦA MÌNH đang bật
                  if (isVideoCall)
                    Positioned(
                      top: 100,
                      right: 16,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: isVideoEnabled
                              ? const _LocalVideoPreview()
                              : Container(
                                  // Phản hồi khi tắt camera của mình
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.videocam_off, color: Colors.black54),
                                ),
                        ),
                      ),
                    ),

                  // 4. LAYER CONTROLS (Bottom Sheet)
                  Positioned(bottom: 0, left: 0, right: 0, child: CallControlsPanel(callType: callType)),
                ],
              );
            },
        ended: (reason) => Center(child: Text("Ended: $reason")),
        error: (msg) => Center(child: Text(msg)),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAudioContent(String name, String? avatar) {
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
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 30, spreadRadius: 10)],
              ),
              child: UserAvatar(
                displayName: name,
                avatarUrl: avatar,
                radius: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContent(WidgetRef ref, int? remoteUid, String name, String? avatar) {
    final agoraService = ref.watch(agoraServiceProvider);

    // Logic: Nếu đã kết nối và có UID remote -> Hiện video
    // (Lưu ý: Bạn cần thêm state check xem remote user có tắt cam không để hiện avatar thay thế)
    if (remoteUid != null && agoraService.engine != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraService.engine!,
          canvas: VideoCanvas(uid: remoteUid),
          connection: const RtcConnection(channelId: ''), // Điền channelId thực tế của bạn
        ),
      );
    }

    // Fallback: Đang kết nối hoặc chưa có hình
    return Container(
      color: const Color(0xFF2C2C2E), // Nền tối khi chờ video
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
