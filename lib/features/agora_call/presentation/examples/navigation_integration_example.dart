/// Example: Navigation Integration
///
/// This file demonstrates how the navigation integration works for the Agora call feature.
/// It shows the complete flow from initiating a call to ending it, with automatic navigation.
///
/// Requirements: 1.5, 2.2, 3.4, 6.4
library;

import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/agora_call/presentation/services/call_navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Example widget showing navigation integration
class NavigationIntegrationExample extends ConsumerWidget {
  const NavigationIntegrationExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callStateProvider);
    final navService = ref.read(callNavigationServiceProvider(context));

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Integration Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current call state
            _buildCallStateSection(callState),
            const SizedBox(height: 24),

            // Current screen
            _buildCurrentScreenSection(navService),
            const SizedBox(height: 24),

            // Navigation actions
            _buildNavigationActionsSection(context, ref, navService),
            const SizedBox(height: 24),

            // Deep linking examples
            _buildDeepLinkingSection(navService),
            const SizedBox(height: 24),

            // Automatic navigation info
            _buildAutomaticNavigationInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildCallStateSection(AsyncValue<CallEntity?> callState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Call State', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            callState.when(
              data: (call) {
                if (call == null) {
                  return const Text('No active call');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Call ID: ${call.id}'),
                    Text('Status: ${call.status.name}'),
                    Text('Type: ${call.callType.name}'),
                    Text('Caller: ${call.callerName}'),
                    Text('Callee: ${call.calleeName}'),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreenSection(CallNavigationService navService) {
    final isOnCallScreen = navService.isOnCallScreen();
    final currentScreen = navService.getCurrentCallScreen();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Screen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('On call screen: ${isOnCallScreen ? 'Yes' : 'No'}'),
            if (currentScreen != null) Text('Screen type: ${currentScreen.name}'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationActionsSection(BuildContext context, WidgetRef ref, CallNavigationService navService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Navigation Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'These demonstrate programmatic navigation:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => navService.navigateToOutgoingCall(),
                  child: const Text('Go to Outgoing'),
                ),
                ElevatedButton(
                  onPressed: () => navService.navigateToIncomingCall(),
                  child: const Text('Go to Incoming'),
                ),
                ElevatedButton(onPressed: () => navService.navigateToActiveCall(), child: const Text('Go to Active')),
                ElevatedButton(onPressed: () => navService.navigateBackFromCall(), child: const Text('Go Back')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeepLinkingSection(CallNavigationService navService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Deep Linking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Supported deep link URIs:', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            const SelectableText('chattrix://call/incoming?callId=xxx', style: TextStyle(fontFamily: 'monospace')),
            const SelectableText('chattrix://call/active?callId=xxx', style: TextStyle(fontFamily: 'monospace')),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final uri = Uri.parse('chattrix://call/incoming?callId=test-123');
                navService.handleDeepLink(uri);
              },
              child: const Text('Test Deep Link'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutomaticNavigationInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Automatic Navigation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Navigation happens automatically based on call state:\n\n'
              '• INITIATING → /agora-call/outgoing\n'
              '• RINGING (caller) → /agora-call/outgoing\n'
              '• RINGING (callee) → /agora-call/incoming\n'
              '• CONNECTING → /agora-call/active\n'
              '• CONNECTED → /agora-call/active\n'
              '• ENDED → Pop back to previous screen\n'
              '• REJECTED → Pop back to previous screen\n\n'
              'The router redirect logic handles this automatically.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example: Complete call flow with automatic navigation
///
/// This demonstrates the complete flow from initiating a call to ending it,
/// showing how navigation happens automatically at each step.
class CompleteCallFlowExample {
  /// Step 1: Initiate a call
  /// Requirement 1.5: Display calling screen when initiating call
  static Future<void> initiateCall(WidgetRef ref, int calleeId, CallType callType) async {
    // Call the provider to initiate the call
    await ref.read(callStateProvider.notifier).initiateCall(calleeId: calleeId, callType: callType);

    // Navigation happens automatically:
    // - Call state changes to INITIATING
    // - Router notifier detects change
    // - Router redirect logic navigates to /agora-call/outgoing
    // - OutgoingCallScreen is displayed
  }

  /// Step 2: Receive an incoming call
  /// Requirement 2.2: Display incoming call screen when call invitation received
  static void receiveIncomingCall() {
    // WebSocket receives call.incoming event
    // CallStateProvider handles the event
    // Call state changes to RINGING
    // Router notifier detects change
    // Router redirect logic navigates to /agora-call/incoming
    // IncomingCallScreen is displayed with ringtone
  }

  /// Step 3: Accept the call
  /// Requirement 3.4: Transition to active call screen when call is accepted
  static Future<void> acceptCall(WidgetRef ref, String callId) async {
    // Call the provider to accept the call
    await ref.read(callStateProvider.notifier).acceptCall(callId);

    // Navigation happens automatically:
    // - Call state changes to CONNECTED
    // - Router notifier detects change
    // - Router redirect logic navigates to /agora-call/active
    // - ActiveCallScreen is displayed
  }

  /// Step 4: End the call
  /// Requirement 6.4: Return to previous screen when call ends
  static Future<void> endCall(WidgetRef ref, String callId) async {
    // Call the provider to end the call
    await ref.read(callStateProvider.notifier).endCall(callId);

    // Navigation happens automatically:
    // - Call state changes to null
    // - ActiveCallScreen listens to state change
    // - Screen calls context.pop()
    // - User returns to previous screen
  }

  /// Example: Handle app backgrounding during call
  /// Requirement 3.4: Handle app backgrounding during active call
  static void handleAppBackgrounding() {
    // CallLifecycleObserver detects app paused
    // For video calls: disables local video to save battery
    // For audio calls: continues in background
    // iOS background modes (audio, voip) allow this
  }

  /// Example: Handle app foregrounding during call
  /// Requirement 3.4: Handle app foregrounding with active call
  static void handleAppForegrounding() {
    // CallLifecycleObserver detects app resumed
    // Verifies call is still active
    // Verifies Agora connection
    // User can re-enable video if desired
  }

  /// Example: Handle deep link
  static void handleDeepLink(CallNavigationService navService, String deepLinkUrl) {
    final uri = Uri.parse(deepLinkUrl);
    navService.handleDeepLink(uri);

    // Examples:
    // chattrix://call/incoming?callId=123 → Opens incoming call screen
    // chattrix://call/active?callId=123 → Opens active call screen
  }
}

/// Example: Navigation guards
///
/// The router includes guards to prevent unwanted navigation
class NavigationGuardsExample {
  /// Guard 1: Never redirect away from call screens
  static void preventRedirectFromCallScreens() {
    // If user is on /agora-call/*, router blocks all redirects
    // This prevents:
    // - Auth changes from interrupting calls
    // - Incoming calls from interrupting active calls
    // - Navigation loops
  }

  /// Guard 2: Auto-reject incoming calls when busy
  static void autoRejectWhenBusy() {
    // If user is already in a call (RINGING, CONNECTING, or CONNECTED)
    // And a new call.incoming event arrives
    // The new call is automatically rejected with reason "busy"
    // No navigation occurs
  }

  /// Guard 3: Only navigate when app is in foreground
  static void onlyNavigateInForeground() {
    // Router redirect logic checks isAppInForeground
    // If app is backgrounded, no navigation occurs
    // This prevents showing screens when user can't see them
  }
}
