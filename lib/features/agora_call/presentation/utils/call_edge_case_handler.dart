import 'package:flutter/foundation.dart';

/// Utility class for handling edge cases in the call system
///
/// This class documents and provides utilities for handling various edge cases:
/// - Multiple rapid incoming calls (Requirement 2.5)
/// - Call events received in wrong order (Requirement 8.3, 8.5)
/// - WebSocket disconnection during active call (Requirement 8.3)
/// - App termination during active call (Requirement 8.3, 8.5)
/// - Device rotation during video call (Requirement 8.3, 8.5)
class CallEdgeCaseHandler {
  CallEdgeCaseHandler._();

  /// Maximum time window (in seconds) to consider calls as "rapid"
  /// If multiple calls arrive within this window, only the most recent is kept
  static const int rapidCallWindowSeconds = 2;

  /// Determines if two call timestamps are within the rapid call window
  ///
  /// Used to detect multiple rapid incoming calls (Requirement 2.5)
  static bool areCallsRapid(DateTime? firstCall, DateTime secondCall) {
    if (firstCall == null) return false;
    return secondCall.difference(firstCall).inSeconds < rapidCallWindowSeconds;
  }

  /// Validates if a call event should be processed based on current state
  ///
  /// Handles events received in wrong order (Requirement 8.3, 8.5)
  ///
  /// Returns true if the event should be processed, false if it should be ignored
  static bool shouldProcessCallEvent({
    required String eventCallId,
    required String? currentCallId,
    required Set<String> pendingCallIds,
  }) {
    // Process if it's the current call
    if (currentCallId != null && currentCallId == eventCallId) {
      return true;
    }

    // Process if it's a pending call (event arrived before call.incoming)
    if (pendingCallIds.contains(eventCallId)) {
      return true;
    }

    // Ignore events for unknown calls
    debugPrint('CallEdgeCaseHandler: Ignoring event for unknown call $eventCallId');
    return false;
  }

  /// Logs edge case handling for debugging
  static void logEdgeCase(String edgeCase, String details) {
    debugPrint('CallEdgeCaseHandler: [$edgeCase] $details');
  }

  /// Edge case: Multiple rapid incoming calls
  ///
  /// Strategy: Keep the most recent call, auto-reject previous ones
  /// Requirement 2.5
  static void handleRapidIncomingCalls({
    required String previousCallId,
    required String newCallId,
    required Function(String callId) rejectCall,
  }) {
    logEdgeCase('Rapid Incoming Calls', 'Rejecting previous call $previousCallId in favor of new call $newCallId');
    rejectCall(previousCallId);
  }

  /// Edge case: Call events received in wrong order
  ///
  /// Strategy: Track pending call IDs and validate events against them
  /// Requirement 8.3, 8.5
  static void handleOutOfOrderEvent({required String eventType, required String callId, required bool isValid}) {
    if (!isValid) {
      logEdgeCase('Out of Order Event', 'Received $eventType for call $callId before call was established - ignoring');
    }
  }

  /// Edge case: WebSocket disconnection during active call
  ///
  /// Strategy: Agora continues running, show warning to user, attempt reconnection
  /// Requirement 8.3
  static void handleWebSocketDisconnection({required String callId, required bool isCallActive}) {
    if (isCallActive) {
      logEdgeCase(
        'WebSocket Disconnection',
        'WebSocket disconnected during active call $callId - Agora continues, attempting reconnection',
      );
    }
  }

  /// Edge case: App termination during active call
  ///
  /// Strategy: End call gracefully before app terminates
  /// Requirement 8.3, 8.5
  static void handleAppTermination({required String callId, required Function(String callId) endCall}) {
    logEdgeCase('App Termination', 'App terminating during active call $callId - ending call gracefully');
    endCall(callId);
  }

  /// Edge case: Device rotation during video call
  ///
  /// Strategy: Video views automatically adjust, no additional action needed
  /// Requirement 8.3, 8.5
  static void handleDeviceRotation({required String callId, required String orientation}) {
    logEdgeCase(
      'Device Rotation',
      'Device rotated to $orientation during video call $callId - views will adjust automatically',
    );
  }

  /// Edge case: User already in a call when receiving new invitation
  ///
  /// Strategy: Auto-reject new call with "busy" reason
  /// Requirement 8.5
  static void handleUserBusy({
    required String incomingCallId,
    required String activeCallId,
    required Function(String callId, String reason) rejectCall,
  }) {
    logEdgeCase('User Busy', 'Auto-rejecting incoming call $incomingCallId - user already in call $activeCallId');
    rejectCall(incomingCallId, 'busy');
  }

  /// Edge case: Call event for unknown call ID
  ///
  /// Strategy: Log and ignore the event
  /// Requirement 8.3, 8.5
  static void handleUnknownCallEvent({required String eventType, required String callId}) {
    logEdgeCase('Unknown Call Event', 'Received $eventType for unknown call $callId - ignoring');
  }

  /// Edge case: App backgrounded during active call
  ///
  /// Strategy: Agora continues running in background
  /// Requirement 8.3, 8.5
  static void handleAppBackgrounded({required String callId}) {
    logEdgeCase('App Backgrounded', 'App backgrounded during call $callId - Agora continues in background');
  }

  /// Edge case: App foregrounded during active call
  ///
  /// Strategy: Resume UI, verify call is still active
  /// Requirement 8.3, 8.5
  static void handleAppForegrounded({required String callId}) {
    logEdgeCase('App Foregrounded', 'App foregrounded during call $callId - resuming UI');
  }
}
