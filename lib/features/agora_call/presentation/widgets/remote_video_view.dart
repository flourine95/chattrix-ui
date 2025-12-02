import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget to display remote user's video stream
/// Uses Agora's AgoraVideoView to render the remote video
/// Requirement 5.1: Display remote user's video stream for video calls
class RemoteVideoView extends HookConsumerWidget {
  final int remoteUid;

  const RemoteVideoView({super.key, required this.remoteUid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraEngineServiceProvider);
    final engine = agoraService.engine;

    if (engine == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text('Video unavailable', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(channelId: ''),
      ),
    );
  }
}
