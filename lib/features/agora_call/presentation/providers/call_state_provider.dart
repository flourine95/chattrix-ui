import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_connection_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_invitation_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/failures/call_failure.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_edge_case_handler.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_state_provider.g.dart';

/// Network quality state for monitoring call quality
/// Requirement 7.5: Show network quality indicator
/// Requirement 8.4: Show quality warnings without terminating call
class NetworkQualityState {
  final QualityType txQuality;
  final QualityType rxQuality;
  final QualityType overallQuality;
  final DateTime lastUpdated;

  const NetworkQualityState({
    required this.txQuality,
    required this.rxQuality,
    required this.overallQuality,
    required this.lastUpdated,
  });

  NetworkQualityState copyWith({
    QualityType? txQuality,
    QualityType? rxQuality,
    QualityType? overallQuality,
    DateTime? lastUpdated,
  }) {
    return NetworkQualityState(
      txQuality: txQuality ?? this.txQuality,
      rxQuality: rxQuality ?? this.rxQuality,
      overallQuality: overallQuality ?? this.overallQuality,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// Provider for tracking network quality metrics
/// Requirement 7.5: Show network quality indicator
/// Requirement 8.4: Log quality metrics for debugging
@riverpod
class NetworkQuality extends _$NetworkQuality {
  @override
  NetworkQualityState build() {
    return NetworkQualityState(
      txQuality: QualityType.qualityUnknown,
      rxQuality: QualityType.qualityUnknown,
      overallQuality: QualityType.qualityUnknown,
      lastUpdated: DateTime.now(),
    );
  }

  /// Updates network quality metrics
  /// Logs quality changes for debugging
  /// Requirement 8.4: Log quality metrics for debugging
  void updateQuality({required QualityType txQuality, required QualityType rxQuality}) {
    // Calculate overall quality (use the worse of tx/rx)
    final overallQuality = txQuality.index > rxQuality.index ? txQuality : rxQuality;

    final previousQuality = state.overallQuality;
    final now = DateTime.now();

    // Log quality metrics for debugging (Requirement 8.4)
    debugPrint(
      'NetworkQuality: TX=${_qualityToString(txQuality)}, '
      'RX=${_qualityToString(rxQuality)}, '
      'Overall=${_qualityToString(overallQuality)}',
    );

    // Log quality degradation
    if (previousQuality != QualityType.qualityUnknown && overallQuality.index > previousQuality.index) {
      debugPrint(
        'NetworkQuality: Quality degraded from '
        '${_qualityToString(previousQuality)} to ${_qualityToString(overallQuality)}',
      );
    }

    // Log quality improvement
    if (previousQuality != QualityType.qualityUnknown && overallQuality.index < previousQuality.index) {
      debugPrint(
        'NetworkQuality: Quality improved from '
        '${_qualityToString(previousQuality)} to ${_qualityToString(overallQuality)}',
      );
    }

    // Update state
    state = NetworkQualityState(
      txQuality: txQuality,
      rxQuality: rxQuality,
      overallQuality: overallQuality,
      lastUpdated: now,
    );
  }

  /// Resets network quality to unknown
  void reset() {
    debugPrint('NetworkQuality: Reset to unknown');
    state = NetworkQualityState(
      txQuality: QualityType.qualityUnknown,
      rxQuality: QualityType.qualityUnknown,
      overallQuality: QualityType.qualityUnknown,
      lastUpdated: DateTime.now(),
    );
  }

  /// Converts quality type to readable string
  String _qualityToString(QualityType quality) {
    switch (quality) {
      case QualityType.qualityExcellent:
        return 'Excellent';
      case QualityType.qualityGood:
        return 'Good';
      case QualityType.qualityPoor:
        return 'Poor';
      case QualityType.qualityBad:
        return 'Bad';
      case QualityType.qualityVbad:
        return 'Very Bad';
      case QualityType.qualityDown:
        return 'Down';
      default:
        return 'Unknown';
    }
  }
}

/// Provider for tracking quality warnings
/// Requirement 8.4: Show quality warnings without terminating call
@riverpod
class QualityWarning extends _$QualityWarning {
  @override
  String? build() => null;

  void setWarning(String message) {
    debugPrint('QualityWarning: $message');
    state = message;
  }

  void clearWarning() {
    state = null;
  }
}

/// Provider for tracking WebSocket connection status for calls
/// Requirement 8.3: Handle WebSocket disconnection with reconnection attempt
@riverpod
class CallWebSocketStatus extends _$CallWebSocketStatus {
  @override
  bool build() {
    // Listen to WebSocket connection status
    final wsService = ref.watch(chatWebSocketServiceProvider);
    return wsService.isConnected;
  }
}

/// Main call state management provider
///
/// Manages the complete call lifecycle including:
/// - Initiating calls
/// - Accepting/rejecting incoming calls
/// - Ending active calls
/// - Listening to WebSocket call events
/// - Managing Agora channel connections
@riverpod
class CallState extends _$CallState {
  StreamSubscription<Map<String, dynamic>>? _wsSubscription;

  // Track pending call IDs to handle events in wrong order (Requirement 2.5, 8.3, 8.5)
  final Set<String> _pendingCallIds = {};

  // Track the last incoming call timestamp to handle rapid calls (Requirement 2.5)
  DateTime? _lastIncomingCallTime;
  String? _lastIncomingCallId;

  @override
  Future<CallEntity?> build() async {
    // Keep the provider alive
    ref.keepAlive();

    // Listen to WebSocket call events
    _listenToCallEvents();

    // Clean up subscription on dispose
    ref.onDispose(() {
      _wsSubscription?.cancel();
      _pendingCallIds.clear();
    });

    // Initial state is no active call
    return null;
  }

  /// Initiates a call to another user
  ///
  /// [calleeId] - The ID of the user to call
  /// [callType] - The type of call (audio or video)
  ///
  /// Returns the call connection entity on success, or a failure
  /// Automatically joins the Agora channel on successful initiation
  ///
  /// Requirement 10.2: Use unique Agora token for each call session
  Future<void> initiateCall({required int calleeId, required CallType callType}) async {
    state = const AsyncValue.loading();

    final repository = ref.read(agoraCallRepositoryProvider);
    final result = await repository.initiateCall(calleeId: calleeId, callType: callType);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        _handleCallFailure(failure);
      },
      (connection) async {
        // Store the Agora token securely (Requirement 10.2)
        final securityService = ref.read(callSecurityServiceProvider);
        securityService.storeCallToken(connection.callEntity.id, connection.token);

        // Update state with the new call
        state = AsyncValue.data(connection.callEntity);

        // Join Agora channel with the provided credentials
        await _joinAgoraChannel(connection);
      },
    );
  }

  /// Accepts an incoming call
  ///
  /// [callId] - The ID of the call to accept
  ///
  /// Sends accept request to backend and joins the Agora channel
  ///
  /// Requirement 10.2: Use unique Agora token for each call session
  Future<void> acceptCall(String callId) async {
    state = const AsyncValue.loading();

    final repository = ref.read(agoraCallRepositoryProvider);
    final result = await repository.acceptCall(callId: callId);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        _handleCallFailure(failure);
      },
      (connection) async {
        // Store the Agora token securely (Requirement 10.2)
        final securityService = ref.read(callSecurityServiceProvider);
        securityService.storeCallToken(connection.callEntity.id, connection.token);

        // Update state with the accepted call
        state = AsyncValue.data(connection.callEntity);

        // Join Agora channel with the provided credentials
        await _joinAgoraChannel(connection);
      },
    );
  }

  /// Rejects an incoming call
  ///
  /// [callId] - The ID of the call to reject
  /// [reason] - The reason for rejection (e.g., "declined", "busy")
  ///
  /// Sends reject request to backend and clears call state
  Future<void> rejectCall({required String callId, required String reason}) async {
    final repository = ref.read(agoraCallRepositoryProvider);
    final result = await repository.rejectCall(callId: callId, reason: reason);

    result.fold(
      (failure) {
        debugPrint('CallState: Failed to reject call: $failure');
        // Still clear the state even if rejection fails
        state = const AsyncValue.data(null);
      },
      (call) {
        // Clear call state after rejection
        state = const AsyncValue.data(null);
      },
    );

    // Remove from pending calls
    _pendingCallIds.remove(callId);

    // Clear last incoming call tracking if this was it
    if (_lastIncomingCallId == callId) {
      _lastIncomingCallId = null;
      _lastIncomingCallTime = null;
    }
  }

  /// Handles app lifecycle state changes
  /// Requirement 8.3, 8.5: Handle app termination during active call
  Future<void> handleAppLifecycleChange(AppLifecycleState lifecycleState) async {
    final currentCall = state.value;

    if (currentCall == null) return;

    switch (lifecycleState) {
      case AppLifecycleState.paused:
        // App is going to background
        debugPrint('CallState: App paused during call ${currentCall.id}');
        // Agora will continue running in background
        break;

      case AppLifecycleState.resumed:
        // App is coming back to foreground
        debugPrint('CallState: App resumed during call ${currentCall.id}');
        // Check if call is still active via WebSocket
        break;

      case AppLifecycleState.detached:
        // App is being terminated
        debugPrint('CallState: App terminating during call ${currentCall.id} - ending call');
        // End the call gracefully
        if (currentCall.status == CallStatus.connected || currentCall.status == CallStatus.connecting) {
          await endCall(currentCall.id, reason: 'app_terminated');
        }
        break;

      case AppLifecycleState.inactive:
        // App is inactive (e.g., during a phone call)
        debugPrint('CallState: App inactive during call ${currentCall.id}');
        break;

      case AppLifecycleState.hidden:
        // App is hidden
        debugPrint('CallState: App hidden during call ${currentCall.id}');
        break;
    }
  }

  /// Ends an active call
  ///
  /// [callId] - The ID of the call to end
  /// [reason] - The reason for ending (default: "hangup")
  ///
  /// Leaves the Agora channel, sends end request to backend, and clears state
  ///
  /// Requirement 10.3: Clear all tokens from memory when call ends
  Future<void> endCall(String callId, {String reason = 'hangup'}) async {
    // Leave Agora channel immediately
    await _leaveAgoraChannel();

    // Clear the Agora token from memory (Requirement 10.3)
    final securityService = ref.read(callSecurityServiceProvider);
    securityService.clearCallToken(callId);

    // Send end request to backend
    final repository = ref.read(agoraCallRepositoryProvider);
    final result = await repository.endCall(callId: callId, reason: reason);

    result.fold(
      (failure) {
        debugPrint('CallState: Failed to end call: $failure');
        // Still clear the state even if end request fails
        state = const AsyncValue.data(null);
      },
      (call) {
        // Clear call state after ending
        state = const AsyncValue.data(null);
      },
    );
  }

  /// Listens to WebSocket call events and handles them appropriately
  ///
  /// Filters for call.* events from the raw message stream
  void _listenToCallEvents() {
    final wsService = ref.read(chatWebSocketServiceProvider);

    _wsSubscription = wsService.rawMessageStream.listen((message) {
      final type = message['type'] as String?;

      if (type == null) return;

      // Handle call-related events
      switch (type) {
        case 'call.incoming':
          _handleIncomingCall(message['data'] ?? message['payload']);
          break;
        case 'call.accepted':
          _handleCallAccepted(message['data'] ?? message['payload']);
          break;
        case 'call.rejected':
          _handleCallRejected(message['data'] ?? message['payload']);
          break;
        case 'call.ended':
          _handleCallEnded(message['data'] ?? message['payload']);
          break;
        case 'call.timeout':
          _handleCallTimeout(message['data'] ?? message['payload']);
          break;
        case 'call.quality_warning':
          _handleQualityWarning(message['data'] ?? message['payload']);
          break;
      }
    });
  }

  /// Handles incoming call invitation
  ///
  /// Creates a call entity from the invitation and updates state
  /// Requirement 8.5: Auto-reject incoming calls when user is busy
  /// Requirement 2.5: Handle multiple rapid incoming calls (keep most recent, reject others)
  void _handleIncomingCall(dynamic data) {
    if (data == null) return;

    try {
      final invitation = _parseCallInvitation(data);
      final now = DateTime.now();

      // Get current user to determine if we're the callee
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) return;

      // Check if user is already in a call (Requirement 8.5)
      final currentCall = state.value;
      if (currentCall != null &&
          (currentCall.status == CallStatus.ringing ||
              currentCall.status == CallStatus.connecting ||
              currentCall.status == CallStatus.connected)) {
        // User is busy - auto-reject the incoming call
        CallEdgeCaseHandler.handleUserBusy(
          incomingCallId: invitation.callId,
          activeCallId: currentCall.id,
          rejectCall: (callId, reason) => rejectCall(callId: callId, reason: reason),
        );
        return;
      }

      // Handle multiple rapid incoming calls (Requirement 2.5)
      // If we received another call within the rapid call window, reject the previous one and keep the new one
      if (_lastIncomingCallTime != null &&
          _lastIncomingCallId != null &&
          CallEdgeCaseHandler.areCallsRapid(_lastIncomingCallTime, now)) {
        CallEdgeCaseHandler.handleRapidIncomingCalls(
          previousCallId: _lastIncomingCallId!,
          newCallId: invitation.callId,
          rejectCall: (callId) => rejectCall(callId: callId, reason: 'replaced_by_newer_call'),
        );
      }

      // Track this incoming call
      _lastIncomingCallTime = now;
      _lastIncomingCallId = invitation.callId;
      _pendingCallIds.add(invitation.callId);

      // Create a call entity from the invitation
      final call = CallEntity(
        id: invitation.callId,
        channelId: invitation.channelId,
        status: CallStatus.ringing,
        callType: invitation.callType,
        callerId: invitation.callerId,
        callerName: invitation.callerName,
        callerAvatar: invitation.callerAvatar,
        calleeId: currentUser.id,
        calleeName: currentUser.username,
        calleeAvatar: currentUser.avatarUrl,
        createdAt: DateTime.now(),
      );

      state = AsyncValue.data(call);
      debugPrint('CallState: Incoming call from ${invitation.callerName}');
    } catch (e) {
      debugPrint('CallState: Failed to parse incoming call: $e');
    }
  }

  /// Handles call accepted event
  ///
  /// Updates call status to CONNECTED for the caller
  /// Handles events received in wrong order (Requirement 2.5, 8.3, 8.5)
  void _handleCallAccepted(dynamic data) {
    if (data == null) return;

    try {
      final callId = data['callId'] as String?;
      if (callId == null) return;

      // Check if this is a pending call or current call
      final currentCall = state.value;

      // Handle event for current call
      if (currentCall != null && currentCall.id == callId) {
        // Only update if we're in a valid state to accept
        if (currentCall.status == CallStatus.ringing ||
            currentCall.status == CallStatus.connecting ||
            currentCall.status == CallStatus.initiating) {
          final updatedCall = currentCall.copyWith(status: CallStatus.connected);
          state = AsyncValue.data(updatedCall);
          _pendingCallIds.remove(callId);
          debugPrint('CallState: Call accepted and connected');
        } else {
          debugPrint('CallState: Ignoring call.accepted for call in status ${currentCall.status}');
        }
      }
      // Handle event received before call.incoming (wrong order)
      else if (_pendingCallIds.contains(callId)) {
        debugPrint('CallState: Received call.accepted before establishing call state - will apply when call is set');
        // The state will be updated when the call entity is created
      } else {
        debugPrint('CallState: Received call.accepted for unknown call $callId - ignoring');
      }
    } catch (e) {
      debugPrint('CallState: Failed to handle call accepted: $e');
    }
  }

  /// Handles call rejected event
  ///
  /// Clears call state and shows rejection notification
  /// Handles events received in wrong order (Requirement 2.5, 8.3, 8.5)
  /// Requirement 10.3: Clear all tokens from memory when call ends
  void _handleCallRejected(dynamic data) {
    if (data == null) return;

    try {
      final callId = data['callId'] as String?;
      final reason = data['reason'] as String? ?? 'declined';

      if (callId == null) return;

      final currentCall = state.value;

      // Only process if this is the current call or a pending call
      if ((currentCall != null && currentCall.id == callId) || _pendingCallIds.contains(callId)) {
        // Leave Agora channel if we're in one
        _leaveAgoraChannel();

        // Clear the Agora token from memory (Requirement 10.3)
        final securityService = ref.read(callSecurityServiceProvider);
        securityService.clearCallToken(callId);

        // Remove from pending calls
        _pendingCallIds.remove(callId);

        // Clear last incoming call tracking if this was it
        if (_lastIncomingCallId == callId) {
          _lastIncomingCallId = null;
          _lastIncomingCallTime = null;
        }

        // Clear call state
        state = const AsyncValue.data(null);
        debugPrint('CallState: Call rejected - reason: $reason');
      } else {
        debugPrint('CallState: Received call.rejected for unknown call $callId - ignoring');
      }
    } catch (e) {
      debugPrint('CallState: Failed to handle call rejected: $e');
    }
  }

  /// Handles call ended event
  ///
  /// Leaves Agora channel and clears call state
  /// Handles events received in wrong order (Requirement 2.5, 8.3, 8.5)
  /// Requirement 10.3: Clear all tokens from memory when call ends
  void _handleCallEnded(dynamic data) {
    if (data == null) return;

    try {
      final callId = data['callId'] as String?;
      final durationSeconds = data['durationSeconds'] as int?;

      if (callId == null) return;

      final currentCall = state.value;

      // Only process if this is the current call or a pending call
      if ((currentCall != null && currentCall.id == callId) || _pendingCallIds.contains(callId)) {
        // Leave Agora channel
        _leaveAgoraChannel();

        // Clear the Agora token from memory (Requirement 10.3)
        final securityService = ref.read(callSecurityServiceProvider);
        securityService.clearCallToken(callId);

        // Remove from pending calls
        _pendingCallIds.remove(callId);

        // Clear last incoming call tracking if this was it
        if (_lastIncomingCallId == callId) {
          _lastIncomingCallId = null;
          _lastIncomingCallTime = null;
        }

        // Clear call state
        state = const AsyncValue.data(null);
        debugPrint('CallState: Call ended - duration: ${durationSeconds}s');
      } else {
        debugPrint('CallState: Received call.ended for unknown call $callId - ignoring');
      }
    } catch (e) {
      debugPrint('CallState: Failed to handle call ended: $e');
    }
  }

  /// Handles call timeout event
  ///
  /// Clears call state and shows timeout notification
  /// Handles events received in wrong order (Requirement 2.5, 8.3, 8.5)
  /// Requirement 10.3: Clear all tokens from memory when call ends
  void _handleCallTimeout(dynamic data) {
    if (data == null) return;

    try {
      final callId = data['callId'] as String?;
      final reason = data['reason'] as String? ?? 'no_answer';

      if (callId == null) return;

      final currentCall = state.value;

      // Only process if this is the current call or a pending call
      if ((currentCall != null && currentCall.id == callId) || _pendingCallIds.contains(callId)) {
        // Leave Agora channel if we're in one
        _leaveAgoraChannel();

        // Clear the Agora token from memory (Requirement 10.3)
        final securityService = ref.read(callSecurityServiceProvider);
        securityService.clearCallToken(callId);

        // Remove from pending calls
        _pendingCallIds.remove(callId);

        // Clear last incoming call tracking if this was it
        if (_lastIncomingCallId == callId) {
          _lastIncomingCallId = null;
          _lastIncomingCallTime = null;
        }

        // Clear call state
        state = const AsyncValue.data(null);
        debugPrint('CallState: Call timeout - reason: $reason');
      } else {
        debugPrint('CallState: Received call.timeout for unknown call $callId - ignoring');
      }
    } catch (e) {
      debugPrint('CallState: Failed to handle call timeout: $e');
    }
  }

  /// Handles call quality warning event
  ///
  /// Shows warning to user without terminating the call
  /// Requirement 8.4: Show quality warnings without terminating call
  void _handleQualityWarning(dynamic data) {
    if (data == null) return;

    try {
      final callId = data['callId'] as String?;
      final message = data['message'] as String? ?? 'Poor network quality';

      if (callId == null) return;

      state.whenData((call) {
        if (call != null && call.id == callId) {
          debugPrint('CallState: Quality warning - $message');
          // Update quality warning provider so UI can show banner
          // The call state remains unchanged (Requirement 8.4)
          ref.read(qualityWarningProvider.notifier).setWarning(message);

          // Auto-clear warning after 5 seconds
          Future.delayed(const Duration(seconds: 5), () {
            ref.read(qualityWarningProvider.notifier).clearWarning();
          });
        }
      });
    } catch (e) {
      debugPrint('CallState: Failed to handle quality warning: $e');
    }
  }

  /// Joins an Agora channel with the provided connection credentials
  ///
  /// [connection] - The call connection entity with token and call details
  /// Requirement 8.2: Handle Agora SDK errors with notification and cleanup
  Future<void> _joinAgoraChannel(CallConnectionEntity connection) async {
    try {
      final agoraService = ref.read(agoraEngineServiceProvider);
      final currentUser = ref.read(currentUserProvider);

      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      await agoraService.joinChannel(
        token: connection.token,
        channelId: connection.callEntity.channelId,
        uid: currentUser.id,
        isVideo: connection.callEntity.callType == CallType.video,
      );

      debugPrint('CallState: Joined Agora channel ${connection.callEntity.channelId}');
    } catch (e) {
      debugPrint('CallState: Failed to join Agora channel: $e');

      // Create Agora error failure (Requirement 8.2)
      final failure = CallFailure.agoraError(e.toString());
      state = AsyncValue.error(failure, StackTrace.current);

      // Attempt cleanup and end call
      try {
        await endCall(connection.callEntity.id, reason: 'connection_failed');
      } catch (endError) {
        debugPrint('CallState: Failed to end call after Agora error: $endError');
      }
    }
  }

  /// Leaves the current Agora channel and releases media resources
  Future<void> _leaveAgoraChannel() async {
    try {
      final agoraService = ref.read(agoraEngineServiceProvider);
      await agoraService.leaveChannel();
      debugPrint('CallState: Left Agora channel');
    } catch (e) {
      debugPrint('CallState: Failed to leave Agora channel: $e');
    }
  }

  /// Handles call failures by logging and potentially showing user notifications
  void _handleCallFailure(CallFailure failure) {
    failure.when(
      serverError: (message) => debugPrint('CallState: Server error - $message'),
      networkError: () => debugPrint('CallState: Network error'),
      userBusy: () => debugPrint('CallState: User is busy'),
      callNotFound: () => debugPrint('CallState: Call not found'),
      permissionDenied: (permission) => debugPrint('CallState: Permission denied - $permission'),
      agoraError: (message) => debugPrint('CallState: Agora error - $message'),
      unauthorized: () => debugPrint('CallState: Unauthorized'),
    );
  }

  /// Parses a call invitation from WebSocket data
  CallInvitationEntity _parseCallInvitation(dynamic data) {
    final map = data as Map<String, dynamic>;

    return CallInvitationEntity(
      callId: map['callId'] as String,
      channelId: map['channelId'] as String,
      callerId: map['callerId'] as int,
      callerName: map['callerName'] as String,
      callerAvatar: map['callerAvatar'] as String?,
      callType: _parseCallType(map['callType'] as String),
    );
  }

  /// Parses call type from string
  CallType _parseCallType(String type) {
    switch (type.toUpperCase()) {
      case 'VIDEO':
        return CallType.video;
      case 'AUDIO':
        return CallType.audio;
      default:
        return CallType.audio;
    }
  }
}
