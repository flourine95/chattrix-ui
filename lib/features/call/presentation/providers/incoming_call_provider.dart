import 'dart:async';
import 'package:chattrix_ui/features/call/data/services/call_signaling_provider.dart';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/data/services/notification_service_provider.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'incoming_call_provider.g.dart';

/// Stream provider for incoming call invitations
@riverpod
Stream<CallInvitation> incomingCallInvitations(Ref ref) {
  final manager = ref.watch(callInvitationManagerProvider);
  return manager.incomingInvitationStream;
}

/// Stream provider for invitation timeouts
@riverpod
Stream<String> invitationTimeouts(Ref ref) {
  final manager = ref.watch(callInvitationManagerProvider);
  return manager.invitationTimeoutStream;
}

/// Notifier for managing the current incoming call invitation
@Riverpod(keepAlive: true)
class CurrentIncomingCall extends _$CurrentIncomingCall {
  StreamSubscription<CallInvitation>? _invitationSubscription;
  StreamSubscription<String>? _timeoutSubscription;

  @override
  CallInvitation? build() {
    // Listen to incoming invitations
    _listenToInvitations();

    // Listen to timeouts
    _listenToTimeouts();

    // Dispose subscriptions when provider is disposed
    ref.onDispose(() {
      _invitationSubscription?.cancel();
      _timeoutSubscription?.cancel();
    });

    return null;
  }

  /// Check if app is in background
  bool _isAppInBackground() {
    final binding = WidgetsBinding.instance;
    final currentState = binding.lifecycleState;

    return currentState == AppLifecycleState.paused ||
        currentState == AppLifecycleState.inactive ||
        currentState == AppLifecycleState.detached;
  }

  /// Listen to incoming call invitations
  void _listenToInvitations() {
    final manager = ref.read(callInvitationManagerProvider);

    _invitationSubscription = manager.incomingInvitationStream.listen((invitation) {
      // Update state with new invitation
      state = invitation;

      // Show notification if app is in background
      if (_isAppInBackground()) {
        _showNotification(invitation);
      }
    });
  }

  /// Show notification for incoming call
  Future<void> _showNotification(CallInvitation invitation) async {
    final notificationService = ref.read(notificationServiceProvider);

    // Convert CallType enum to string
    final callTypeString = invitation.callType == CallType.video ? 'video' : 'audio';

    await notificationService.showIncomingCallNotification(
      callId: invitation.callId,
      callerName: invitation.callerName,
      callType: callTypeString,
    );
  }

  /// Listen to invitation timeouts
  void _listenToTimeouts() {
    final manager = ref.read(callInvitationManagerProvider);

    _timeoutSubscription = manager.invitationTimeoutStream.listen((callId) {
      // Clear invitation if it matches the timed-out call
      if (state?.callId == callId) {
        // Dismiss notification on timeout
        _dismissNotification();
        state = null;
      }
    });
  }

  /// Dismiss the notification
  Future<void> _dismissNotification() async {
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.dismissNotification();
  }

  /// Clear the current invitation (called when user accepts/rejects)
  void clearInvitation() {
    state = null;
  }

  /// Accept the current invitation
  Future<void> acceptInvitation() async {
    if (state != null) {
      final manager = ref.read(callInvitationManagerProvider);
      manager.acceptInvitation(state!.callId);

      // Dismiss notification when call is accepted
      await _dismissNotification();

      clearInvitation();
    }
  }

  /// Reject the current invitation
  Future<void> rejectInvitation() async {
    if (state != null) {
      final manager = ref.read(callInvitationManagerProvider);
      manager.rejectInvitation(state!.callId);

      // Dismiss notification when call is rejected
      await _dismissNotification();

      clearInvitation();
    }
  }
}
