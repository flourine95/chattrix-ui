import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IncomingCallPage extends ConsumerWidget {
  const IncomingCallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: callState.when(
        idle: () => const SizedBox(),
        initiating: (_, __, ___, ____) => const SizedBox(),
        ringing: (invitation) => _buildRingingView(
          context,
          ref,
          callerName: invitation.callerName,
          callerAvatar: invitation.callerAvatar,
          callType: invitation.callType,
        ),
        connecting: (_, _, _) => const SizedBox(),
        connected: (_, _, _, _, _, _, _, _, _, _) => const SizedBox(),
        ended: (_) => const SizedBox(),
        error: (message) => Center(child: Text(message)),
      ),
    );
  }

  Widget _buildRingingView(
    BuildContext context,
    WidgetRef ref, {
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) {
    return Container(
      width: double.infinity, // FIX: Đảm bảo container nền full width
      height: double.infinity, // FIX: Đảm bảo container nền full height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF), // Trắng
            Color(0xFFEEF2F6), // Xám xanh rất nhạt
          ],
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity, // FIX: Quan trọng! Ép Column phải rộng full màn hình
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center, // FIX: Căn giữa các widget con theo chiều ngang
            children: [
              const Spacer(flex: 1),

              // --- Avatar Section ---
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 12)),
                  ],
                ),
                child: UserAvatar(displayName: callerName, avatarUrl: callerAvatar, radius: 80),
              ),
              const SizedBox(height: 32),

              // --- Name Info ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  callerName,
                  textAlign: TextAlign.center, // Căn giữa text nếu tên quá dài xuống dòng
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // --- Call Type Badge ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      callType == CallType.video ? Icons.videocam_rounded : Icons.phone_in_talk_rounded,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      callType == CallType.video ? 'Incoming Video Call' : 'Incoming Audio Call',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // --- Action Buttons ---
              Padding(
                padding: const EdgeInsets.only(bottom: 60, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Nút Từ chối
                    _ActionColumn(
                      icon: Icons.call_end,
                      label: "Decline",
                      color: const Color(0xFFFF3B30), // Đỏ
                      onTap: () => ref.read(callProvider.notifier).rejectCall(),
                    ),

                    // Nút Nhận cuộc gọi
                    _ActionColumn(
                      icon: callType == CallType.video ? Icons.videocam : Icons.call,
                      label: "Accept",
                      color: const Color(0xFF34C759), // Xanh lá
                      onTap: () => ref.read(callProvider.notifier).acceptCall(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget phụ trợ cho nút bấm (giống Zalo/iOS)
class _ActionColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionColumn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dùng GestureDetector thay vì InkWell để tránh hiệu ứng ripple đen nếu không muốn
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}
