import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Page displayed when initiating an outgoing call
class OutgoingCallPage extends ConsumerWidget {
  const OutgoingCallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: callState.when(
          idle: () => const Center(
            child: Text(
              'Invalid call state',
              style: TextStyle(color: Colors.white),
            ),
          ),
          initiating: (calleeId, callType) => _buildInitiatingView(callType),
          ringing: (invitation) => const SizedBox.shrink(),
          connecting: (connection, callType, isOutgoing) {
            if (isOutgoing) {
              return _buildConnectingView(
                connection.callInfo.calleeName,
                connection.callInfo.calleeAvatar,
                callType,
                ref,
              );
            }
            return const SizedBox.shrink();
          },
          connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled,
                  isSpeakerEnabled, isFrontCamera, remoteUid) =>
              const SizedBox.shrink(),
          ended: (reason) => const Center(
            child: Text(
              'Call ended',
              style: TextStyle(color: Colors.white),
            ),
          ),
          error: (message) => Center(
            child: Text(
              'Error: $message',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitiatingView(CallType callType) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 24),
          Text(
            'Initiating ${callType == CallType.video ? 'video' : 'audio'} call...',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectingView(
    String calleeName,
    String? calleeAvatar,
    CallType callType,
    WidgetRef ref,
  ) {
    return Stack(
      children: [
        // User avatar
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    calleeAvatar != null ? NetworkImage(calleeAvatar) : null,
                child: calleeAvatar == null
                    ? Text(
                        calleeName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 64),
                      )
                    : null,
              ),
              const SizedBox(height: 32),
              Text(
                calleeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Calling...',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    callType == CallType.video
                        ? Icons.videocam
                        : Icons.phone,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    callType == CallType.video ? 'Video Call' : 'Voice Call',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cancel button
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () => ref.read(callProvider.notifier).endCall(),
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

