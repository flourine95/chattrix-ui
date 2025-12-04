import 'dart:async';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/toast/toast_type.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_usecase_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'call_notifier.g.dart';

@riverpod
class CallNotifier extends _$CallNotifier {
  StreamSubscription? _incomingCallSubscription;
  StreamSubscription? _callAcceptedSubscription;
  StreamSubscription? _callRejectedSubscription;
  StreamSubscription? _callEndedSubscription;
  StreamSubscription? _callTimeoutSubscription;
  StreamSubscription? _userJoinedSubscription;
  StreamSubscription? _userOfflineSubscription;

  @override
  CallState build() {
    ref.keepAlive();
    
    _initializeListeners();
    
    ref.onDispose(() {
      _cleanup();
    });
    
    return const CallState.idle();
  }

  void _initializeListeners() {
    appLogger.i('📞 [CallNotifier] Initializing listeners...');

    final wsHandler = ref.watch(callWebSocketHandlerProvider);
    final agoraService = ref.watch(agoraServiceProvider);

    // Listen to WebSocket events
    _incomingCallSubscription = wsHandler.incomingCallStream.listen(_handleIncomingCall);
    _callAcceptedSubscription = wsHandler.callAcceptedStream.listen(_handleCallAccepted);
    _callRejectedSubscription = wsHandler.callRejectedStream.listen(_handleCallRejected);
    _callEndedSubscription = wsHandler.callEndedStream.listen(_handleCallEnded);
    _callTimeoutSubscription = wsHandler.callTimeoutStream.listen(_handleCallTimeout);

    // Listen to Agora events
    _userJoinedSubscription = agoraService.userJoinedStream.listen(_handleUserJoined);
    _userOfflineSubscription = agoraService.userOfflineStream.listen(_handleUserOffline);

    appLogger.i('📞 [CallNotifier] Listeners initialized successfully');
  }

  void _cleanup() {
    _incomingCallSubscription?.cancel();
    _callAcceptedSubscription?.cancel();
    _callRejectedSubscription?.cancel();
    _callEndedSubscription?.cancel();
    _callTimeoutSubscription?.cancel();
    _userJoinedSubscription?.cancel();
    _userOfflineSubscription?.cancel();
    WakelockPlus.disable();
  }

  // WebSocket event handlers
  void _handleIncomingCall(CallInvitation invitation) {
    appLogger.i('📞 [CallNotifier] Handling incoming call: ${invitation.callId} from ${invitation.callerName}');
    state = CallState.ringing(invitation: invitation);
    appLogger.i('📞 [CallNotifier] State changed to RINGING');
  }

  void _handleCallAccepted(CallAccept accept) {
    appLogger.i('Call accepted: ${accept.callId}');
    // If we are the caller, we just wait for the other user to join Agora
    state.whenOrNull(
      connecting: (connection, callType, isOutgoing) {
        if (isOutgoing && connection.callInfo.id == accept.callId) {
          appLogger.i('Waiting for callee to join Agora channel');
        }
      },
    );
  }

  void _handleCallRejected(reject) {
    appLogger.i('Call rejected: ${reject.callId}');
    _endCallCleanup();
    state = CallState.ended(reason: 'Call was rejected: ${reject.reason.name}');
  }

  void _handleCallEnded(end) {
    appLogger.i('Call ended: ${end.callId}');
    _endCallCleanup();
    state = CallState.ended(reason: 'Call ended');
  }

  void _handleCallTimeout(timeout) {
    appLogger.i('Call timeout: ${timeout.callId}');
    _endCallCleanup();
    state = CallState.ended(reason: 'Call timeout: ${timeout.reason}');
  }

  // Agora event handlers
  void _handleUserJoined(int remoteUid) {
    appLogger.i('Remote user joined Agora: $remoteUid');
    state.whenOrNull(
      connecting: (connection, callType, isOutgoing) {
        state = CallState.connected(
          connection: connection,
          callType: callType,
          isOutgoing: isOutgoing,
          isMuted: false,
          isVideoEnabled: callType == CallType.video,
          isSpeakerEnabled: true,
          isFrontCamera: true,
          remoteUid: remoteUid,
        );
        WakelockPlus.enable();
      },
    );
  }

