import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/call_models.dart';
import '../screens/call_screen.dart';

/// Example: User list screen with call buttons
class UsersListExample extends ConsumerWidget {
  const UsersListExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock users list
    final users = [
      {'id': 1, 'name': 'John Doe', 'avatar': null},
      {'id': 2, 'name': 'Jane Smith', 'avatar': null},
      {'id': 3, 'name': 'Bob Johnson', 'avatar': null},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user['name'].toString()[0]),
            ),
            title: Text(user['name'] as String),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Audio call button
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _initiateCall(
                    context,
                    user['id'] as int,
                    CallType.audio,
                  ),
                ),
                // Video call button
                IconButton(
                  icon: const Icon(Icons.video_call),
                  onPressed: () => _initiateCall(
                    context,
                    user['id'] as int,
                    CallType.video,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _initiateCall(BuildContext context, int calleeId, CallType callType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          calleeId: calleeId,
          callType: callType,
        ),
      ),
    );
  }
}

/// Example: WebSocket message handler
class WebSocketHandlerExample {
  final WidgetRef ref;
  final BuildContext context;

  WebSocketHandlerExample(this.ref, this.context);

  void handleMessage(Map<String, dynamic> message) {
    final type = message['type'] as String?;
    final payload = message['payload'] as Map<String, dynamic>?;

    if (payload == null) return;

    switch (type) {
      case 'call.incoming':
        _handleIncomingCall(payload);
        break;

      case 'call.accepted':
        _handleCallAccepted(payload);
        break;

      case 'call.rejected':
        _handleCallRejected(payload);
        break;

      case 'call.ended':
        _handleCallEnded(payload);
        break;

      case 'call.timeout':
        _handleCallTimeout(payload);
        break;
    }
  }

  void _handleIncomingCall(Map<String, dynamic> payload) {
    final invitation = CallInvitation.fromJson(payload);

    // Show incoming call screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          invitation: invitation,
          callType: invitation.callType,
        ),
      ),
    );

    // Or show notification with accept/reject buttons
    _showIncomingCallNotification(invitation);
  }

  void _handleCallAccepted(Map<String, dynamic> payload) {
    // Call was accepted by the other party
    // The CallController will handle this automatically if it's listening
  }

  void _handleCallRejected(Map<String, dynamic> payload) {
    final reject = CallReject.fromJson(payload);

    // Show message to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call was ${reject.reason.name}'),
        backgroundColor: Colors.red,
      ),
    );

    // Close call screen if open
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _handleCallEnded(Map<String, dynamic> payload) {
    final end = CallEnd.fromJson(payload);

    // Show call duration
    final duration = Duration(seconds: end.durationSeconds);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call ended. Duration: ${_formatDuration(duration)}'),
      ),
    );

    // Close call screen if open
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _handleCallTimeout(Map<String, dynamic> payload) {
    final timeout = CallTimeout.fromJson(payload);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Call timeout: ${timeout.reason}'),
        backgroundColor: Colors.orange,
      ),
    );

    // Close call screen if open
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _showIncomingCallNotification(CallInvitation invitation) {
    // TODO: Implement with flutter_local_notifications
    // Show heads-up notification with accept/reject buttons
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

/// Example: Setting up the provider with Dio
///
/// In your app's provider setup file:
/// ```dart
/// import 'package:dio/dio.dart';
/// import 'package:hooks_riverpod/hooks_riverpod.dart';
/// import 'package:chattrix_ui/core/network/dio_client.dart';
/// import 'package:chattrix_ui/core/constants/api_constants.dart';
///
/// final dioProvider = Provider<Dio>((ref) {
///   final dio = DioClient.createDio(baseUrl: ApiConstants.baseUrl);
///   // Add your interceptors here
///   return dio;
/// });
///
/// // Then update call_provider.dart:
/// final callApiServiceProvider = Provider<CallApiService>((ref) {
///   final dio = ref.watch(dioProvider);
///   return CallApiService(dio);
/// });
/// ```

/// Example: Programmatic call control
class CallControlExample extends ConsumerWidget {
  const CallControlExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Control Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _testAudioCall(ref),
              child: const Text('Test Audio Call'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _testVideoCall(ref),
              child: const Text('Test Video Call'),
            ),
          ],
        ),
      ),
    );
  }

  void _testAudioCall(WidgetRef ref) {
    // Initiate audio call to user ID 123
    // ref.read(callControllerProvider.notifier).initiateCall(
    //   calleeId: 123,
    //   callType: CallType.audio,
    // );
  }

  void _testVideoCall(WidgetRef ref) {
    // Initiate video call to user ID 456
    // ref.read(callControllerProvider.notifier).initiateCall(
    //   calleeId: 456,
    //   callType: CallType.video,
    // );
  }
}

