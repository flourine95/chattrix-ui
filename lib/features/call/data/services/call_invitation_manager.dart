import 'dart:async';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';

/// Manages incoming call invitations with timeout handling
class CallInvitationManager {
  final CallSignalingService _signalingService;

  // Stream controller for processed invitations (with timeout handling)
  final _incomingInvitationController = StreamController<CallInvitation>.broadcast();

  // Stream controller for invitation timeouts
  final _invitationTimeoutController = StreamController<String>.broadcast();

  // Map to track active invitations and their timers
  final Map<String, Timer> _invitationTimers = {};

  // Default timeout duration (30 seconds)
  static const Duration defaultTimeout = Duration(seconds: 30);

  StreamSubscription<CallInvitation>? _invitationSubscription;
  StreamSubscription<CallResponse>? _responseSubscription;

  CallInvitationManager({required CallSignalingService signalingService}) : _signalingService = signalingService {
    _listenToInvitations();
    _listenToResponses();
  }

  /// Stream of incoming call invitations (after timeout handling)
  Stream<CallInvitation> get incomingInvitationStream => _incomingInvitationController.stream;

  /// Stream of invitation timeouts (emits callId)
  Stream<String> get invitationTimeoutStream => _invitationTimeoutController.stream;

  /// Listen to incoming call invitations from signaling service
  void _listenToInvitations() {
    _invitationSubscription = _signalingService.callInvitationStream.listen((invitation) {
      _handleIncomingInvitation(invitation);
    });
  }

  /// Listen to call responses to cancel timers
  void _listenToResponses() {
    _responseSubscription = _signalingService.callResponseStream.listen((response) {
      // Cancel the timer for this call
      _cancelInvitationTimer(response.callId);
    });
  }

  /// Handle incoming call invitation
  void _handleIncomingInvitation(CallInvitation invitation) {
    // Emit the invitation to listeners
    _incomingInvitationController.add(invitation);

    // Start timeout timer
    _startInvitationTimer(invitation.callId);
  }

  /// Start a timeout timer for an invitation
  void _startInvitationTimer(String callId, {Duration? timeout}) {
    // Cancel existing timer if any
    _cancelInvitationTimer(callId);

    // Create new timer
    final timer = Timer(timeout ?? defaultTimeout, () {
      _handleInvitationTimeout(callId);
    });

    _invitationTimers[callId] = timer;
  }

  /// Handle invitation timeout
  void _handleInvitationTimeout(String callId) {
    // Remove timer from map
    _invitationTimers.remove(callId);

    // Emit timeout event
    _invitationTimeoutController.add(callId);

    // Send rejection response automatically
    _signalingService.sendCallResponse(callId: callId, response: CallResponseType.rejected);
  }

  /// Cancel invitation timer (called when user accepts/rejects)
  void _cancelInvitationTimer(String callId) {
    final timer = _invitationTimers.remove(callId);
    timer?.cancel();
  }

  /// Accept an incoming call invitation
  void acceptInvitation(String callId) {
    // Cancel the timeout timer
    _cancelInvitationTimer(callId);

    // Send acceptance response
    _signalingService.sendCallResponse(callId: callId, response: CallResponseType.accepted);
  }

  /// Reject an incoming call invitation
  void rejectInvitation(String callId) {
    // Cancel the timeout timer
    _cancelInvitationTimer(callId);

    // Send rejection response
    _signalingService.sendCallResponse(callId: callId, response: CallResponseType.rejected);
  }

  /// Manually cancel an invitation (e.g., caller cancelled)
  void cancelInvitation(String callId) {
    _cancelInvitationTimer(callId);
  }

  /// Dispose resources
  void dispose() {
    // Cancel all active timers
    for (final timer in _invitationTimers.values) {
      timer.cancel();
    }
    _invitationTimers.clear();

    // Cancel subscriptions
    _invitationSubscription?.cancel();
    _responseSubscription?.cancel();

    // Close controllers
    _incomingInvitationController.close();
    _invitationTimeoutController.close();
  }
}
