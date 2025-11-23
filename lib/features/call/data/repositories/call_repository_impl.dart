import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_local_datasource_impl.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/data/services/agora_service.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/data/services/channel_id_validator.dart';
import 'package:chattrix_ui/features/call/data/services/permission_service.dart';
import 'package:chattrix_ui/features/call/data/services/token_service.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CallRepositoryImpl implements CallRepository {
  final AgoraService _agoraService;
  final CallLocalDataSourceImpl _localDataSource;
  final CallRemoteDataSource _remoteDataSource;
  final TokenService _tokenService;
  final PermissionService _permissionService;
  final CallSignalingService _signalingService;

  // Current call state
  CallEntity? _currentCall;
  String? _currentToken; // Store current token for refresh purposes
  final StreamController<CallEntity> _callStateController = StreamController<CallEntity>.broadcast();
  final StreamController<NetworkQuality> _networkQualityController = StreamController<NetworkQuality>.broadcast();

  // Subscription to Agora events
  StreamSubscription<CallEvent>? _agoraEventSubscription;

  // Subscription to call ended notifications
  StreamSubscription? _callEndedSubscription;

  CallRepositoryImpl({
    required AgoraService agoraService,
    required CallLocalDataSourceImpl localDataSource,
    required CallRemoteDataSource remoteDataSource,
    required TokenService tokenService,
    required PermissionService permissionService,
    required CallSignalingService signalingService,
  }) : _agoraService = agoraService,
       _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _tokenService = tokenService,
       _permissionService = permissionService,
       _signalingService = signalingService {
    _listenToCallEndedNotifications();
  }

  /// Listen to call ended notifications from remote participants
  void _listenToCallEndedNotifications() {
    _callEndedSubscription = _signalingService.callEndedStream.listen((notification) {
      // If we have an active call with this ID, end it
      if (_currentCall != null && _currentCall!.callId == notification.callId) {
        endCall(notification.callId);
      }
    });
  }

  /// Check if Agora connection is active
  /// This is independent of WebSocket connection state
  bool get isAgoraConnected => _currentCall != null && _agoraService.isInitialized;

  @override
  Future<Either<Failure, void>> initialize() async {
    try {
      CallLogger.logInfo('Initializing Agora SDK');

      // Get Agora App ID from environment
      final appId = dotenv.env['AGORA_APP_ID'];

      if (appId == null || appId.isEmpty) {
        final failure = const Failure.agoraEngine(
          message: 'AGORA_APP_ID not found in environment variables',
          code: null,
        );
        CallLogger.logFailure(failure, context: 'initialize');
        return Left(failure);
      }

      // Initialize Agora service
      await _agoraService.initialize(appId);

      // Subscribe to Agora events
      _agoraEventSubscription = _agoraService.events.listen(_handleAgoraEvent);

      CallLogger.logInfo('Agora SDK initialized successfully');
      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.agoraEngine(message: 'Failed to initialize Agora SDK: ${e.toString()}', code: null);
      CallLogger.logFailure(failure, context: 'initialize', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Handle Agora events and update call state
  void _handleAgoraEvent(CallEvent event) {
    if (event is JoinChannelSuccessEvent) {
      // Update call status to connected
      if (_currentCall != null) {
        CallLogger.logCallEvent(
          callId: _currentCall!.callId,
          event: 'Join channel success',
          details: {'channelId': _currentCall!.channelId},
        );
        _currentCall = _currentCall!.copyWith(status: CallStatus.connected);
        _callStateController.add(_currentCall!);
      }
    } else if (event is UserJoinedEvent) {
      // Remote user joined
      if (_currentCall != null) {
        CallLogger.logCallEvent(
          callId: _currentCall!.callId,
          event: 'Remote user joined',
          details: {'remoteUid': event.remoteUid},
        );
        _currentCall = _currentCall!.copyWith(
          status: CallStatus.connected,
          remoteUid: event.remoteUid, // Set remote UID when user joins
        );
        _callStateController.add(_currentCall!);
      }
    } else if (event is UserOfflineEvent) {
      // Remote user left
      if (_currentCall != null) {
        CallLogger.logCallEvent(
          callId: _currentCall!.callId,
          event: 'Remote user left',
          details: {'remoteUid': event.remoteUid},
        );
        _currentCall = _currentCall!.copyWith(status: CallStatus.disconnecting);
        _callStateController.add(_currentCall!);
      }
    } else if (event is NetworkQualityEvent) {
      // Update network quality
      final quality = _mapQualityTypeToNetworkQuality(event.txQuality);
      _networkQualityController.add(quality);

      if (_currentCall != null) {
        CallLogger.logNetworkQuality(callId: _currentCall!.callId, quality: quality);
        _currentCall = _currentCall!.copyWith(networkQuality: quality);
        _callStateController.add(_currentCall!);
      }
    } else if (event is TokenPrivilegeWillExpireEvent) {
      // Handle token expiration
      if (_currentCall != null) {
        CallLogger.logCallEvent(callId: _currentCall!.callId, event: 'Token privilege will expire');
      }
      _handleTokenExpiration();
    } else if (event is ErrorEvent) {
      // Handle errors
      if (_currentCall != null) {
        CallLogger.logError('Agora error event', error: 'Error code: ${event.errorCode}');
      }
    }
  }

  /// Map Agora QualityType to NetworkQuality enum
  NetworkQuality _mapQualityTypeToNetworkQuality(QualityType quality) {
    switch (quality) {
      case QualityType.qualityExcellent:
        return NetworkQuality.excellent;
      case QualityType.qualityGood:
        return NetworkQuality.good;
      case QualityType.qualityPoor:
        return NetworkQuality.poor;
      case QualityType.qualityBad:
        return NetworkQuality.bad;
      case QualityType.qualityVbad:
        return NetworkQuality.veryBad;
      case QualityType.qualityDown:
      case QualityType.qualityUnknown:
      case QualityType.qualityDetecting:
      case QualityType.qualityUnsupported:
        return NetworkQuality.unknown;
    }
  }

  /// Handle token expiration by requesting a new token
  Future<void> _handleTokenExpiration() async {
    if (_currentCall == null || _currentToken == null) return;

    CallLogger.logCallEvent(
      callId: _currentCall!.callId,
      event: 'Handling token expiration',
      details: {'channelId': _currentCall!.channelId},
    );

    final result = await _tokenService.handleTokenExpiration(
      channelId: _currentCall!.channelId,
      oldToken: _currentToken!,
    );

    result.fold(
      (failure) {
        // Token refresh failed, end the call
        CallLogger.logFailure(failure, context: 'Token refresh failed');
        endCall(_currentCall!.callId);
      },
      (tokenData) {
        // Token refreshed successfully
        final newToken = tokenData['token'] as String;
        _currentToken = newToken;

        CallLogger.logCallEvent(callId: _currentCall!.callId, event: 'Token refreshed successfully');
        // Note: Agora SDK will automatically use the new token
      },
    );
  }

  @override
  Future<void> dispose() async {
    await _agoraEventSubscription?.cancel();
    await _callEndedSubscription?.cancel();
    await _callStateController.close();
    await _networkQualityController.close();
    await _agoraService.dispose();
  }

  @override
  Future<Either<Failure, CallEntity>> createCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
    String? callerId,
    String? callerName,
  }) async {
    try {
      CallLogger.logCallEvent(
        callId: callId,
        event: 'Creating call',
        details: {'remoteUserId': remoteUserId, 'callType': callType.name},
      );

      // If there's an active call, end it first
      if (_currentCall != null) {
        CallLogger.logCallEvent(
          callId: callId,
          event: 'Ending previous call before creating new one',
          details: {'previousCallId': _currentCall!.callId},
        );
        await endCall(_currentCall!.callId);
      }

      // Check if engine is initialized
      if (!_agoraService.isInitialized) {
        final initResult = await initialize();
        if (initResult.isLeft()) {
          return initResult.fold((failure) => Left(failure), (_) => throw Exception('Unexpected state'));
        }
      }

      // Request microphone permission for all calls FIRST
      final micResult = await _permissionService.requestMicrophonePermission();
      final micGranted = micResult.fold((failure) => false, (granted) => granted);

      CallLogger.logPermissionRequest(permission: 'microphone', granted: micGranted);

      if (!micGranted) {
        final failure = const Failure.permission(message: 'Microphone permission is required for calls');
        CallLogger.logFailure(failure, context: 'createCall');
        return Left(failure);
      }

      // Request camera permission for video calls
      if (callType == CallType.video) {
        final cameraResult = await _permissionService.requestCameraPermission();
        final cameraGranted = cameraResult.fold((failure) => false, (granted) => granted);

        CallLogger.logPermissionRequest(permission: 'camera', granted: cameraGranted);

        if (!cameraGranted) {
          final failure = const Failure.permission(message: 'Camera permission is required for video calls');
          CallLogger.logFailure(failure, context: 'createCall');
          return Left(failure);
        }
      }

      // Call REST API to create call
      // Backend will generate channel ID and send WebSocket invitation to callee
      final apiResult = await _remoteDataSource.initiateCall(calleeId: remoteUserId, callType: callType);

      // Handle API errors
      if (apiResult.isLeft()) {
        return apiResult.fold((failure) {
          CallLogger.logFailure(failure, context: 'createCall - REST API');
          return Left(failure);
        }, (_) => throw Exception('Unexpected state'));
      }

      final apiResponse = apiResult.getOrElse(() => throw Exception('Unexpected state'));

      // Extract backend-provided channel ID and call ID
      CallLogger.logDebug('API Response: $apiResponse');

      final backendChannelId = apiResponse['channelId'] as String?;
      final backendCallId = apiResponse['callId'] as String?;

      if (backendChannelId == null || backendChannelId.isEmpty) {
        final failure = const Failure.server(
          message: 'Backend did not return channelId',
          errorCode: 'MISSING_CHANNEL_ID',
        );
        CallLogger.logFailure(failure, context: 'createCall - missing channelId');
        return Left(failure);
      }

      if (backendCallId == null || backendCallId.isEmpty) {
        final failure = const Failure.server(message: 'Backend did not return callId', errorCode: 'MISSING_CALL_ID');
        CallLogger.logFailure(failure, context: 'createCall - missing callId');
        return Left(failure);
      }

      // Validate channel ID format
      ChannelIdValidator.validate(backendChannelId);

      CallLogger.logCallEvent(
        callId: backendCallId,
        event: 'Call created via REST API',
        details: {'channelId': backendChannelId, 'remoteUserId': remoteUserId},
      );

      // Fetch token from backend using the backend-provided channel ID
      final tokenResult = await _tokenService.fetchToken(channelId: backendChannelId);

      return tokenResult.fold(
        (failure) {
          CallLogger.logTokenOperation(operation: 'fetch', success: false, error: failure.toString());
          CallLogger.logFailure(failure, context: 'createCall - token fetch');
          return Left(failure);
        },
        (tokenData) async {
          // Extract token and UID from response
          final token = tokenData['token'] as String;
          final uid = tokenData['uid'] as int;

          // Store current token for refresh purposes
          _currentToken = token;

          CallLogger.logTokenOperation(operation: 'fetch', success: true);
          CallLogger.logCallEvent(
            callId: backendCallId,
            event: 'Token fetched',
            details: {'uid': uid, 'channelId': backendChannelId},
          );

          // Log Agora channel join with channelId, token (first 20 chars), and uid
          final tokenPreview = token.length > 20 ? '${token.substring(0, 20)}...' : token;
          CallLogger.logInfo('Joining Agora channel: channelId=$backendChannelId, token=$tokenPreview, uid=$uid');

          // Join the Agora channel using backend-provided channel ID
          await _agoraService.joinChannel(
            token: token,
            channelId: backendChannelId,
            uid: uid,
            isVideo: callType == CallType.video,
          );

          CallLogger.logCallEvent(
            callId: backendCallId,
            event: 'Joined Agora channel successfully',
            details: {'uid': uid, 'channelId': backendChannelId},
          );

          // Create call entity using backend-provided data
          final call = CallEntity(
            callId: backendCallId,
            channelId: backendChannelId,
            localUserId: uid.toString(),
            remoteUserId: remoteUserId,
            callType: callType,
            status: CallStatus.initiating,
            startTime: DateTime.now(),
            isLocalAudioMuted: false,
            isLocalVideoMuted: false,
            cameraFacing: CameraFacing.front,
          );

          // Store current call
          _currentCall = call;
          _callStateController.add(call);

          // Note: Backend already sent WebSocket invitation to callee when REST API was called
          // No need to send duplicate invitation from client

          CallLogger.logCallEvent(
            callId: backendCallId,
            event: 'Call created successfully',
            details: {'recipientId': remoteUserId, 'channelId': backendChannelId},
          );

          return Right(call);
        },
      );
    } catch (e, stackTrace) {
      final failure = Failure.channelJoin(message: 'Failed to create call: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'createCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CallEntity>> joinCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) async {
    try {
      // Validate channel ID format
      ChannelIdValidator.validate(channelId);

      // If there's an active call, end it first
      if (_currentCall != null) {
        CallLogger.logCallEvent(
          callId: callId,
          event: 'Ending previous call before joining new one',
          details: {'previousCallId': _currentCall!.callId},
        );
        await endCall(_currentCall!.callId);
      }

      // Check if engine is initialized
      if (!_agoraService.isInitialized) {
        final initResult = await initialize();
        if (initResult.isLeft()) {
          return initResult.fold((failure) => Left(failure), (_) => throw Exception('Unexpected state'));
        }
      }

      // Request microphone permission for all calls FIRST
      final micResult = await _permissionService.requestMicrophonePermission();
      final micGranted = micResult.fold((failure) => false, (granted) => granted);

      CallLogger.logPermissionRequest(permission: 'microphone', granted: micGranted);

      if (!micGranted) {
        final failure = const Failure.permission(message: 'Microphone permission is required for calls');
        CallLogger.logFailure(failure, context: 'joinCall');
        return Left(failure);
      }

      // Request camera permission for video calls
      if (callType == CallType.video) {
        final cameraResult = await _permissionService.requestCameraPermission();
        final cameraGranted = cameraResult.fold((failure) => false, (granted) => granted);

        CallLogger.logPermissionRequest(permission: 'camera', granted: cameraGranted);

        if (!cameraGranted) {
          final failure = const Failure.permission(message: 'Camera permission is required for video calls');
          CallLogger.logFailure(failure, context: 'joinCall');
          return Left(failure);
        }
      }

      // Fetch token from backend (backend generates UID from authenticated user)
      final tokenResult = await _tokenService.fetchToken(channelId: channelId);

      return tokenResult.fold((failure) => Left(failure), (tokenData) async {
        // Extract token and UID from response
        final token = tokenData['token'] as String;
        final uid = tokenData['uid'] as int;

        // Store current token for refresh purposes
        _currentToken = token;

        // Log Agora channel join with channelId, token (first 20 chars), and uid
        final tokenPreview = token.length > 20 ? '${token.substring(0, 20)}...' : token;
        CallLogger.logInfo('Joining Agora channel: channelId=$channelId, token=$tokenPreview, uid=$uid');

        // Join the Agora channel
        await _agoraService.joinChannel(
          token: token,
          channelId: channelId,
          uid: uid,
          isVideo: callType == CallType.video,
        );

        CallLogger.logCallEvent(
          callId: callId,
          event: 'Joined Agora channel successfully',
          details: {'uid': uid, 'channelId': channelId},
        );

        // Create call entity
        final call = CallEntity(
          callId: callId,
          channelId: channelId,
          localUserId: uid.toString(),
          remoteUserId: remoteUserId,
          callType: callType,
          status: CallStatus.connecting,
          startTime: DateTime.now(),
          isLocalAudioMuted: false,
          isLocalVideoMuted: false,
          cameraFacing: CameraFacing.front,
        );

        // Store current call
        _currentCall = call;
        _callStateController.add(call);

        return Right(call);
      });
    } catch (e) {
      return Left(Failure.channelJoin(message: 'Failed to join call: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> endCall(String callId) async {
    try {
      CallLogger.logCallEvent(callId: callId, event: 'Ending call');

      if (_currentCall == null || _currentCall!.callId != callId) {
        final failure = const Failure.unknown(message: 'No active call found with the specified ID');
        CallLogger.logFailure(failure, context: 'endCall');
        return Left(failure);
      }

      // Update call status to disconnecting
      _currentCall = _currentCall!.copyWith(status: CallStatus.disconnecting, endTime: DateTime.now());
      _callStateController.add(_currentCall!);

      // Calculate call duration in seconds
      final duration = _currentCall!.endTime?.difference(_currentCall!.startTime).inSeconds;

      // Send call ended notification through WebSocket signaling BEFORE leaving channel
      // This ensures the remote participant is notified before we cleanup
      // Note: If WebSocket is disconnected, this will fail gracefully
      // The Agora connection will still be properly cleaned up
      final sendResult = _signalingService.sendCallEnded(callId: callId, durationSeconds: duration);

      // Log WebSocket send result but don't fail the entire operation if it fails
      // This ensures Agora cleanup happens even if WebSocket is disconnected
      sendResult.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'endCall - WebSocket send');
          CallLogger.logInfo('Continuing with Agora cleanup despite WebSocket send failure');
          // Continue with cleanup even if WebSocket send fails
        },
        (_) {
          CallLogger.logCallEvent(
            callId: callId,
            event: 'Sent call.end WebSocket message',
            details: {'durationSeconds': duration},
          );
        },
      );

      // Leave the Agora channel and cleanup resources
      await _agoraService.leaveChannel();

      CallLogger.logCallEvent(callId: callId, event: 'Left Agora channel');

      // Update call status to ended
      _currentCall = _currentCall!.copyWith(status: CallStatus.ended);
      _callStateController.add(_currentCall!);

      // Save call to history
      final historyEntity = CallHistoryEntity(
        id: _currentCall!.callId,
        remoteUserId: _currentCall!.remoteUserId,
        remoteUserName: 'Unknown', // Will be updated by presentation layer
        callType: _currentCall!.callType,
        status: CallStatus.ended,
        timestamp: _currentCall!.startTime,
        durationSeconds: duration,
      );

      await _localDataSource.saveCallHistory(historyEntity);

      CallLogger.logCallEvent(callId: callId, event: 'Call ended successfully', details: {'duration': '${duration}s'});

      // Clear current call and token
      _currentCall = null;
      _currentToken = null;

      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Failed to end call: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'endCall', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> toggleAudioMute() async {
    try {
      if (_currentCall == null) {
        final failure = const Failure.unknown(message: 'No active call to toggle audio');
        CallLogger.logFailure(failure, context: 'toggleAudioMute');
        return Left(failure);
      }

      // Toggle the mute state
      final newMuteState = !_currentCall!.isLocalAudioMuted;

      // Apply to Agora service
      await _agoraService.muteLocalAudioStream(newMuteState);

      // Update call state
      _currentCall = _currentCall!.copyWith(isLocalAudioMuted: newMuteState);
      _callStateController.add(_currentCall!);

      CallLogger.logMediaControl(callId: _currentCall!.callId, control: 'Audio', enabled: !newMuteState);

      return Right(newMuteState);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Failed to toggle audio mute: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'toggleAudioMute', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> toggleVideo() async {
    try {
      if (_currentCall == null) {
        final failure = const Failure.unknown(message: 'No active call to toggle video');
        CallLogger.logFailure(failure, context: 'toggleVideo');
        return Left(failure);
      }

      // Toggle the video state
      final newVideoState = !_currentCall!.isLocalVideoMuted;

      // Apply to Agora service
      await _agoraService.muteLocalVideoStream(newVideoState);

      // Update call state
      _currentCall = _currentCall!.copyWith(isLocalVideoMuted: newVideoState);
      _callStateController.add(_currentCall!);

      CallLogger.logMediaControl(callId: _currentCall!.callId, control: 'Video', enabled: !newVideoState);

      return Right(newVideoState);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Failed to toggle video: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'toggleVideo', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CameraFacing>> switchCamera() async {
    try {
      if (_currentCall == null) {
        final failure = const Failure.unknown(message: 'No active call to switch camera');
        CallLogger.logFailure(failure, context: 'switchCamera');
        return Left(failure);
      }

      if (_currentCall!.callType != CallType.video) {
        final failure = const Failure.unknown(message: 'Cannot switch camera in audio-only call');
        CallLogger.logFailure(failure, context: 'switchCamera');
        return Left(failure);
      }

      // Switch camera in Agora service
      await _agoraService.switchCamera();

      // Toggle camera facing
      final newFacing = _currentCall!.cameraFacing == CameraFacing.front ? CameraFacing.rear : CameraFacing.front;

      // Update call state
      _currentCall = _currentCall!.copyWith(cameraFacing: newFacing);
      _callStateController.add(_currentCall!);

      CallLogger.logCallEvent(
        callId: _currentCall!.callId,
        event: 'Camera switched',
        details: {'facing': newFacing.name},
      );

      return Right(newFacing);
    } catch (e, stackTrace) {
      final failure = Failure.unknown(message: 'Failed to switch camera: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'switchCamera', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  @override
  Stream<CallEntity> watchCallState(String callId) {
    return _callStateController.stream;
  }

  @override
  Stream<NetworkQuality> watchNetworkQuality() {
    return _networkQualityController.stream;
  }

  @override
  Future<Either<Failure, void>> saveCallHistory(CallEntity call) async {
    try {
      // Convert CallEntity to CallHistoryEntity
      final historyEntity = CallHistoryEntity(
        id: call.callId,
        remoteUserId: call.remoteUserId,
        remoteUserName: 'Unknown', // Will be updated by presentation layer
        callType: call.callType,
        status: call.status,
        timestamp: call.startTime,
        durationSeconds: call.endTime?.difference(call.startTime).inSeconds,
      );

      await _localDataSource.saveCallHistory(historyEntity);

      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: 'Failed to save call history: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CallHistoryEntity>>> getCallHistory() async {
    try {
      final history = await _localDataSource.getCallHistory();

      // Sort in reverse chronological order (newest first)
      history.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return Right(history);
    } catch (e) {
      return Left(Failure.unknown(message: 'Failed to get call history: ${e.toString()}'));
    }
  }
}
