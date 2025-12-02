import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/call_models.dart';
import '../services/agora_service.dart';
import '../services/call_api_service.dart';

// Providers
final agoraServiceProvider = Provider<AgoraService>((ref) {
  final service = AgoraService();
  ref.onDispose(() => service.dispose());
  return service;
});

final callApiServiceProvider = Provider<CallApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return CallApiService(dio);
});

// Call state
enum CallStateStatus {
  idle,
  initiating,
  ringing,
  connecting,
  connected,
  ended,
}

class CallState {
  final CallStateStatus status;
  final CallConnection? connection;
  final CallInvitation? invitation;
  final String? error;
  final bool isMuted;
  final bool isCameraOn;
  final bool isSpeakerOn;
  final int? remoteUid;

  CallState({
    this.status = CallStateStatus.idle,
    this.connection,
    this.invitation,
    this.error,
    this.isMuted = false,
    this.isCameraOn = true,
    this.isSpeakerOn = true,
    this.remoteUid,
  });

  CallState copyWith({
    CallStateStatus? status,
    CallConnection? connection,
    CallInvitation? invitation,
    String? error,
    bool? isMuted,
    bool? isCameraOn,
    bool? isSpeakerOn,
    int? remoteUid,
  }) {
    return CallState(
      status: status ?? this.status,
      connection: connection ?? this.connection,
      invitation: invitation ?? this.invitation,
      error: error ?? this.error,
      isMuted: isMuted ?? this.isMuted,
      isCameraOn: isCameraOn ?? this.isCameraOn,
      isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn,
      remoteUid: remoteUid ?? this.remoteUid,
    );
  }
}

// Call controller using Notifier
class CallController extends Notifier<CallState> {
  late final AgoraService _agoraService;
  late final CallApiService _apiService;

  @override
  CallState build() {
    _agoraService = ref.watch(agoraServiceProvider);
    _apiService = ref.watch(callApiServiceProvider);
    return CallState();
  }

  // Initiate a call
  Future<void> initiateCall(int calleeId, CallType callType) async {
    try {
      state = state.copyWith(status: CallStateStatus.initiating);
      appLogger.i('Initiating call to user $calleeId');

      // Request permissions
      final hasPermission = await _agoraService.requestPermissions(callType);
      if (!hasPermission) {
        throw Exception('Permissions not granted');
      }

      // Initialize Agora
      if (!_agoraService.isInitialized) {
        await _agoraService.initialize();
      }

      // Call API
      final request = InitiateCallRequest(calleeId: calleeId, callType: callType);
      final connection = await _apiService.initiateCall(request);

      state = state.copyWith(
        status: CallStateStatus.ringing,
        connection: connection,
      );

      // Join channel
      await _joinChannel(connection);
    } catch (e, stack) {
      appLogger.e('Failed to initiate call', error: e, stackTrace: stack);
      state = state.copyWith(
        status: CallStateStatus.ended,
        error: e.toString(),
      );
    }
  }

  // Accept incoming call
  Future<void> acceptCall(CallInvitation invitation) async {
    try {
      state = state.copyWith(status: CallStateStatus.connecting);
      appLogger.i('Accepting call ${invitation.callId}');

      // Request permissions
      final hasPermission = await _agoraService.requestPermissions(invitation.callType);
      if (!hasPermission) {
        throw Exception('Permissions not granted');
      }

      // Initialize Agora
      if (!_agoraService.isInitialized) {
        await _agoraService.initialize();
      }

      // Call API
      final connection = await _apiService.acceptCall(invitation.callId);

      state = state.copyWith(
        status: CallStateStatus.connected,
        connection: connection,
      );

      // Join channel
      await _joinChannel(connection);
    } catch (e, stack) {
      appLogger.e('Failed to accept call', error: e, stackTrace: stack);
      state = state.copyWith(
        status: CallStateStatus.ended,
        error: e.toString(),
      );
    }
  }

  // Reject incoming call
  Future<void> rejectCall(String callId, RejectReason reason) async {
    try {
      appLogger.i('Rejecting call $callId');
      final request = RejectCallRequest(reason: reason);
      await _apiService.rejectCall(callId, request);
      state = state.copyWith(status: CallStateStatus.ended);
    } catch (e, stack) {
      appLogger.e('Failed to reject call', error: e, stackTrace: stack);
    }
  }

  // End call
  Future<void> endCall() async {
    try {
      final callId = state.connection?.callInfo.id;
      if (callId == null) return;

      appLogger.i('Ending call $callId');

      await _agoraService.leaveChannel();

      final request = EndCallRequest();
      await _apiService.endCall(callId, request);

      state = state.copyWith(status: CallStateStatus.ended);
    } catch (e, stack) {
      appLogger.e('Failed to end call', error: e, stackTrace: stack);
    }
  }

  // Toggle microphone
  Future<void> toggleMicrophone() async {
    final newMuted = !state.isMuted;
    await _agoraService.toggleMicrophone(!newMuted);
    state = state.copyWith(isMuted: newMuted);
  }

  // Toggle camera
  Future<void> toggleCamera() async {
    final newCameraOn = !state.isCameraOn;
    await _agoraService.toggleCamera(newCameraOn);
    state = state.copyWith(isCameraOn: newCameraOn);
  }

  // Toggle speaker
  Future<void> toggleSpeaker() async {
    final newSpeakerOn = !state.isSpeakerOn;
    await _agoraService.toggleSpeaker(newSpeakerOn);
    state = state.copyWith(isSpeakerOn: newSpeakerOn);
  }

  // Switch camera
  Future<void> switchCamera() async {
    await _agoraService.switchCamera();
  }

  // Handle incoming call
  void handleIncomingCall(CallInvitation invitation) {
    state = state.copyWith(
      status: CallStateStatus.ringing,
      invitation: invitation,
    );
  }

  // Handle call accepted
  void handleCallAccepted() {
    state = state.copyWith(status: CallStateStatus.connected);
  }

  // Handle call ended
  void handleCallEnded() {
    _agoraService.leaveChannel();
    state = state.copyWith(status: CallStateStatus.ended);
  }

  // Handle remote user joined
  void handleRemoteUserJoined(int uid) {
    appLogger.i('Remote user joined: $uid');
    state = state.copyWith(
      remoteUid: uid,
      status: CallStateStatus.connected,
    );
  }

  // Handle remote user left
  void handleRemoteUserLeft(int uid) {
    appLogger.i('Remote user left: $uid');
    if (state.remoteUid == uid) {
      state = state.copyWith(remoteUid: null);
    }
  }

  // Private: Join channel
  Future<void> _joinChannel(CallConnection connection) async {
    final callInfo = connection.callInfo;
    appLogger.i('Joining channel: ${callInfo.channelId}');

    // Setup event handlers
    _agoraService.engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          appLogger.i('Joined channel successfully');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          handleRemoteUserJoined(remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          handleRemoteUserLeft(remoteUid);
        },
        onLeaveChannel: (connection, stats) {
          appLogger.i('Left channel');
        },
        onError: (err, msg) {
          appLogger.e('Agora error: $err - $msg');
        },
      ),
    );

    // Join channel
    await _agoraService.joinChannel(
      token: connection.token,
      channelId: callInfo.channelId,
      uid: 0, // Let Agora assign UID
      callType: callInfo.callType,
    );
  }
}

// Provider for call controller
final callControllerProvider = NotifierProvider.autoDispose<CallController, CallState>(
  CallController.new,
);

