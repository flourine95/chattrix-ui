import 'dart:async';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_status_provider.g.dart';

/// Enum representing different call status states for UI feedback
enum CallStatus {
  /// Initial state - no call activity
  idle,

  /// Initiating a call - "Connecting..."
  initiating,

  /// Waiting for callee to respond - "Calling {calleeName}..."
  waitingForResponse,

  /// Callee accepted, joining channel - "Connecting to call..."
  connectingToCall,

  /// Call is active and connected
  active,

  /// Call was rejected by callee
  rejected,

  /// Call timed out (no response)
  timeout,

  /// Call ended
  ended,

  /// Error occurred during call
  error,
}

/// Data class to hold call status information
class CallStatusInfo {
  final CallStatus status;
  final String? calleeName;
  final String? rejectionReason;
  final String? errorMessage;

  const CallStatusInfo({required this.status, this.calleeName, this.rejectionReason, this.errorMessage});

  CallStatusInfo copyWith({CallStatus? status, String? calleeName, String? rejectionReason, String? errorMessage}) {
    return CallStatusInfo(
      status: status ?? this.status,
      calleeName: calleeName ?? this.calleeName,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider that tracks call status for UI feedback
@Riverpod(keepAlive: true)
class CallStatusNotifier extends _$CallStatusNotifier {
  StreamSubscription? _acceptedSubscription;
  StreamSubscription? _rejectedSubscription;
  StreamSubscription? _timeoutSubscription;

  // Store call information for joining when accepted
  String? _pendingCallId;
  String? _pendingChannelId;
  String? _pendingRemoteUserId;
  CallType? _pendingCallType;

  @override
  CallStatusInfo build() {
    // Listen to call signaling events
    final signalingService = ref.read(callSignalingServiceProvider);

    // Listen to call accepted events
    _acceptedSubscription = signalingService.callAcceptedStream.listen((notification) async {
      if (state.status == CallStatus.waitingForResponse) {
        // Callee accepted, now connecting to call
        state = state.copyWith(status: CallStatus.connectingToCall);

        // Join the Agora channel with the stored call information
        if (_pendingCallId != null &&
            _pendingChannelId != null &&
            _pendingRemoteUserId != null &&
            _pendingCallType != null) {
          await _joinAgoraChannel(
            callId: _pendingCallId!,
            channelId: _pendingChannelId!,
            remoteUserId: _pendingRemoteUserId!,
            callType: _pendingCallType!,
          );
        }
      }
    });

    // Listen to call rejected events
    _rejectedSubscription = signalingService.callRejectedStream.listen((notification) {
      if (state.status == CallStatus.waitingForResponse) {
        // Callee rejected the call
        state = state.copyWith(status: CallStatus.rejected, rejectionReason: notification.reason ?? 'declined');

        // Clear pending call information
        _clearPendingCallInfo();
      }
    });

    // Listen to call timeout events
    _timeoutSubscription = signalingService.callTimeoutStream.listen((notification) {
      if (state.status == CallStatus.waitingForResponse) {
        // Call timed out
        state = state.copyWith(status: CallStatus.timeout);

        // Clear pending call information
        _clearPendingCallInfo();
      }
    });

    // Watch call state to update status
    ref.listen(callProvider, (previous, next) {
      next.when(
        loading: () {
          // Call is loading - could be initiating or connecting
          if (state.status == CallStatus.idle) {
            state = state.copyWith(status: CallStatus.initiating);
          }
        },
        error: (error, stack) {
          // Error occurred
          state = state.copyWith(status: CallStatus.error, errorMessage: error.toString());

          // Clear pending call information on error
          _clearPendingCallInfo();
        },
        data: (call) {
          if (call != null && state.status == CallStatus.connectingToCall) {
            // Call is now active
            state = state.copyWith(status: CallStatus.active);

            // Clear pending call information once active
            _clearPendingCallInfo();
          } else if (call == null && state.status == CallStatus.active) {
            // Call ended
            state = state.copyWith(status: CallStatus.ended);
          }
        },
      );
    });

    ref.onDispose(() {
      _acceptedSubscription?.cancel();
      _rejectedSubscription?.cancel();
      _timeoutSubscription?.cancel();
    });

    return const CallStatusInfo(status: CallStatus.idle);
  }

  /// Join Agora channel when call is accepted
  Future<void> _joinAgoraChannel({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) async {
    try {
      // Use acceptCall method from CallStateProvider which handles joining
      await ref
          .read(callProvider.notifier)
          .acceptCall(callId: callId, channelId: channelId, remoteUserId: remoteUserId, callType: callType);

      // The call state will be updated by acceptCall method
      // Status will be updated to active by the listener watching callProvider
    } catch (e) {
      state = state.copyWith(status: CallStatus.error, errorMessage: 'Failed to join call: ${e.toString()}');
    }
  }

  /// Clear pending call information
  void _clearPendingCallInfo() {
    _pendingCallId = null;
    _pendingChannelId = null;
    _pendingRemoteUserId = null;
    _pendingCallType = null;
  }

  /// Set status to waiting for response with callee name and store call info
  void setWaitingForResponse({
    required String calleeName,
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) {
    state = CallStatusInfo(status: CallStatus.waitingForResponse, calleeName: calleeName);

    // Store call information for later use when call is accepted
    _pendingCallId = callId;
    _pendingChannelId = channelId;
    _pendingRemoteUserId = remoteUserId;
    _pendingCallType = callType;
  }

  /// Set status to connecting to call
  void setConnectingToCall() {
    state = state.copyWith(status: CallStatus.connectingToCall);
  }

  /// Set status to active
  void setActive() {
    state = state.copyWith(status: CallStatus.active);
  }

  /// Reset to idle state
  void reset() {
    state = const CallStatusInfo(status: CallStatus.idle);
    _clearPendingCallInfo();
  }

  /// Set error state
  void setError(String errorMessage) {
    state = state.copyWith(status: CallStatus.error, errorMessage: errorMessage);
  }
}
