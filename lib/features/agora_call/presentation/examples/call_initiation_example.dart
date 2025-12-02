// ignore_for_file: unused_element

import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_initiation_helper.dart';
import 'package:chattrix_ui/features/agora_call/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Example demonstrating how to integrate call functionality
///
/// This file shows various ways to add call buttons and initiate calls
/// in your application screens.
class CallInitiationExample extends ConsumerWidget {
  const CallInitiationExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Example user data
    const calleeId = 123;
    const calleeName = 'John Doe';

    return Scaffold(
      appBar: AppBar(title: const Text('Call Integration Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Example 1: Using CallButton widget with specific call type
          _ExampleSection(
            title: 'Example 1: Direct Call Buttons',
            description: 'Use CallButton widget with specific call type',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.audio, tooltip: 'Audio call'),
                SizedBox(width: 16),
                CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.video, tooltip: 'Video call'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Example 2: Using CallButton with dialog
          _ExampleSection(
            title: 'Example 2: Call Button with Type Selection',
            description: 'Shows dialog to select audio or video call',
            child: Center(
              child: CallButton(
                calleeId: calleeId,
                calleeName: calleeName,
                // callType: null, // Shows dialog
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Example 3: Manual call initiation with helper
          _ExampleSection(
            title: 'Example 3: Manual Call Initiation',
            description: 'Use CallInitiationHelper for custom buttons',
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    CallInitiationHelper.initiateCall(
                      context: context,
                      ref: ref,
                      calleeId: calleeId,
                      calleeName: calleeName,
                      callType: CallType.audio,
                    );
                  },
                  icon: const Icon(Icons.call),
                  label: const Text('Start Audio Call'),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    CallInitiationHelper.initiateCall(
                      context: context,
                      ref: ref,
                      calleeId: calleeId,
                      calleeName: calleeName,
                      callType: CallType.video,
                    );
                  },
                  icon: const Icon(Icons.videocam),
                  label: const Text('Start Video Call'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Example 4: Call initiation with dialog
          _ExampleSection(
            title: 'Example 4: Call with Type Selection Dialog',
            description: 'Shows dialog to let user choose call type',
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  CallInitiationHelper.initiateCallWithDialog(
                    context: context,
                    ref: ref,
                    calleeId: calleeId,
                    calleeName: calleeName,
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call (Choose Type)'),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Example 5: AppBar integration
          _ExampleSection(
            title: 'Example 5: AppBar Integration',
            description: 'How to add call buttons to AppBar',
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppBar(
                title: const Text('Chat with John'),
                actions: const [
                  CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.audio),
                  CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.video),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Example 6: List item integration
          _ExampleSection(
            title: 'Example 6: Contact List Integration',
            description: 'How to add call buttons to list items',
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const CircleAvatar(child: Text('J')),
                title: const Text('John Doe'),
                subtitle: const Text('Active now'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.audio, iconSize: 18),
                    CallButton(calleeId: calleeId, calleeName: calleeName, callType: CallType.video, iconSize: 18),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Implementation notes
          const _ImplementationNotes(),
        ],
      ),
    );
  }
}

class _ExampleSection extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _ExampleSection({required this.title, required this.description, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _ImplementationNotes extends StatelessWidget {
  const _ImplementationNotes();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: theme.colorScheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Implementation Notes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '• Permissions are automatically requested before initiating calls\n'
              '• Loading indicators are shown during call setup\n'
              '• Error messages are displayed if call fails\n'
              '• Navigation to call screens is handled automatically\n'
              '• Works for both audio and video calls\n'
              '• Supports permission rationale and settings navigation',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
