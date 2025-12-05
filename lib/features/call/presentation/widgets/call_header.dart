import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/call_state.dart';

/// Optimized header that only rebuilds when remote state changes
class CallHeader extends ConsumerWidget {
  final String remoteName;
  final CallType callType;

  const CallHeader({
    super.key,
    required this.remoteName,
    required this.callType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    // Extract remote mute state only when connected
    bool remoteIsMuted = false;

    callState.when(
      idle: () {},
      initiating: (_, __) {},
      ringing: (_) {},
      connecting: (_, __, ___) {},
      connected: (_, __, ___, ____, _____, ______, _______, ________, muted, _________) {
        remoteIsMuted = muted;
      },
      ended: (_) {},
      error: (_) {},
    );

    final isVideoCall = callType == CallType.video;

    return SafeArea(
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
                if (remoteIsMuted) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.mic_off,
                      size: 16,
                      color: Colors.white,
                    ),
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
                "00:00", // TODO: Add timer
                style: GoogleFonts.inter(
                  color: isVideoCall ? Colors.white : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

