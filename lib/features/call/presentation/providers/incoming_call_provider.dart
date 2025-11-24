import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'incoming_call_provider.g.dart';

/// Notifier for managing the current incoming call invitation
/// This provider watches CallSignalingService and subscribes to callInvitationStream
@Riverpod(keepAlive: true)
class IncomingCall extends _$IncomingCall {
  StreamSubscription<CallInvitationData>? _invitationSubscription;

  @override
  CallInvitationData? build() {
    final signalingService = ref.watch(callSignalingServiceProvider);

    debugPrint('🎯 [INCOMING CALL PROVIDER] Initializing and subscribing to callInvitationStream...');

    // Listen to invitation stream
    _invitationSubscription = signalingService.callInvitationStream.listen(
      (invitation) {
        debugPrint('🔔🔔🔔 [INCOMING CALL PROVIDER] Received invitation from stream!');
        debugPrint('🔔 [INCOMING CALL PROVIDER] Call ID: ${invitation.callId}');
        debugPrint('🔔 [INCOMING CALL PROVIDER] Caller: ${invitation.callerName}');
        _handleIncomingInvitation(invitation, signalingService);
      },
      onError: (error) {
        debugPrint('❌ [INCOMING CALL PROVIDER] Stream error: $error');
      },
      onDone: () {
        debugPrint('⚠️ [INCOMING CALL PROVIDER] Stream closed');
      },
    );

    debugPrint('✅ [INCOMING CALL PROVIDER] Subscribed to callInvitationStream');

    ref.onDispose(() {
      debugPrint('🗑️ [INCOMING CALL PROVIDER] Disposing subscription');
      _invitationSubscription?.cancel();
    });

    return null;
  }

  /// Handle incoming call invitation with busy call detection and race condition handling
  void _handleIncomingInvitation(CallInvitationData invitation, CallSignalingService signalingService) {
    debugPrint('📞📞📞 [INCOMING CALL PROVIDER] _handleIncomingInvitation called!');
    debugPrint('📞 [INCOMING CALL PROVIDER] Call ID: ${invitation.callId}');
    debugPrint('📞 [INCOMING CALL PROVIDER] Caller: ${invitation.callerName}');
    debugPrint('📞 [INCOMING CALL PROVIDER] Type: ${invitation.callType}');

    CallLogger.logInfo(
      'Received incoming call invitation: callId=${invitation.callId}, from=${invitation.callerName}, type=${invitation.callType}',
    );

    // Check if there's already an active call
    final currentCallState = ref.read(callProvider);

    // Race condition detection: Check if user is currently initiating a call (loading state)
    final isInitiatingCall = currentCallState.isLoading;

    if (isInitiatingCall) {
      // Race condition detected: User is initiating a call while receiving an invitation
      // Priority: Incoming call takes precedence
      CallLogger.logInfo(
        'Race condition detected: cancelling outgoing call to prioritize incoming call: callId=${invitation.callId}',
      );

      // Cancel the outgoing call
      ref.read(callProvider.notifier).cancelOutgoingCall();

      // Show the incoming call screen
      state = invitation;
      return;
    }

    // If there's an active call (not null and not in error state), auto-reject with "busy"
    final hasActiveCall = currentCallState.hasValue && currentCallState.value != null;

    if (hasActiveCall) {
      // Automatically reject the incoming call with reason "busy"
      CallLogger.logInfo('Auto-rejecting incoming call (busy): callId=${invitation.callId}');

      final rejectResult = signalingService.sendCallReject(callId: invitation.callId, reason: 'busy');

      // Log the result but don't fail the operation
      rejectResult.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'Auto-reject busy call');
          // Continue even if WebSocket send fails - the call won't be shown anyway
        },
        (_) {
          CallLogger.logInfo('Successfully sent busy rejection: callId=${invitation.callId}');
        },
      );

      // Don't update state - don't show incoming call screen
      return;
    }

    // No active call, show the incoming call screen
    CallLogger.logInfo('Displaying incoming call screen: callId=${invitation.callId}');
    state = invitation;
  }

  /// Clear the current invitation (called when user accepts/rejects)
  void clearInvitation() {
    if (state != null) {
      CallLogger.logInfo('Clearing incoming call invitation: callId=${state!.callId}');
    }
    state = null;
  }
}

/// Provider to access the current incoming call invitation
@riverpod
CallInvitationData? currentIncomingCall(Ref ref) {
  return ref.watch(incomingCallProvider);
}
