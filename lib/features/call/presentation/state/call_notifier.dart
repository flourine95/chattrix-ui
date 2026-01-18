import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/toast/toast_type.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_invitation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_control_state_providers.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_service_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_timer_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_usecase_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_websocket_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'call_notifier.g.dart';

@riverpod
class CallNotifier extends _$CallNotifier {
  StreamSubscription? _incomingCallSubscription;
  StreamSubscription? _participantUpdateSubscription;
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

    // WebSocket listeners - theo API spec mới
    _incomingCallSubscription = wsDataSource.incomingCallStream.listen(_handleIncomingCall);
    _participantUpdateSubscription = wsDataSource.participantUpdateStream.listen(_handleParticipantUpdate);
    _callTimeoutSubscription = wsDataSource.callTimeoutStream.listen(_handleCallTimeout);

    // Agora listeners
    _userJoinedSubscription = agoraService.userJoinedStream.listen(_handleUserJoined);
    _userOfflineSubscription = agoraService.userOfflineStream.listen(_handleUserOffline);
    _remoteVideoStateSubscription = agoraService.remoteVideoStateStream.listen(_handleRemoteVideoStateChanged);
    _remoteAudioStateSubscription = agoraService.remoteAudioStateStream.listen(_handleRemoteAudioStateChanged);
  }

  void _cleanup() {
    _incomingCallSubscription?.cancel();
    _participantUpdateSubscription?.cancel();
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

  /// Handle participant update event (JOINED, LEFT, REJECTED)
  /// Theo API spec mới, tất cả updates về participants đều qua event này
  void _handleParticipantUpdate(dynamic update) {
    AppLogger.call('Participant update: userId=${update.userId}, status=${update.status}');

    final currentState = state;
    
    // Lấy callId từ state hiện tại
    String? currentCallId;
    currentState.whenOrNull(
      connecting: (connection, _, _) => currentCallId = connection.callInfo.id,
      connected: (connection, _, _, _, _, _, _, _, _, _) => currentCallId = connection.callInfo.id,
    );

    // Chỉ xử lý nếu update thuộc về cuộc gọi hiện tại
    if (currentCallId != update.callId) {
      return;
    }

    // Xử lý theo status
    switch (update.status.toString()) {
      case 'CallParticipantStatus.joined':
        AppLogger.call('Participant ${update.fullName} joined the call');
        // Agora sẽ handle việc hiển thị video/audio qua userJoinedStream
        break;
        
      case 'CallParticipantStatus.left':
        AppLogger.call('Participant ${update.fullName} left the call');
        // Nếu là cuộc gọi 1-1, end call
        currentState.whenOrNull(
          connected: (connection, _, _, _, _, _, _, remoteUid, _, _) {
            _endCallCleanup();
            state = CallState.ended(reason: '${update.fullName} left the call');
          },
        );
        break;
        
      case 'CallParticipantStatus.rejected':
        AppLogger.call('Participant ${update.fullName} rejected the call');
        currentState.whenOrNull(
          connecting: (connection, callType, isOutgoing) {
            if (isOutgoing) {
              // Caller nhận thông báo callee reject
              _endCallCleanup();
              state = CallState.ended(reason: '${update.fullName} declined the call');
            }
          },
        );
        break;
        
      case 'CallParticipantStatus.missed':
        AppLogger.call('Participant ${update.fullName} missed the call');
        break;
        
      default:
        AppLogger.call('Unknown participant status: ${update.status}');
    }
  }

  void _handleCallTimeout(dynamic timeout) {
    AppLogger.call('Call timeout: ${timeout.callId}');
    _endCallCleanup();
    state = CallState.ended(reason: 'Call timeout: ${timeout.reason}');
  }

  void _handleUserJoined(int remoteUid) {
    AppLogger.call('🎉 Remote user joined Agora: $remoteUid');
    AppLogger.call('📱 Current state before transition: ${state.runtimeType}');

    final wasHandled = state.whenOrNull(
      connecting: (connection, callType, isOutgoing) {
        AppLogger.call('✅ Transitioning from CONNECTING to CONNECTED');

        // Initialize separate state providers
        ref.read(isMutedStateProvider.notifier).set(false);
        ref.read(isVideoEnabledStateProvider.notifier).set(callType == CallType.video);
        ref.read(isSpeakerEnabledStateProvider.notifier).set(true);
        ref.read(isFrontCameraStateProvider.notifier).set(true);
        ref.read(remoteUidStateProvider.notifier).set(remoteUid);
        ref.read(remoteIsMutedStateProvider.notifier).set(false);
        ref.read(remoteIsVideoEnabledStateProvider.notifier).set(callType == CallType.video);

        // Start call timer
        ref.read(callTimerProvider.notifier).start();

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
        AppLogger.call(
          '📱 State changed to CONNECTED (${state.runtimeType}), router should redirect to active call page',
        );
        WakelockPlus.enable();
        return true;
      },
    );

    if (wasHandled != true) {
      AppLogger.warning(
        '⚠️ User joined but state was not CONNECTING, current state: ${state.runtimeType}',
        tag: 'Call',
      );
    }
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
            _,
          ) {
            if (currentRemoteUid == remoteUid) {
              _endCallCleanup();
              state = const CallState.ended(reason: 'Remote user left');
            }
          },
    );
  }

  void _handleRemoteVideoStateChanged(dynamic remoteVideoState) {
    AppLogger.call('Remote video state changed: uid=${remoteVideoState.uid}, state=${remoteVideoState.state}');

    final currentRemoteUid = ref.read(remoteUidStateProvider);
    if (currentRemoteUid == remoteVideoState.uid) {
      final isRemoteVideoOn =
          remoteVideoState.state == RemoteVideoState.remoteVideoStateDecoding ||
          remoteVideoState.state == RemoteVideoState.remoteVideoStateStarting;

      ref.read(remoteIsVideoEnabledStateProvider.notifier).set(isRemoteVideoOn);
      AppLogger.call('Updated remote video state: $isRemoteVideoOn');
    }
  }

  void _handleRemoteAudioStateChanged(dynamic remoteAudioState) {
    AppLogger.call('Remote audio state changed: uid=${remoteAudioState.uid}, state=${remoteAudioState.state}');

    final currentRemoteUid = ref.read(remoteUidStateProvider);
    if (currentRemoteUid == remoteAudioState.uid) {
      final isRemoteMuted =
          remoteAudioState.state == RemoteAudioState.remoteAudioStateStopped ||
          remoteAudioState.reason == RemoteAudioStateReason.remoteAudioReasonLocalMuted;

      ref.read(remoteIsMutedStateProvider.notifier).set(isRemoteMuted);
      AppLogger.call('Updated remote audio state: muted=$isRemoteMuted');
    }
  }

  Future<void> initiateCall(
    int conversationId,
    CallType callType, {
    String? conversationName,
    String? conversationAvatar,
  }) async {
    try {
      AppLogger.call('🚀 Initiating call in conversation $conversationId, type: $callType');
      state = CallState.initiating(
        calleeId: conversationId,
        callType: callType,
        calleeName: conversationName,
        calleeAvatar: conversationAvatar,
      );
      AppLogger.call('📱 State changed to INITIATING');

      final usecase = ref.read(initiateCallUseCaseProvider);
      AppLogger.call('📞 Calling backend API to initiate call...');
      final result = await usecase.call(conversationId: conversationId, callType: callType);
      AppLogger.call('📡 Backend API response received');

      await result.fold(
        (failure) {
          final message = _getFailureMessage(failure);
          AppLogger.error('Failed to initiate call: $message', tag: 'Call');
          ref.read(toastControllerProvider).show(title: message, type: ToastType.error);
          state = CallState.error(message: message);
        },
        (connection) async {
          AppLogger.call('✅ Call initiated successfully: ${connection.callInfo.id}');
          AppLogger.call(
            '📋 Call details: channelId=${connection.callInfo.channelId}, callerId=${connection.callInfo.callerId}',
          );

          try {
            final agoraService = ref.read(agoraServiceProvider);
            AppLogger.call('🎥 Initializing Agora service...');
            await agoraService.initialize();
            AppLogger.call('✅ Agora initialized');

            AppLogger.call('🔗 Joining Agora channel: ${connection.callInfo.channelId}');
            await agoraService.joinChannel(
              token: connection.token,
              channelId: connection.callInfo.channelId,
              uid: connection.callInfo.callerId,
              isVideoCall: callType == CallType.video,
            );
            AppLogger.call('✅ Joined Agora channel successfully');

            state = CallState.connecting(connection: connection, callType: callType, isOutgoing: true);
            AppLogger.call('📱 State changed to CONNECTING, waiting for others to join...');
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
                  uid: connection.callInfo.callerId,
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

  /// Join an ongoing call (for late joiners)
  Future<void> joinCall(String callId, CallType callType) async {
    try {
      AppLogger.call('🚀 Joining ongoing call: $callId');
      state = CallState.initiating(calleeId: 0, callType: callType, calleeName: 'Group Call', calleeAvatar: null);

      final usecase = ref.read(joinCallUseCaseProvider);
      final result = await usecase.call(callId: callId);

      await result.fold(
        (failure) {
          final message = _getFailureMessage(failure);
          AppLogger.error('Failed to join call: $message', tag: 'Call');
          ref.read(toastControllerProvider).show(title: message, type: ToastType.error);
          state = CallState.error(message: message);
        },
        (connection) async {
          AppLogger.call('✅ Joined call successfully: ${connection.callInfo.id}');

          try {
            final agoraService = ref.read(agoraServiceProvider);
            await agoraService.initialize();
            await agoraService.joinChannel(
              token: connection.token,
              channelId: connection.callInfo.channelId,
              uid: connection.callInfo.callerId,
              isVideoCall: callType == CallType.video,
            );

            state = CallState.connecting(connection: connection, callType: callType, isOutgoing: false);
            AppLogger.call('📱 State changed to CONNECTING');
          } catch (agoraError, stack) {
            AppLogger.error('Agora error during call join', error: agoraError, stackTrace: stack, tag: 'Call');
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
      AppLogger.error('Error joining call', error: e, stackTrace: stack, tag: 'Call');
      final errorMessage = 'Failed to join call. Please try again.';
      ref.read(toastControllerProvider).show(title: errorMessage, type: ToastType.error);
      state = CallState.error(message: errorMessage);
    }
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

    // Stop call timer
    ref.read(callTimerProvider.notifier).stop();
  }

  Future<void> toggleMute() async {
    try {
      final agoraService = ref.read(agoraServiceProvider);
      final currentMuted = ref.read(isMutedStateProvider);
      await agoraService.toggleMute(!currentMuted);
      // Update state AFTER Agora success
      ref.read(isMutedStateProvider.notifier).toggle();
    } catch (e) {
      AppLogger.error('Failed to toggle mute', error: e, tag: 'Call');
    }
  }

  Future<void> toggleVideo() async {
    await state.whenOrNull(
      connected: (_, callType, _, _, _, _, _, _, _, _) async {
        if (callType == CallType.video) {
          try {
            final agoraService = ref.read(agoraServiceProvider);
            final currentVideoEnabled = ref.read(isVideoEnabledStateProvider);
            await agoraService.toggleVideo(!currentVideoEnabled);
            // Update state AFTER Agora success
            ref.read(isVideoEnabledStateProvider.notifier).toggle();
          } catch (e) {
            AppLogger.error('Failed to toggle video', error: e, tag: 'Call');
          }
        }
      },
    );
  }

  Future<void> toggleSpeaker() async {
    try {
      final agoraService = ref.read(agoraServiceProvider);
      final currentSpeakerEnabled = ref.read(isSpeakerEnabledStateProvider);
      await agoraService.toggleSpeaker(!currentSpeakerEnabled);
      // Update state AFTER Agora success
      ref.read(isSpeakerEnabledStateProvider.notifier).toggle();
    } catch (e) {
      AppLogger.error('Failed to toggle speaker', error: e, tag: 'Call');
    }
  }

  Future<void> switchCamera() async {
    await state.whenOrNull(
      connected: (_, callType, _, _, _, _, _, _, _, _) async {
        if (callType == CallType.video) {
          try {
            final agoraService = ref.read(agoraServiceProvider);
            await agoraService.switchCamera();
            // Update state AFTER Agora success
            ref.read(isFrontCameraStateProvider.notifier).toggle();
          } catch (e) {
            AppLogger.error('Failed to switch camera', error: e, tag: 'Call');
          }
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
