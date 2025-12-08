import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  RtcEngine? _engine;
  bool _isInitialized = false;

  StreamController<int>? _userJoinedController;
  StreamController<int>? _userOfflineController;
  StreamController<ConnectionStateType>? _connectionStateController;
  StreamController<RemoteVideoStateInfo>? _remoteVideoStateController;
  StreamController<RemoteAudioStateInfo>? _remoteAudioStateController;

  Stream<int> get userJoinedStream => _userJoinedController!.stream;
  Stream<int> get userOfflineStream => _userOfflineController!.stream;
  Stream<ConnectionStateType> get connectionStateStream => _connectionStateController!.stream;
  Stream<RemoteVideoStateInfo> get remoteVideoStateStream => _remoteVideoStateController!.stream;
  Stream<RemoteAudioStateInfo> get remoteAudioStateStream => _remoteAudioStateController!.stream;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) {
      AppLogger.warning('Agora Engine already initialized', tag: 'Agora');
      return;
    }

    try {
      AppLogger.info('Initializing Agora Service...', tag: 'Agora');

      final appId = dotenv.env['AGORA_APP_ID'];
      if (appId == null || appId.isEmpty) {
        throw Exception('AGORA_APP_ID not found in environment');
      }

      _initControllers();
      await _requestPermissions();

      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      _registerEventHandlers();

      await _engine!.enableVideo();
      await _engine!.startPreview();
      await _engine!.setDefaultAudioRouteToSpeakerphone(true);

      _isInitialized = true;
      AppLogger.success('Agora RTC Engine initialized successfully', tag: 'Agora');
    } catch (e, stack) {
      AppLogger.error('Failed to initialize Agora', error: e, stackTrace: stack, tag: 'Agora');
      rethrow;
    }
  }

  void _initControllers() {
    _disposeControllers();

    _userJoinedController = StreamController<int>.broadcast();
    _userOfflineController = StreamController<int>.broadcast();
    _connectionStateController = StreamController<ConnectionStateType>.broadcast();
    _remoteVideoStateController = StreamController<RemoteVideoStateInfo>.broadcast();
    _remoteAudioStateController = StreamController<RemoteAudioStateInfo>.broadcast();
  }

  Future<void> _requestPermissions() async {
    final status = await [Permission.camera, Permission.microphone].request();

    if (status[Permission.camera] != PermissionStatus.granted ||
        status[Permission.microphone] != PermissionStatus.granted) {
      AppLogger.warning('Camera or Microphone permission denied', tag: 'Agora');
    }
  }

  void _registerEventHandlers() {
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          AppLogger.success('Joined channel: ${connection.channelId}', tag: 'Agora');
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          AppLogger.info('Remote user joined: $remoteUid', tag: 'Agora');
          _userJoinedController?.add(remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          AppLogger.info('Remote user offline: $remoteUid ($reason)', tag: 'Agora');
          _userOfflineController?.add(remoteUid);
        },
        onConnectionStateChanged: (RtcConnection connection, ConnectionStateType state, ConnectionChangedReasonType reason) {
          AppLogger.info('Connection state: $state ($reason)', tag: 'Agora');
          _connectionStateController?.add(state);
        },
        onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid, RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
          _remoteVideoStateController?.add(RemoteVideoStateInfo(uid: remoteUid, state: state, reason: reason));
        },
        onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid, RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
          _remoteAudioStateController?.add(RemoteAudioStateInfo(uid: remoteUid, state: state, reason: reason));
        },
        onError: (ErrorCodeType err, String msg) {
          AppLogger.error('Agora Internal Error: $err - $msg', tag: 'Agora');
        },
      ),
    );
  }

  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideoCall,
  }) async {
    if (!_isInitialized || _engine == null) {
      AppLogger.error('Attempted to join channel before initialization', tag: 'Agora');
      return;
    }

    try {
      if (isVideoCall) {
        await _engine!.enableLocalVideo(true);
        await _engine!.startPreview();
      } else {
        await _engine!.enableLocalVideo(false);
      }

      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );

      AppLogger.info('Joining channel $channelId as uid: $uid', tag: 'Agora');
    } catch (e, stack) {
      AppLogger.error('Failed to join channel', error: e, stackTrace: stack, tag: 'Agora');
      rethrow;
    }
  }

  Future<void> leaveChannel() async {
    if (_engine == null) return;
    try {
      await _engine!.leaveChannel();
      await _engine!.stopPreview();
      AppLogger.info('Left channel', tag: 'Agora');
    } catch (e) {
      AppLogger.error('Error leaving channel: $e', tag: 'Agora');
    }
  }

  Future<void> toggleMute(bool mute) async {
    if (_engine == null) return;
    await _engine!.muteLocalAudioStream(mute);
    AppLogger.info('Microphone ${mute ? 'muted' : 'unmuted'}', tag: 'Agora');
  }

  Future<void> toggleVideo(bool enable) async {
    if (_engine == null) return;

    await _engine!.enableLocalVideo(enable);

    if (enable) {
      await _engine!.startPreview();
    } else {
      await _engine!.stopPreview();
    }
    AppLogger.info('Camera ${enable ? 'enabled' : 'disabled'}', tag: 'Agora');
  }

  Future<void> toggleSpeaker(bool enable) async {
    if (_engine == null) return;
    await _engine!.setEnableSpeakerphone(enable);
    AppLogger.info('Speaker ${enable ? 'enabled' : 'disabled'}', tag: 'Agora');
  }

  Future<void> switchCamera() async {
    if (_engine == null) return;
    try {
      await _engine!.switchCamera();
      AppLogger.info('Camera switched', tag: 'Agora');
    } catch (e) {
      AppLogger.error('Failed to switch camera: $e', tag: 'Agora');
    }
  }

  Future<void> dispose() async {
    try {
      await leaveChannel();
      if (_engine != null) {
        await _engine!.release();
        _engine = null;
      }
      _disposeControllers();
      _isInitialized = false;
      AppLogger.success('Agora service disposed', tag: 'Agora');
    } catch (e) {
      AppLogger.error('Error disposing Agora service: $e', tag: 'Agora');
    }
  }

  void _disposeControllers() {
    _userJoinedController?.close();
    _userOfflineController?.close();
    _connectionStateController?.close();
    _remoteVideoStateController?.close();
    _remoteAudioStateController?.close();

    _userJoinedController = null;
    _userOfflineController = null;
    _connectionStateController = null;
    _remoteVideoStateController = null;
    _remoteAudioStateController = null;
  }

  RtcEngine? get engine => _engine;
}

class RemoteVideoStateInfo {
  final int uid;
  final RemoteVideoState state;
  final RemoteVideoStateReason reason;

  RemoteVideoStateInfo({required this.uid, required this.state, required this.reason});
}

class RemoteAudioStateInfo {
  final int uid;
  final RemoteAudioState state;
  final RemoteAudioStateReason reason;

  RemoteAudioStateInfo({required this.uid, required this.state, required this.reason});
}