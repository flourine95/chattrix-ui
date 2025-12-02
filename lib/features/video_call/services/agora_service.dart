import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/call_models.dart';

class AgoraService {
  RtcEngine? _engine;
  bool _isInitialized = false;

  RtcEngine? get engine => _engine;
  bool get isInitialized => _isInitialized;

  /// Initialize Agora Engine
  Future<void> initialize() async {
    if (_isInitialized) {
      appLogger.w('Agora engine already initialized');
      return;
    }

    try {
      final appId = dotenv.env['AGORA_APP_ID'];
      if (appId == null || appId.isEmpty) {
        throw Exception('AGORA_APP_ID not found in .env file');
      }

      appLogger.i('Initializing Agora engine with appId: $appId');

      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      // Enable video by default
      await _engine!.enableVideo();
      await _engine!.startPreview();

      _isInitialized = true;
      appLogger.i('Agora engine initialized successfully');
    } catch (e, stack) {
      appLogger.e('Failed to initialize Agora', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Request camera and microphone permissions
  Future<bool> requestPermissions(CallType callType) async {
    try {
      appLogger.i('Requesting permissions for call type: $callType');

      final permissions = <Permission>[Permission.microphone];
      if (callType == CallType.video) {
        permissions.add(Permission.camera);
      }

      final statuses = await permissions.request();
      final allGranted = statuses.values.every((status) => status.isGranted);

      if (allGranted) {
        appLogger.i('All permissions granted');
      } else {
        appLogger.w('Some permissions denied: $statuses');
      }

      return allGranted;
    } catch (e, stack) {
      appLogger.e('Failed to request permissions', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Join a call channel
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required CallType callType,
  }) async {
    if (!_isInitialized || _engine == null) {
      throw Exception('Agora engine not initialized');
    }

    try {
      appLogger.i('Joining channel: $channelId with uid: $uid');

      if (callType == CallType.audio) {
        await _engine!.disableVideo();
      } else {
        await _engine!.enableVideo();
      }

      final options = ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
        autoSubscribeVideo: callType == CallType.video,
        publishMicrophoneTrack: true,
        publishCameraTrack: callType == CallType.video,
      );

      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: options,
      );

      appLogger.i('Joined channel successfully');
    } catch (e, stack) {
      appLogger.e('Failed to join channel', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Leave the current channel
  Future<void> leaveChannel() async {
    if (_engine == null) return;

    try {
      appLogger.i('Leaving channel');
      await _engine!.leaveChannel();
      appLogger.i('Left channel successfully');
    } catch (e, stack) {
      appLogger.e('Failed to leave channel', error: e, stackTrace: stack);
    }
  }

  /// Toggle microphone
  Future<void> toggleMicrophone(bool enabled) async {
    if (_engine == null) return;

    try {
      appLogger.i('Toggle microphone: $enabled');
      await _engine!.muteLocalAudioStream(!enabled);
    } catch (e, stack) {
      appLogger.e('Failed to toggle microphone', error: e, stackTrace: stack);
    }
  }

  /// Toggle camera
  Future<void> toggleCamera(bool enabled) async {
    if (_engine == null) return;

    try {
      appLogger.i('Toggle camera: $enabled');
      await _engine!.muteLocalVideoStream(!enabled);
    } catch (e, stack) {
      appLogger.e('Failed to toggle camera', error: e, stackTrace: stack);
    }
  }

  /// Switch camera (front/back)
  Future<void> switchCamera() async {
    if (_engine == null) return;

    try {
      appLogger.i('Switching camera');
      await _engine!.switchCamera();
    } catch (e, stack) {
      appLogger.e('Failed to switch camera', error: e, stackTrace: stack);
    }
  }

  /// Enable/disable speaker
  Future<void> toggleSpeaker(bool enabled) async {
    if (_engine == null) return;

    try {
      appLogger.i('Toggle speaker: $enabled');
      await _engine!.setEnableSpeakerphone(enabled);
    } catch (e, stack) {
      appLogger.e('Failed to toggle speaker', error: e, stackTrace: stack);
    }
  }

  /// Dispose the engine
  Future<void> dispose() async {
    if (_engine == null) return;

    try {
      appLogger.i('Disposing Agora engine');
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
      _isInitialized = false;
      appLogger.i('Agora engine disposed');
    } catch (e, stack) {
      appLogger.e('Failed to dispose Agora engine', error: e, stackTrace: stack);
    }
  }
}

