import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';

/// Service wrapper for Agora RTC Engine SDK
/// Provides a clean interface for managing real-time audio/video communication
class AgoraEngineService {
  RtcEngine? _engine;

  /// Gets the current RTC engine instance
  RtcEngine? get engine => _engine;

  /// Initializes the Agora RTC Engine with the provided App ID
  ///
  /// This should be called once at app startup or before the first call
  /// [appId] - The Agora App ID from the dashboard
  Future<void> initialize(String appId) async {
    if (_engine != null) {
      debugPrint('AgoraEngineService: Engine already initialized');
      return;
    }

    try {
      // Create RTC engine instance
      _engine = createAgoraRtcEngine();

      // Initialize with app ID
      await _engine!.initialize(
        RtcEngineContext(appId: appId, channelProfile: ChannelProfileType.channelProfileCommunication),
      );

      // Enable audio by default
      await _engine!.enableAudio();

      // Enable video (will be used for video calls)
      await _engine!.enableVideo();

      debugPrint('AgoraEngineService: Engine initialized successfully');
    } catch (e) {
      debugPrint('AgoraEngineService: Failed to initialize engine: $e');
      rethrow;
    }
  }

  /// Joins an Agora channel with the provided credentials
  ///
  /// [token] - The Agora token from the backend
  /// [channelId] - The unique channel identifier
  /// [uid] - The user ID (0 for auto-assignment)
  /// [isVideo] - Whether this is a video call (true) or audio only (false)
  ///
  /// Requirement 8.2: Handle Agora SDK errors with proper error messages
  Future<void> joinChannel({
    required String token,
    required String channelId,
    required int uid,
    required bool isVideo,
  }) async {
    if (_engine == null) {
      throw Exception('Engine not initialized. Call initialize() first.');
    }

    try {
      // Configure channel options
      final options = ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
        autoSubscribeVideo: isVideo,
        publishCameraTrack: isVideo,
        publishMicrophoneTrack: true,
      );

      // Join the channel
      await _engine!.joinChannel(token: token, channelId: channelId, uid: uid, options: options);

      debugPrint('AgoraEngineService: Joined channel $channelId with uid $uid');
    } catch (e) {
      // Provide more specific error messages
      final errorMessage = e.toString();
      if (errorMessage.contains('token')) {
        debugPrint('AgoraEngineService: Invalid or expired token');
        throw Exception('Invalid call token. Please try again.');
      } else if (errorMessage.contains('network')) {
        debugPrint('AgoraEngineService: Network error during join');
        throw Exception('Network error. Please check your connection.');
      } else if (errorMessage.contains('permission')) {
        debugPrint('AgoraEngineService: Permission denied');
        throw Exception('Permission denied. Please enable camera and microphone.');
      } else {
        debugPrint('AgoraEngineService: Failed to join channel: $e');
        throw Exception('Failed to join call: $errorMessage');
      }
    }
  }

  /// Leaves the current Agora channel
  ///
  /// This should be called when ending a call
  Future<void> leaveChannel() async {
    if (_engine == null) {
      debugPrint('AgoraEngineService: Engine not initialized');
      return;
    }

    try {
      await _engine!.leaveChannel();
      debugPrint('AgoraEngineService: Left channel successfully');
    } catch (e) {
      debugPrint('AgoraEngineService: Failed to leave channel: $e');
      rethrow;
    }
  }

  /// Mutes or unmutes the local audio stream
  ///
  /// [mute] - true to mute, false to unmute
  Future<void> muteLocalAudio(bool mute) async {
    if (_engine == null) {
      throw Exception('Engine not initialized');
    }

    try {
      await _engine!.muteLocalAudioStream(mute);
      debugPrint('AgoraEngineService: Local audio ${mute ? 'muted' : 'unmuted'}');
    } catch (e) {
      debugPrint('AgoraEngineService: Failed to mute/unmute audio: $e');
      rethrow;
    }
  }

  /// Enables or disables the local video stream
  ///
  /// [mute] - true to disable video, false to enable video
  Future<void> muteLocalVideo(bool mute) async {
    if (_engine == null) {
      throw Exception('Engine not initialized');
    }

    try {
      await _engine!.muteLocalVideoStream(mute);
      debugPrint('AgoraEngineService: Local video ${mute ? 'disabled' : 'enabled'}');
    } catch (e) {
      debugPrint('AgoraEngineService: Failed to enable/disable video: $e');
      rethrow;
    }
  }

  /// Switches between front and rear camera
  ///
  /// Only applicable for video calls on mobile devices
  Future<void> switchCamera() async {
    if (_engine == null) {
      throw Exception('Engine not initialized');
    }

    try {
      await _engine!.switchCamera();
      debugPrint('AgoraEngineService: Camera switched');
    } catch (e) {
      debugPrint('AgoraEngineService: Failed to switch camera: $e');
      rethrow;
    }
  }

  /// Registers event handlers for Agora RTC events
  ///
  /// [onUserJoined] - Called when a remote user joins the channel
  /// [onUserOffline] - Called when a remote user leaves the channel
  /// [onNetworkQuality] - Called when network quality changes
  /// [onError] - Called when an error occurs
  void registerEventHandlers({
    required Function(RtcConnection connection, int remoteUid, int elapsed) onUserJoined,
    required Function(RtcConnection connection, int remoteUid, UserOfflineReasonType reason) onUserOffline,
    required Function(RtcConnection connection, int localUid, QualityType txQuality, QualityType rxQuality)
    onNetworkQuality,
    required Function(ErrorCodeType err, String msg) onError,
  }) {
    if (_engine == null) {
      throw Exception('Engine not initialized');
    }

    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(
            'AgoraEngineService: Join channel success - channel: ${connection.channelId}, uid: ${connection.localUid}',
          );
        },
        onUserJoined: onUserJoined,
        onUserOffline: onUserOffline,
        onNetworkQuality: onNetworkQuality,
        onError: onError,
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          debugPrint('AgoraEngineService: Left channel - ${connection.channelId}');
        },
      ),
    );

    debugPrint('AgoraEngineService: Event handlers registered');
  }

  /// Disposes the Agora RTC Engine and releases all resources
  ///
  /// This should be called when the service is no longer needed
  Future<void> dispose() async {
    if (_engine == null) {
      debugPrint('AgoraEngineService: Engine already disposed or not initialized');
      return;
    }

    try {
      // Leave channel if still in one
      await leaveChannel();

      // Release the engine
      await _engine!.release();
      _engine = null;

      debugPrint('AgoraEngineService: Engine disposed successfully');
    } catch (e) {
      debugPrint('AgoraEngineService: Error during disposal: $e');
      // Still set to null even if there's an error
      _engine = null;
    }
  }
}
