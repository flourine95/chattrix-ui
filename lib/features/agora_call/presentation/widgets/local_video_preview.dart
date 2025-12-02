import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget to display local camera preview
/// Shows the user's own video feed in a small overlay
/// Requirement 5.1: Display local video preview for video calls
class LocalVideoPreview extends HookConsumerWidget {
  const LocalVideoPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraEngineServiceProvider);
    final engine = agoraService.engine;

    if (engine == null) {
      return Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24, width: 2),
        ),
        child: const Center(
          child: Text(
            'Preview unavailable',
            style: TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: AgoraVideoView(
        controller: VideoViewController(rtcEngine: engine, canvas: const VideoCanvas(uid: 0)),
      ),
    );
  }
}
