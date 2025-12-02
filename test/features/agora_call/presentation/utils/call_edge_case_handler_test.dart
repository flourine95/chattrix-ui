import 'package:chattrix_ui/features/agora_call/presentation/utils/call_edge_case_handler.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests for CallEdgeCaseHandler utility
///
/// These tests verify the edge case handling logic for:
/// - Multiple rapid incoming calls (Requirement 2.5)
/// - Call events received in wrong order (Requirement 8.3, 8.5)
/// - WebSocket disconnection during active call (Requirement 8.3)
/// - App termination during active call (Requirement 8.3, 8.5)
/// - Device rotation during video call (Requirement 8.3, 8.5)
void main() {
  group('CallEdgeCaseHandler', () {
    group('areCallsRapid', () {
      test('returns false when first call is null', () {
        final secondCall = DateTime.now();
        expect(CallEdgeCaseHandler.areCallsRapid(null, secondCall), false);
      });

      test('returns true when calls are within rapid window', () {
        final firstCall = DateTime.now();
        final secondCall = firstCall.add(const Duration(seconds: 1));
        expect(CallEdgeCaseHandler.areCallsRapid(firstCall, secondCall), true);
      });

      test('returns false when calls are outside rapid window', () {
        final firstCall = DateTime.now();
        final secondCall = firstCall.add(const Duration(seconds: 3));
        expect(CallEdgeCaseHandler.areCallsRapid(firstCall, secondCall), false);
      });

      test('returns true when calls are exactly at window boundary', () {
        final firstCall = DateTime.now();
        final secondCall = firstCall.add(const Duration(seconds: CallEdgeCaseHandler.rapidCallWindowSeconds - 1));
        expect(CallEdgeCaseHandler.areCallsRapid(firstCall, secondCall), true);
      });
    });

    group('shouldProcessCallEvent', () {
      test('returns true when event is for current call', () {
        const eventCallId = 'call-123';
        const currentCallId = 'call-123';
        final pendingCallIds = <String>{};

        expect(
          CallEdgeCaseHandler.shouldProcessCallEvent(
            eventCallId: eventCallId,
            currentCallId: currentCallId,
            pendingCallIds: pendingCallIds,
          ),
          true,
        );
      });

      test('returns true when event is for pending call', () {
        const eventCallId = 'call-123';
        const currentCallId = 'call-456';
        final pendingCallIds = {'call-123'};

        expect(
          CallEdgeCaseHandler.shouldProcessCallEvent(
            eventCallId: eventCallId,
            currentCallId: currentCallId,
            pendingCallIds: pendingCallIds,
          ),
          true,
        );
      });

      test('returns false when event is for unknown call', () {
        const eventCallId = 'call-123';
        const currentCallId = 'call-456';
        final pendingCallIds = <String>{'call-789'};

        expect(
          CallEdgeCaseHandler.shouldProcessCallEvent(
            eventCallId: eventCallId,
            currentCallId: currentCallId,
            pendingCallIds: pendingCallIds,
          ),
          false,
        );
      });

      test('returns true when current call is null but event is pending', () {
        const eventCallId = 'call-123';
        const String? currentCallId = null;
        final pendingCallIds = {'call-123'};

        expect(
          CallEdgeCaseHandler.shouldProcessCallEvent(
            eventCallId: eventCallId,
            currentCallId: currentCallId,
            pendingCallIds: pendingCallIds,
          ),
          true,
        );
      });
    });

    group('handleRapidIncomingCalls', () {
      test('calls rejectCall with previous call ID', () {
        const previousCallId = 'call-123';
        const newCallId = 'call-456';
        String? rejectedCallId;

        CallEdgeCaseHandler.handleRapidIncomingCalls(
          previousCallId: previousCallId,
          newCallId: newCallId,
          rejectCall: (callId) {
            rejectedCallId = callId;
          },
        );

        expect(rejectedCallId, previousCallId);
      });
    });

    group('handleUserBusy', () {
      test('calls rejectCall with incoming call ID and busy reason', () {
        const incomingCallId = 'call-123';
        const activeCallId = 'call-456';
        String? rejectedCallId;
        String? rejectionReason;

        CallEdgeCaseHandler.handleUserBusy(
          incomingCallId: incomingCallId,
          activeCallId: activeCallId,
          rejectCall: (callId, reason) {
            rejectedCallId = callId;
            rejectionReason = reason;
          },
        );

        expect(rejectedCallId, incomingCallId);
        expect(rejectionReason, 'busy');
      });
    });

    group('handleAppTermination', () {
      test('calls endCall with call ID', () {
        const callId = 'call-123';
        String? endedCallId;

        CallEdgeCaseHandler.handleAppTermination(
          callId: callId,
          endCall: (id) {
            endedCallId = id;
          },
        );

        expect(endedCallId, callId);
      });
    });

    group('edge case logging', () {
      test('logEdgeCase does not throw', () {
        expect(() => CallEdgeCaseHandler.logEdgeCase('Test Case', 'Test details'), returnsNormally);
      });

      test('handleOutOfOrderEvent does not throw', () {
        expect(
          () =>
              CallEdgeCaseHandler.handleOutOfOrderEvent(eventType: 'call.accepted', callId: 'call-123', isValid: false),
          returnsNormally,
        );
      });

      test('handleWebSocketDisconnection does not throw', () {
        expect(
          () => CallEdgeCaseHandler.handleWebSocketDisconnection(callId: 'call-123', isCallActive: true),
          returnsNormally,
        );
      });

      test('handleDeviceRotation does not throw', () {
        expect(
          () => CallEdgeCaseHandler.handleDeviceRotation(callId: 'call-123', orientation: 'landscape'),
          returnsNormally,
        );
      });

      test('handleUnknownCallEvent does not throw', () {
        expect(
          () => CallEdgeCaseHandler.handleUnknownCallEvent(eventType: 'call.accepted', callId: 'call-123'),
          returnsNormally,
        );
      });

      test('handleAppBackgrounded does not throw', () {
        expect(() => CallEdgeCaseHandler.handleAppBackgrounded(callId: 'call-123'), returnsNormally);
      });

      test('handleAppForegrounded does not throw', () {
        expect(() => CallEdgeCaseHandler.handleAppForegrounded(callId: 'call-123'), returnsNormally);
      });
    });
  });
}
