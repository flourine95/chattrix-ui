import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IncomingCallDialog extends ConsumerWidget {
  final CallInvitation invitation;

  const IncomingCallDialog({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callType = invitation.callType;
    final isVideoCall = callType == CallType.video;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: invitation.callerAvatar != null
                  ? NetworkImage(invitation.callerAvatar!)
                  : null,
              child: invitation.callerAvatar == null
                  ? Text(
                      invitation.callerName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 40),
                    )
                  : null,
            ),
            const SizedBox(height: 16),

            // Caller name
            Text(
              invitation.callerName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Call type
            Text(
              'Incoming ${isVideoCall ? 'Video' : 'Audio'} Call',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Decline button
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'decline',
                      onPressed: () {
                        ref.read(callProvider.notifier).rejectCall();
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.call_end),
                    ),
                    const SizedBox(height: 8),
                    const Text('Decline'),
                  ],
                ),

                // Accept button
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'accept',
                      onPressed: () {
                        ref.read(callProvider.notifier).acceptCall();
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.green,
                      child: Icon(isVideoCall ? Icons.videocam : Icons.call),
                    ),
                    const SizedBox(height: 8),
                    const Text('Accept'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