  void _handleUserOffline(int remoteUid) {
    appLogger.i('Remote user offline: $remoteUid');
    state.whenOrNull(
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled, isSpeakerEnabled, isFrontCamera, currentRemoteUid) {
        if (currentRemoteUid == remoteUid) {
          _endCallCleanup();
          state = const CallState.ended(reason: 'Remote user left');
        }
      },
    );
  }

  // Public methods
  Future<void> initiateCall(int calleeId, CallType callType) async {
    try {
      state = CallState.initiating(calleeId: calleeId, callType: callType);
      
      final usecase = ref.read(initiateCallUseCaseProvider);
      final result = await usecase.call(calleeId: calleeId, callType: callType);
      
      await result.fold(
        (failure) {
          appLogger.e('Failed to initiate call: ${failure.userMessage}');
          ref.read(toastControllerProvider).show(
            title: failure.userMessage,
            type: ToastType.error,
          );
          state = CallState.error(message: failure.userMessage);
        },
        (connection) async {
          appLogger.i('Call initiated successfully: ${connection.callInfo.id}');
          
          try {
            // Initialize and join Agora
            final agoraService = ref.read(agoraServiceProvider);
            await agoraService.initialize();
            await agoraService.joinChannel(
              token: connection.token,
              channelId: connection.callInfo.channelId,
              uid: connection.callInfo.callerId,
              isVideoCall: callType == CallType.video,
            );

            state = CallState.connecting(
              connection: connection,
              callType: callType,
              isOutgoing: true,
            );
          } catch (agoraError) {
            appLogger.e('Agora error during call initiation: $agoraError');
            final errorMessage = 'Failed to join call. Please check your connection and try again.';
            ref.read(toastControllerProvider).show(
              title: errorMessage,
              type: ToastType.error,
            );
            state = CallState.error(message: errorMessage);

            // Clean up the call on backend since we couldn't join
            try {
              final endUsecase = ref.read(endCallUseCaseProvider);
              await endUsecase.call(
                callId: connection.callInfo.id,
                reason: CallEndReason.networkError,
              );
            } catch (_) {
              // Ignore errors during cleanup
            }
          }
        },
      );
    } catch (e) {
      appLogger.e('Error initiating call: $e');
      final errorMessage = 'Failed to start call. Please try again.';
      ref.read(toastControllerProvider).show(
        title: errorMessage,
        type: ToastType.error,
      );
      state = CallState.error(message: errorMessage);
    }
  }

  Future<void> acceptCall() async {
    await state.whenOrNull(
      ringing: (invitation) async {
        try {
          final usecase = ref.read(acceptCallUseCaseProvider);
          final result = await usecase.call(callId: invitation.callId);
          
          await result.fold(
            (failure) {
              appLogger.e('Failed to accept call: ${failure.userMessage}');
              ref.read(toastControllerProvider).show(
                title: failure.userMessage,
                type: ToastType.error,
              );
              state = CallState.error(message: failure.userMessage);
            },
            (connection) async {
              appLogger.i('Call accepted successfully: ${connection.callInfo.id}');
              
              try {
                // Initialize and join Agora
                final agoraService = ref.read(agoraServiceProvider);
                await agoraService.initialize();
                await agoraService.joinChannel(
                  token: connection.token,
                  channelId: connection.callInfo.channelId,
                  uid: connection.callInfo.calleeId,
                  isVideoCall: invitation.callType == CallType.video,
                );

                state = CallState.connecting(
                  connection: connection,
                  callType: invitation.callType,
                  isOutgoing: false,
                );
              } catch (agoraError) {
                appLogger.e('Agora error during call acceptance: $agoraError');
                final errorMessage = 'Failed to join call. Please check your connection and try again.';
                ref.read(toastControllerProvider).show(
                  title: errorMessage,
                  type: ToastType.error,
                );
                state = CallState.error(message: errorMessage);

                // Clean up the call on backend since we couldn't join
                try {
                  final endUsecase = ref.read(endCallUseCaseProvider);
                  await endUsecase.call(
                    callId: connection.callInfo.id,
                    reason: CallEndReason.networkError,
                  );
                } catch (_) {
                  // Ignore errors during cleanup
                }
              }
            },
          );
        } catch (e) {
          appLogger.e('Error accepting call: $e');
          final errorMessage = 'Failed to accept call. Please try again.';
          ref.read(toastControllerProvider).show(
            title: errorMessage,
            type: ToastType.error,
          );
          state = CallState.error(message: errorMessage);
        }
      },
    );
  }

  Future<void> rejectCall() async {
    await state.whenOrNull(
      ringing: (invitation) async {
        try {
          final usecase = ref.read(rejectCallUseCaseProvider);
          await usecase.call(
            callId: invitation.callId,
            reason: CallRejectReason.declined,
          );
          
          state = const CallState.ended(reason: 'Call declined');
        } catch (e) {
          appLogger.e('Error rejecting call: $e');
          state = const CallState.ended(reason: 'Call declined');
        }
      },
    );
  }

  Future<void> endCall() async {
    final currentState = state;
    
    String? callId;
    currentState.whenOrNull(
      connecting: (connection, _, __) => callId = connection.callInfo.id,
      connected: (connection, _, __, ___, ____, _____, ______, _______) => callId = connection.callInfo.id,
    );
    
    if (callId != null) {
      try {
        final usecase = ref.read(endCallUseCaseProvider);
        await usecase.call(
          callId: callId!,
          reason: CallEndReason.hangup,
        );
      } catch (e) {
        appLogger.e('Error ending call: $e');
      }
    }
    
    _endCallCleanup();
    state = const CallState.ended(reason: 'Call ended');
  }

  void _endCallCleanup() {
    final agoraService = ref.read(agoraServiceProvider);
    agoraService.leaveChannel();
    WakelockPlus.disable();
  }

  // Call controls
  Future<void> toggleMute() async {
    state.whenOrNull(
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled, isSpeakerEnabled, isFrontCamera, remoteUid) async {
        final agoraService = ref.read(agoraServiceProvider);
        await agoraService.toggleMute(!isMuted);
        
        state = CallState.connected(
          connection: connection,
          callType: callType,
          isOutgoing: isOutgoing,
          isMuted: !isMuted,
          isVideoEnabled: isVideoEnabled,
          isSpeakerEnabled: isSpeakerEnabled,
          isFrontCamera: isFrontCamera,
          remoteUid: remoteUid,
        );
      },
    );
  }

  Future<void> toggleVideo() async {
    state.whenOrNull(
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled, isSpeakerEnabled, isFrontCamera, remoteUid) async {
        if (callType == CallType.video) {
          final agoraService = ref.read(agoraServiceProvider);
          await agoraService.toggleVideo(!isVideoEnabled);
          
          state = CallState.connected(
            connection: connection,
            callType: callType,
            isOutgoing: isOutgoing,
            isMuted: isMuted,
            isVideoEnabled: !isVideoEnabled,
            isSpeakerEnabled: isSpeakerEnabled,
            isFrontCamera: isFrontCamera,
            remoteUid: remoteUid,
          );
        }
      },
    );
  }

  Future<void> toggleSpeaker() async {
    state.whenOrNull(
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled, isSpeakerEnabled, isFrontCamera, remoteUid) async {
        final agoraService = ref.read(agoraServiceProvider);
        await agoraService.toggleSpeaker(!isSpeakerEnabled);
        
        state = CallState.connected(
          connection: connection,
          callType: callType,
          isOutgoing: isOutgoing,
          isMuted: isMuted,
          isVideoEnabled: isVideoEnabled,
          isSpeakerEnabled: !isSpeakerEnabled,
          isFrontCamera: isFrontCamera,
          remoteUid: remoteUid,
        );
      },
    );
  }

  Future<void> switchCamera() async {
    state.whenOrNull(
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled, isSpeakerEnabled, isFrontCamera, remoteUid) async {
        if (callType == CallType.video) {
          final agoraService = ref.read(agoraServiceProvider);
          await agoraService.switchCamera();
          
          state = CallState.connected(
            connection: connection,
            callType: callType,
            isOutgoing: isOutgoing,
            isMuted: isMuted,
            isVideoEnabled: isVideoEnabled,
            isSpeakerEnabled: isSpeakerEnabled,
            isFrontCamera: !isFrontCamera,
            remoteUid: remoteUid,
          );
        }
      },
    );
  }
}

