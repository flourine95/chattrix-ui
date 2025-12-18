import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/toast/toast_type.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_usecase_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_websocket_provider.dart';
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
  StreamSubscription? _remoteVideoStateSubscription;
  StreamSubscription? _remoteAudioStateSubscription;

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
    final wsDataSource = ref.watch(callWebSocketDataSourceProvider);
    final agoraService = ref.watch(agoraServiceProvider);

    _incomingCallSubscription = wsDataSource.incomingCallStream.listen(_handleIncomingCall);
    _callAcceptedSubscription = wsDataSource.callAcceptedStream.listen(_handleCallAccepted);
    _callRejectedSubscription = wsDataSource.callRejectedStream.listen(_handleCallRejected);
    _callEndedSubscription = wsDataSource.callEndedStream.listen(_handleCallEnded);
    _callTimeoutSubscription = wsDataSource.callTimeoutStream.listen(_handleCallTimeout);

    _userJoinedSubscription = agoraService.userJoinedStream.listen(_handleUserJoined);
    _userOfflineSubscription = agoraService.userOfflineStream.listen(_handleUserOffline);
    _remoteVideoStateSubscription = agoraService.remoteVideoStateStream.listen(_handleRemoteVideoStateChanged);
    _remoteAudioStateSubscription = agoraService.remoteAudioStateStream.listen(_handleRemoteAudioStateChanged);
  }

  void _cleanup() {
    _incomingCallSubscription?.cancel();
    _callAcceptedSubscription?.cancel();
    _callRejectedSubscription?.cancel();
    _callEndedSubscription?.cancel();
    _callTimeoutSubscription?.cancel();
    _userJoinedSubscription?.cancel();
    _userOfflineSubscription?.cancel();
    _remoteVideoStateSubscription?.cancel();
    _remoteAudioStateSubscription?.cancel();
    WakelockPlus.disable();
  }

  void _handleIncomingCall(CallInvitation invitation) {
    AppLogger.call('Handling incoming call: ${invitation.callId} from ${invitation.callerName}');
    state = CallState.ringing(invitation: invitation);
    AppLogger.call('State changed to RINGING');
  }

  void _handleCallAccepted(CallAccept accept) {
    AppLogger.call('Call accepted: ${accept.callId}');
    state.whenOrNull(
      connecting: (connection, callType, isOutgoing) {
        if (isOutgoing && connection.callInfo.id == accept.callId) {
          AppLogger.call('Waiting for callee to join Agora channel');
        }
      },
    );
  }

  void _handleCallRejected(CallReject reject) {
    AppLogger.call('Call rejected: ${reject.callId}, reason: ${reject.reason}');

    state.whenOrNull(
      connecting: (connection, callType, isOutgoing) {
        if (connection.callInfo.id == reject.callId) {
          AppLogger.call('Handling reject for matching call');
          _endCallCleanup();
          state = const CallState.ended(reason: 'Call was rejected');
        }
      },
    );
  }

  void _handleCallEnded(CallEnd end) {
    AppLogger.call('Call ended: ${end.callId}');

    final shouldHandle = state.when(
      idle: () => false,
      initiating: (_, __) => false,
      ringing: (invitation) => invitation.callId == end.callId,
      connecting: (connection, _, __) => connection.callInfo.id == end.callId,
      connected: (connection, p1, p2, p3, p4, p5, p6, p7, p8, p9) => connection.callInfo.id == end.callId,
      ended: (_) => false,
      error: (_) => false,
    );

    if (shouldHandle) {
      AppLogger.call('Handling end for matching call');
      _endCallCleanup();
      state = const CallState.ended(reason: 'Call ended');
    }
  }

  void _handleCallTimeout(timeout) {
    AppLogger.call('Call timeout: ${timeout.callId}');
    _endCallCleanup();
    state = CallState.ended(reason: 'Call timeout: ${timeout.reason}');
  }

  void _handleUserJoined(int remoteUid) {
    AppLogger.call('Remote user joined Agora: $remoteUid');
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
          remoteIsMuted: false,
          remoteIsVideoEnabled: callType == CallType.video,
        );
        WakelockPlus.enable();
      },
    );
  }

  void _handleUserOffline(int remoteUid) {
    AppLogger.call('Remote user offline: $remoteUid');
    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            currentRemoteUid,
            _,
            __,
          ) {
            if (currentRemoteUid == remoteUid) {
              _endCallCleanup();
              state = const CallState.ended(reason: 'Remote user left');
            }
          },
    );
  }

  void _handleRemoteVideoStateChanged(remoteVideoState) {
    AppLogger.call('Remote video state changed: uid=${remoteVideoState.uid}, state=${remoteVideoState.state}');

    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) {
            if (remoteUid == remoteVideoState.uid) {
              final isRemoteVideoOn =
                  remoteVideoState.state == RemoteVideoState.remoteVideoStateDecoding ||
                  remoteVideoState.state == RemoteVideoState.remoteVideoStateStarting;

              state = CallState.connected(
                connection: connection,
                callType: callType,
                isOutgoing: isOutgoing,
                isMuted: isMuted,
                isVideoEnabled: isVideoEnabled,
                isSpeakerEnabled: isSpeakerEnabled,
                isFrontCamera: isFrontCamera,
                remoteUid: remoteUid,
                remoteIsMuted: remoteIsMuted,
                remoteIsVideoEnabled: isRemoteVideoOn,
              );

              AppLogger.call('Updated remote video state: $isRemoteVideoOn');
            }
          },
    );
  }

  void _handleRemoteAudioStateChanged(remoteAudioState) {
    AppLogger.call('Remote audio state changed: uid=${remoteAudioState.uid}, state=${remoteAudioState.state}');

    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) {
            if (remoteUid == remoteAudioState.uid) {
              final isRemoteMuted =
                  remoteAudioState.state == RemoteAudioState.remoteAudioStateStopped ||
                  remoteAudioState.reason == RemoteAudioStateReason.remoteAudioReasonLocalMuted;

              state = CallState.connected(
                connection: connection,
                callType: callType,
                isOutgoing: isOutgoing,
                isMuted: isMuted,
                isVideoEnabled: isVideoEnabled,
                isSpeakerEnabled: isSpeakerEnabled,
                isFrontCamera: isFrontCamera,
                remoteUid: remoteUid,
                remoteIsMuted: isRemoteMuted,
                remoteIsVideoEnabled: remoteIsVideoEnabled,
              );

              AppLogger.call('Updated remote audio state: muted=$isRemoteMuted');
            }
          },
    );
  }

  Future<void> initiateCall(int calleeId, CallType callType) async {
    try {
      state = CallState.initiating(calleeId: calleeId, callType: callType);

      final usecase = ref.read(initiateCallUseCaseProvider);
      final result = await usecase.call(calleeId: calleeId, callType: callType);

      await result.fold(
        (failure) {
          final message = _getFailureMessage(failure);
          AppLogger.error('Failed to initiate call: $message', tag: 'Call');
          ref.read(toastControllerProvider).show(title: message, type: ToastType.error);
          state = CallState.error(message: message);
        },
        (connection) async {
          AppLogger.call('Call initiated successfully: ${connection.callInfo.id}');

          try {
            final agoraService = ref.read(agoraServiceProvider);
            await agoraService.initialize();
            await agoraService.joinChannel(
              token: connection.token,
              channelId: connection.callInfo.channelId,
              uid: connection.callInfo.callerId,
              isVideoCall: callType == CallType.video,
            );

            state = CallState.connecting(connection: connection, callType: callType, isOutgoing: true);
          } catch (agoraError, stack) {
            AppLogger.error('Agora error during call initiation', error: agoraError, stackTrace: stack, tag: 'Call');
            final errorMessage = 'Failed to join call. Please check your connection and try again.';
            ref.read(toastControllerProvider).show(title: errorMessage, type: ToastType.error);
            state = CallState.error(message: errorMessage);

            try {
              final endUsecase = ref.read(endCallUseCaseProvider);
              await endUsecase.call(callId: connection.callInfo.id, reason: CallEndReason.networkError);
            } catch (_) {}
          }
        },
      );
    } catch (e, stack) {
      AppLogger.error('Error initiating call', error: e, stackTrace: stack, tag: 'Call');
      final errorMessage = 'Failed to start call. Please try again.';
      ref.read(toastControllerProvider).show(title: errorMessage, type: ToastType.error);
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
              final message = _getFailureMessage(failure);
              AppLogger.error('Failed to accept call: $message', tag: 'Call');
              ref.read(toastControllerProvider).show(title: message, type: ToastType.error);
              state = CallState.error(message: message);
            },
            (connection) async {
              AppLogger.call('Call accepted successfully: ${connection.callInfo.id}');

              try {
                final agoraService = ref.read(agoraServiceProvider);
                await agoraService.initialize();
                await agoraService.joinChannel(
                  token: connection.token,
                  channelId: connection.callInfo.channelId,
                  uid: connection.callInfo.calleeId,
                  isVideoCall: invitation.callType == CallType.video,
                );

                state = CallState.connecting(connection: connection, callType: invitation.callType, isOutgoing: false);
              } catch (agoraError, stack) {
                AppLogger.error(
                  'Agora error during call acceptance',
                  error: agoraError,
                  stackTrace: stack,
                  tag: 'Call',
                );
                final errorMessage = 'Failed to join call. Please check your connection and try again.';
                ref.read(toastControllerProvider).show(title: errorMessage, type: ToastType.error);
                state = CallState.error(message: errorMessage);

                try {
                  final endUsecase = ref.read(endCallUseCaseProvider);
                  await endUsecase.call(callId: connection.callInfo.id, reason: CallEndReason.networkError);
                } catch (_) {}
              }
            },
          );
        } catch (e, stack) {
          AppLogger.error('Error accepting call', error: e, stackTrace: stack, tag: 'Call');
          final errorMessage = 'Failed to accept call. Please try again.';
          ref.read(toastControllerProvider).show(title: errorMessage, type: ToastType.error);
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
          await usecase.call(callId: invitation.callId, reason: CallRejectReason.declined);

          state = const CallState.ended(reason: 'Call declined');
        } catch (e, stack) {
          AppLogger.error('Error rejecting call', error: e, stackTrace: stack, tag: 'Call');
          state = const CallState.ended(reason: 'Call declined');
        }
      },
    );
  }

  Future<void> endCall() async {
    final currentState = state;

    String? callId;
    currentState.whenOrNull(
      connecting: (connection, _, _) => callId = connection.callInfo.id,
      connected: (connection, p1, p2, p3, p4, p5, p6, p7, p8, p9) => callId = connection.callInfo.id,
    );

    if (callId != null) {
      try {
        final usecase = ref.read(endCallUseCaseProvider);
        await usecase.call(callId: callId!, reason: CallEndReason.hangup);
        AppLogger.call('Call ended and notified to backend: $callId');
      } catch (e, stack) {
        AppLogger.error('Error ending call', error: e, stackTrace: stack, tag: 'Call');
      }
    } else {
      AppLogger.call('Cancelling call during initiation (no callId yet)');
    }

    _endCallCleanup();
    state = const CallState.ended(reason: 'Call ended');
  }

  void _endCallCleanup() {
    final agoraService = ref.read(agoraServiceProvider);
    agoraService.leaveChannel();
    WakelockPlus.disable();
  }

  Future<void> toggleMute() async {
    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) async {
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
              remoteIsMuted: remoteIsMuted,
              remoteIsVideoEnabled: remoteIsVideoEnabled,
            );
          },
    );
  }

  Future<void> toggleVideo() async {
    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) async {
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
                remoteIsMuted: remoteIsMuted,
                remoteIsVideoEnabled: remoteIsVideoEnabled,
              );
            }
          },
    );
  }

  Future<void> toggleSpeaker() async {
    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) async {
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
              remoteIsMuted: remoteIsMuted,
              remoteIsVideoEnabled: remoteIsVideoEnabled,
            );
          },
    );
  }

  Future<void> switchCamera() async {
    state.whenOrNull(
      connected:
          (
            connection,
            callType,
            isOutgoing,
            isMuted,
            isVideoEnabled,
            isSpeakerEnabled,
            isFrontCamera,
            remoteUid,
            remoteIsMuted,
            remoteIsVideoEnabled,
          ) async {
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
                remoteIsMuted: remoteIsMuted,
                remoteIsVideoEnabled: remoteIsVideoEnabled,
              );
            }
          },
    );
  }

  /// Map Failure to user-friendly error message
  String _getFailureMessage(Failure failure) {
    return failure.when(
      server: (message, code, requestId) => message,
      network: (message, code) => message,
      validation: (message, code, details, requestId) => message,
      auth: (message, code, requestId) => message,
      notFound: (message, code, requestId) => message,
      conflict: (message, code, requestId) => message,
      rateLimit: (message, code, requestId) => message,
    );
  }
}
