import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget that displays the remote participant's video stream
/// Uses AgoraVideoView to render the remote video feed
class RemoteVideoView extends ConsumerWidget {
  const RemoteVideoView({super.key, this.remoteUid = 0, this.channelId = ''});

  final int remoteUid;
  final String channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agoraService = ref.watch(agoraServiceProvider);

    return Container(
      color: Colors.black,
      child: Center(
        child: agoraService.isInitialized && agoraService.engine != null
            ? AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: agoraService.engine!,
                  canvas: VideoCanvas(uid: remoteUid),
                  connection: RtcConnection(channelId: channelId),
                ),
              )
            : const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
      ),
    );
  }
}
