import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  RtcEngine? _engine;
  bool _isInitialized = false;

  // Stream controllers for events
  final _userJoinedController = StreamController<int>.broadcast();
  final _userOfflineController = StreamController<int>.broadcast();
  final _connectionStateController = StreamController<ConnectionStateType>.broadcast();
  final _remoteVideoStateController = StreamController<RemoteVideoStateInfo>.broadcast();
  final _remoteAudioStateController = StreamController<RemoteAudioStateInfo>.broadcast();

  Stream<int> get userJoinedStream => _userJoinedController.stream;
  Stream<int> get userOfflineStream => _userOfflineController.stream;
  Stream<ConnectionStateType> get connectionStateStream => _connectionStateController.stream;
  Stream<RemoteVideoStateInfo> get remoteVideoStateStream => _remoteVideoStateController.stream;
  Stream<RemoteAudioStateInfo> get remoteAudioStateStream => _remoteAudioStateController.stream;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      final appId = dotenv.env['AGORA_APP_ID'];
      if (appId == null || appId.isEmpty) {
        throw Exception('AGORA_APP_ID not found in environment');
      }

      // Request permissions
      await _requestPermissions();

      // Create RTC engine
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      // Register event handlers
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            appLogger.i('Successfully joined channel: ${connection.channelId}');
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            appLogger.i('Remote user joined: $remoteUid');
            _userJoinedController.add(remoteUid);
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            appLogger.i('Remote user offline: $remoteUid, reason: $reason');
            _userOfflineController.add(remoteUid);
          },
          onConnectionStateChanged: (RtcConnection connection, ConnectionStateType state, ConnectionChangedReasonType reason) {
            appLogger.i('Connection state changed: $state, reason: $reason');
            _connectionStateController.add(state);
          },
          onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid, RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
            appLogger.i('Remote video state changed: uid=$remoteUid, state=$state, reason=$reason');
            _remoteVideoStateController.add(RemoteVideoStateInfo(
              uid: remoteUid,
              state: state,
              reason: reason,
            ));
          },
          onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid, RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
            appLogger.i('Remote audio state changed: uid=$remoteUid, state=$state, reason=$reason');
            _remoteAudioStateController.add(RemoteAudioStateInfo(
              uid: remoteUid,
              state: state,
              reason: reason,
            ));
          },
          onError: (ErrorCodeType err, String msg) {
            appLogger.e('Agora error: $err, message: $msg');
          },
        ),
      );

      // Enable video module (always enable, we'll control it with enableLocalVideo)
      await _engine!.enableVideo();

      // Set default audio route to speaker
      await _engine!.setDefaultAudioRouteToSpeakerphone(true);

      _isInitialized = true;
      appLogger.i('Agora RTC Engine initialized successfully');
    } catch (e) {
      appLogger.e('Failed to initialize Agora: $e');
      rethrow;
    }
  }

  Future<void> _requestPermissions() async {
    await [Permission.camera, Permission.microphone].request();
  }

  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideoCall,
  }) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      // Configure for video or audio call
      if (isVideoCall) {
        await _engine!.enableLocalVideo(true);
        await _engine!.startPreview();
      } else {
        await _engine!.enableLocalVideo(false);
      }

      // Join channel
      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );

      appLogger.i('Joined Agora channel: $channelId with uid: $uid');
    } catch (e) {
      appLogger.e('Failed to join channel: $e');
      rethrow;
    }
  }

  Future<void> leaveChannel() async {
    if (_engine == null) return;

    try {
      await _engine!.leaveChannel();
      await _engine!.stopPreview();
      appLogger.i('Left Agora channel');
    } catch (e) {
      appLogger.e('Failed to leave channel: $e');
    }
  }

  Future<void> toggleMute(bool mute) async {
    if (_engine == null) return;
    await _engine!.muteLocalAudioStream(mute);
    appLogger.i('Local audio ${mute ? 'muted' : 'unmuted'}');
  }

  Future<void> toggleVideo(bool enabled) async {
    if (_engine == null) return;
    await _engine!.enableLocalVideo(enabled);
    if (enabled) {
      await _engine!.startPreview();
    } else {
      await _engine!.stopPreview();
    }
    appLogger.i('Local video ${enabled ? 'enabled' : 'disabled'}');
  }

  Future<void> toggleSpeaker(bool enabled) async {
    if (_engine == null) return;
    await _engine!.setEnableSpeakerphone(enabled);
    appLogger.i('Speaker ${enabled ? 'enabled' : 'disabled'}');
  }

  Future<void> switchCamera() async {
    if (_engine == null) return;
    await _engine!.switchCamera();
    appLogger.i('Camera switched');
  }

  Future<void> dispose() async {
    try {
      await leaveChannel();
      await _engine?.release();
      _engine = null;
      _isInitialized = false;

      await _userJoinedController.close();
      await _userOfflineController.close();
      await _connectionStateController.close();
      await _remoteVideoStateController.close();
      await _remoteAudioStateController.close();

      appLogger.i('Agora service disposed');
    } catch (e) {
      appLogger.e('Error disposing Agora service: $e');
    }
  }

  RtcEngine? get engine => _engine;
}

class RemoteVideoStateInfo {
  final int uid;
  final RemoteVideoState state;
  final RemoteVideoStateReason reason;

  RemoteVideoStateInfo({
    required this.uid,
    required this.state,
    required this.reason,
  });
}

class RemoteAudioStateInfo {
  final int uid;
  final RemoteAudioState state;
  final RemoteAudioStateReason reason;

  RemoteAudioStateInfo({
    required this.uid,
    required this.state,
    required this.reason,
  });
}

