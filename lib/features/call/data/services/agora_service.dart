import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';

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

  /// Check if currently in an active channel
  /// This is independent of WebSocket connection state
  bool get isInChannel => _localUid != null;

  /// Initialize the Agora RTC Engine with app ID from environment
  /// IMPORTANT: Agora RTC operates independently of WebSocket connection
  /// Media streaming continues even if WebSocket disconnects
  Future<void> initialize(String appId) async {
    if (_isInitialized) {
      debugPrint('[AgoraService] ℹ️ Engine already initialized, skipping reinitialization');
      return;
    }

    try {
      // Log initialization start
      debugPrint('[AgoraService] 🚀 Starting Agora engine initialization...');
      debugPrint('[AgoraService] 🔑 App ID: ${appId.length >= 8 ? appId.substring(0, 8) : appId}...');
      debugPrint('[AgoraService] 📡 Channel Profile: Communication (0)');

      // Create RTC engine
      _engine = createAgoraRtcEngine();

      // Initialize the engine
      await _engine!.initialize(
        RtcEngineContext(appId: appId, channelProfile: ChannelProfileType.channelProfileCommunication),
      );

      // Register event handlers
      _registerEventHandlers();

      _isInitialized = true;
      debugPrint('[AgoraService] ✅ Agora engine initialized successfully');
    } catch (e) {
      debugPrint('[AgoraService] ❌ Failed to initialize Agora engine: $e');
      _eventController.add(
        ErrorEvent(errorCode: ErrorCodeType.errFailed, message: 'Failed to initialize Agora engine: $e'),
      );
      rethrow;
    }
  }

  /// Join a channel with token authentication
  /// IMPORTANT: Once joined, the Agora RTC connection is independent of WebSocket
  /// Media streaming will continue even if WebSocket disconnects and reconnects
  /// Only call signaling (accept/reject/end messages) requires WebSocket
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

      // Log join attempt details
      debugPrint('[AgoraService] 🎯 Attempting to join channel...');
      debugPrint('[AgoraService] 📺 Channel ID: $channelId');
      debugPrint('[AgoraService] 👤 UID: $uid');
      debugPrint('[AgoraService] 🎥 Video enabled: $isVideo');
      debugPrint('[AgoraService] 🔐 Token (first 20 chars): ${token.length >= 20 ? token.substring(0, 20) : token}...');
      debugPrint('[AgoraService] ⚙️ ChannelMediaOptions: {clientRoleType: Broadcaster (1)}');

      // Enable audio
      await _engine!.enableAudio();
      debugPrint('[AgoraService] 🔊 Audio enabled');

      // Enable video if needed
      if (isVideo) {
        await _engine!.enableVideo();
        await _engine!.startPreview();
        debugPrint('[AgoraService] 📹 Video enabled and preview started');
      } else {
        await _engine!.disableVideo();
        debugPrint('[AgoraService] 📹 Video disabled (audio-only call)');
      }

      // Join the channel
      // Note: channelProfile is already set during engine initialization
      // and should NOT be overridden here to avoid error -17
      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(clientRoleType: ClientRoleType.clientRoleBroadcaster),
      );

      debugPrint('[AgoraService] ✅ Join channel request sent successfully');
    } catch (e) {
      debugPrint('[AgoraService] ❌ Failed to join channel: $e');
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

    debugPrint('[AgoraService] 📋 Registering Agora event handlers...');

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('[AgoraService] ✅ Join channel SUCCESS');
          debugPrint('[AgoraService]    └─ Channel: ${connection.channelId ?? 'unknown'}');
          debugPrint('[AgoraService]    └─ Local UID: ${connection.localUid ?? 0}');
          debugPrint('[AgoraService]    └─ Elapsed time: ${elapsed}ms');

          _eventController.add(
            JoinChannelSuccessEvent(
              channelId: connection.channelId ?? '',
              uid: connection.localUid ?? 0,
              elapsed: elapsed,
            ),
          );
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint('[AgoraService] 👥 User JOINED');
          debugPrint('[AgoraService]    └─ Remote UID: $remoteUid');
          debugPrint('[AgoraService]    └─ Elapsed time: ${elapsed}ms');

          _eventController.add(UserJoinedEvent(remoteUid: remoteUid, elapsed: elapsed));
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint('[AgoraService] 👋 User OFFLINE');
          debugPrint('[AgoraService]    └─ Remote UID: $remoteUid');
          debugPrint('[AgoraService]    └─ Reason: $reason');

          _eventController.add(UserOfflineEvent(remoteUid: remoteUid, reason: reason));
        },
        onNetworkQuality: (RtcConnection connection, int remoteUid, QualityType txQuality, QualityType rxQuality) {
          debugPrint('[AgoraService] 📶 Network quality update');
          debugPrint('[AgoraService]    └─ UID: $remoteUid');
          debugPrint('[AgoraService]    └─ TX Quality: $txQuality');
          debugPrint('[AgoraService]    └─ RX Quality: $rxQuality');

          _eventController.add(NetworkQualityEvent(uid: remoteUid, txQuality: txQuality, rxQuality: rxQuality));
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[AgoraService] ⚠️ Token privilege will expire');
          debugPrint(
            '[AgoraService]    └─ Token (first 20 chars): ${token.length >= 20 ? token.substring(0, 20) : token}...',
          );

          _eventController.add(TokenPrivilegeWillExpireEvent(token: token));
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('[AgoraService] ❌ Agora ERROR event');
          debugPrint('[AgoraService]    └─ Error code: $err');
          debugPrint('[AgoraService]    └─ Message: $msg');

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
