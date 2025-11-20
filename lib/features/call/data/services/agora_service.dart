import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

/// Events emitted by the Agora service
abstract class CallEvent {}

class JoinChannelSuccessEvent extends CallEvent {
  final String channelId;
  final int uid;
  final int elapsed;

  JoinChannelSuccessEvent({required this.channelId, required this.uid, required this.elapsed});
}

class UserJoinedEvent extends CallEvent {
  final int remoteUid;
  final int elapsed;

  UserJoinedEvent({required this.remoteUid, required this.elapsed});
}

class UserOfflineEvent extends CallEvent {
  final int remoteUid;
  final UserOfflineReasonType reason;

  UserOfflineEvent({required this.remoteUid, required this.reason});
}

class NetworkQualityEvent extends CallEvent {
  final int uid;
  final QualityType txQuality;
  final QualityType rxQuality;

  NetworkQualityEvent({required this.uid, required this.txQuality, required this.rxQuality});
}

class TokenPrivilegeWillExpireEvent extends CallEvent {
  final String token;

  TokenPrivilegeWillExpireEvent({required this.token});
}

class ErrorEvent extends CallEvent {
  final ErrorCodeType errorCode;
  final String message;

  ErrorEvent({required this.errorCode, required this.message});
}

/// Service wrapper for Agora RTC Engine
class AgoraService {
  RtcEngine? _engine;
  final StreamController<CallEvent> _eventController = StreamController<CallEvent>.broadcast();
  bool _isInitialized = false;
  int? _localUid;

  /// Get the event stream for Agora callbacks
  Stream<CallEvent> get events => _eventController.stream;

  /// Check if the engine is initialized
  bool get isInitialized => _isInitialized;

  /// Get the local user ID
  int? get localUid => _localUid;

  /// Get the RTC engine instance
  RtcEngine? get engine => _engine;

  /// Initialize the Agora RTC Engine with app ID from environment
  Future<void> initialize(String appId) async {
    if (_isInitialized) {
      return;
    }

    try {
      // Create RTC engine
      _engine = createAgoraRtcEngine();

      // Initialize the engine
      await _engine!.initialize(
        RtcEngineContext(appId: appId, channelProfile: ChannelProfileType.channelProfileCommunication),
      );

      // Register event handlers
      _registerEventHandlers();

      _isInitialized = true;
    } catch (e) {
      _eventController.add(
        ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to initialize Agora engine: $e'),
      );
      rethrow;
    }
  }

  /// Join a channel with token authentication
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideo,
  }) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      _localUid = uid;

      // Enable audio
      await _engine!.enableAudio();

      // Enable video if needed
      if (isVideo) {
        await _engine!.enableVideo();
        await _engine!.startPreview();
      } else {
        await _engine!.disableVideo();
      }

      // Join the channel
      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
    } catch (e) {
      _eventController.add(
        ErrorEvent(errorCode: ErrorCodeType.errJoinChannelRejected, message: 'Failed to join channel: $e'),
      );
      rethrow;
    }
  }

  /// Leave the current channel and cleanup
  Future<void> leaveChannel() async {
    if (!_isInitialized || _engine == null) {
      return;
    }

    try {
      await _engine!.leaveChannel();
      await _engine!.stopPreview();
      _localUid = null;
    } catch (e) {
      _eventController.add(
        ErrorEvent(errorCode: ErrorCodeType.errLeaveChannelRejected, message: 'Failed to leave channel: $e'),
      );
      rethrow;
    }
  }

  /// Register event handlers for Agora callbacks
  void _registerEventHandlers() {
    if (_engine == null) return;

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _eventController.add(
            JoinChannelSuccessEvent(
              channelId: connection.channelId ?? '',
              uid: connection.localUid ?? 0,
              elapsed: elapsed,
            ),
          );
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _eventController.add(UserJoinedEvent(remoteUid: remoteUid, elapsed: elapsed));
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          _eventController.add(UserOfflineEvent(remoteUid: remoteUid, reason: reason));
        },
        onNetworkQuality: (RtcConnection connection, int remoteUid, QualityType txQuality, QualityType rxQuality) {
          _eventController.add(NetworkQualityEvent(uid: remoteUid, txQuality: txQuality, rxQuality: rxQuality));
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          _eventController.add(TokenPrivilegeWillExpireEvent(token: token));
        },
        onError: (ErrorCodeType err, String msg) {
          _eventController.add(ErrorEvent(errorCode: err, message: msg));
        },
      ),
    );
  }

  /// Mute or unmute local audio stream
  Future<void> muteLocalAudioStream(bool mute) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      await _engine!.muteLocalAudioStream(mute);
    } catch (e) {
      _eventController.add(ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to mute/unmute audio: $e'));
      rethrow;
    }
  }

  /// Mute or unmute local video stream
  Future<void> muteLocalVideoStream(bool mute) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      await _engine!.muteLocalVideoStream(mute);
    } catch (e) {
      _eventController.add(ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to mute/unmute video: $e'));
      rethrow;
    }
  }

  /// Switch between front and rear camera
  Future<void> switchCamera() async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      await _engine!.switchCamera();
    } catch (e) {
      _eventController.add(ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to switch camera: $e'));
      rethrow;
    }
  }

  /// Enable video
  Future<void> enableVideo() async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      await _engine!.enableVideo();
      await _engine!.startPreview();
    } catch (e) {
      _eventController.add(ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to enable video: $e'));
      rethrow;
    }
  }

  /// Enable audio
  Future<void> enableAudio() async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      await _engine!.enableAudio();
    } catch (e) {
      _eventController.add(ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to enable audio: $e'));
      rethrow;
    }
  }

  /// Dispose the service and release resources
  Future<void> dispose() async {
    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
    }
    await _eventController.close();
    _isInitialized = false;
    _localUid = null;
  }
}
