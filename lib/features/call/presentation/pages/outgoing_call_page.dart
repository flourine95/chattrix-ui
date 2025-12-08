import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OutgoingCallPage extends ConsumerWidget {
  const OutgoingCallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: callState.when(
        idle: () => const SizedBox(),
        initiating: (_, callType) => _buildView(context, ref, "Connecting...", null, callType),
        ringing: (_) => const SizedBox(),
        connecting: (connection, callType, isOutgoing) {
          if (isOutgoing) {
            return _buildView(
              context,
              ref,
              connection.callInfo.calleeName,
              connection.callInfo.calleeAvatar,
              callType,
            );
          }
          return const SizedBox();
        },
        connected: (_, _, _, _, _, _, _, _, _, _) => const SizedBox(),
        ended: (_) => const SizedBox(),
        error: (msg) => Center(child: Text(msg)),
      ),
    );
  }

  Widget _buildView(
      BuildContext context,
      WidgetRef ref,
      String name,
      String? avatar,
      CallType callType,
      ) {
    // 1. SizedBox.expand: Ép container chiếm toàn bộ màn hình
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF5F7FA)],
          ),
        ),
        child: SafeArea(
          // 2. SizedBox width infinity: Ép Column phải rộng bằng màn hình
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
              crossAxisAlignment: CrossAxisAlignment.center, // QUAN TRỌNG: Căn giữa theo chiều ngang
              children: [
                const Spacer(flex: 1),

                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.1), width: 1),
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: avatar != null ? NetworkImage(avatar) : null,
                    child: avatar == null
                        ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: GoogleFonts.inter(fontSize: 60, color: Colors.black38),
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                // Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Status Text
                Text(
                  'Calling...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(flex: 2),

                // Cancel Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => ref.read(callProvider.notifier).endCall(),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.call_end, color: Colors.white, size: 32),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}