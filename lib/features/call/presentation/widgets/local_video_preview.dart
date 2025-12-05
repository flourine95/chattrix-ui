import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/call_state.dart';

/// Optimized local video preview that only rebuilds when video state changes
class LocalVideoPreviewWidget extends ConsumerWidget {
  const LocalVideoPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    // Extract video state only when connected
    bool isVideoEnabled = false;

    callState.when(
      idle: () {},
      initiating: (_, __) {},
      ringing: (_) {},
      connecting: (_, __, ___) {},
      connected: (_, __, ___, ____, video, _____, ______, _______, ________, _________) {
        isVideoEnabled = video;
      },
      ended: (_) {},
      error: (_) {},
    );

    return Positioned(
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
                  color: Colors.grey[300],
                  child: const Icon(Icons.videocam_off, color: Colors.black54),
                ),
        ),
      ),
    );
  }
}

class _LocalVideoPreview extends ConsumerWidget {
  const _LocalVideoPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This widget doesn't need to rebuild - Agora handles the preview
    return Container(
      color: Colors.black,
      // TODO: Add AgoraVideoView for local preview if needed
      child: const Center(
        child: Icon(Icons.person, color: Colors.white54, size: 40),
      ),
    );
  }
}

