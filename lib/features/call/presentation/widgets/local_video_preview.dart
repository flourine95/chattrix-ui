import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget that displays the local user's video preview
/// Positioned as an overlay on top of the remote video
class LocalVideoPreview extends ConsumerWidget {
  const LocalVideoPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraServiceProvider);

    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: agoraService.isInitialized && agoraService.engine != null
            ? AgoraVideoView(
                controller: VideoViewController(rtcEngine: agoraService.engine!, canvas: const VideoCanvas(uid: 0)),
              )
            : const Center(child: Icon(Icons.videocam_off, color: Colors.white54, size: 32)),
      ),
    );
  }
}
