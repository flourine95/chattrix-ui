import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_state_provider.g.dart';

/// Network quality stream provider
/// Watches the repository's network quality stream
@riverpod
Stream<NetworkQuality> networkQuality(Ref ref) {
  final repository = ref.watch(callRepositoryProvider);
  return repository.watchNetworkQuality();
}

/// Call history notifier using AsyncNotifier
/// Manages call history state with fetch and refresh capabilities
@Riverpod(keepAlive: true)
class CallHistory extends _$CallHistory {
  @override
  Future<List<CallHistoryEntity>> build() async {
    // Fetch call history on initialization
    return _fetchHistory();
  }

  /// Fetch call history from repository
  Future<List<CallHistoryEntity>> _fetchHistory() async {
    final repository = ref.read(callRepositoryProvider);
    final result = await repository.getCallHistory();

    return result.fold((failure) => throw _mapFailureToException(failure), (history) => history);
  }

  /// Refresh call history
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return _fetchHistory();
    });
  }

  /// Map Failure to Exception for AsyncValue.guard
  Exception _mapFailureToException(Failure failure) {
    return failure.when(
      server: (message, errorCode) => ServerException(message, errorCode),
      network: (message) => NetworkException(message),
      validation: (message, errors) => ValidationException(message, errors),
      badRequest: (message, errorCode) => BadRequestException(message, errorCode),
      unauthorized: (message, errorCode) => UnauthorizedException(message, errorCode),
      forbidden: (message, errorCode) => ForbiddenException(message, errorCode),
      notFound: (message, errorCode) => NotFoundException(message, errorCode),
      conflict: (message, errorCode) => ConflictException(message, errorCode),
      rateLimitExceeded: (message) => RateLimitException(message),
      unknown: (message) => UnknownException(message),
      permission: (message) => PermissionException(message),
      agoraEngine: (message, code) => AgoraEngineException(message, code),
      tokenExpired: (message) => TokenExpiredException(message),
      channelJoin: (message) => ChannelJoinException(message),
      webSocketNotConnected: (message) => WebSocketNotConnectedException(message),
      webSocketSendFailed: (message) => WebSocketSendFailedException(message),
      callNotFound: (message) => CallNotFoundException(message),
      callAlreadyActive: (message) => CallAlreadyActiveException(message),
    );
  }
}

/// Main call state notifier using AsyncNotifier
/// Manages call state with automatic loading/error handling
@Riverpod(keepAlive: true)
class Call extends _$Call {
  CallSignalingService? _signalingService;

  @override
  Future<CallEntity?> build() async {
    // Inject signaling service
    _signalingService = ref.read(callSignalingServiceProvider);

    // Initially no active call
    return null;
  }

  /// Initiate a call to another user
  /// conversationId is optional - if provided, it will be used as the channel ID
  /// This ensures both users join the same Agora channel
  /// Returns the call ID if successful
  Future<String?> initiateCall({
    required String remoteUserId,
    required CallType callType,
    String? callerId,
    String? callerName,
    String? conversationId, // Use conversation ID as channel ID
  }) async {
    // Validate WebSocket connection before initiating call
    if (_signalingService == null || !_signalingService!.isConnected) {
      final error = WebSocketNotConnectedException('Cannot initiate call: WebSocket not connected');
      CallLogger.logError('WebSocket not connected when initiating call', error: error);
      state = AsyncValue.error(error, StackTrace.current);
      return null;
    }

    state = const AsyncValue.loading();

    String? callId;

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // Generate unique call ID
      callId = _generateCallId();

      // Use conversation ID as channel ID if provided, otherwise generate one
      // This ensures both users in a conversation join the same Agora channel
      final channelId = conversationId != null ? 'channel_conv_$conversationId' : _generateChannelId();

      // Log call initiation
      CallLogger.logInfo(
        'Initiating call: callId=$callId, channelId=$channelId, calleeId=$remoteUserId, callType=${callType.name}',
      );

      // Create the call via REST API (backend generates and stores channel ID)
      final result = await repository.createCall(
        callId: callId!,
        channelId: channelId,
        remoteUserId: remoteUserId,
        callType: callType,
        callerId: callerId,
        callerName: callerName,
      );

      // Handle result
      // Note: Backend automatically sends WebSocket invitation to callee
      // No need to send it manually from client
      return result.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'initiateCall');
          throw _mapFailureToException(failure);
        },
        (call) {
          CallLogger.logInfo('Call initiated successfully: callId=${call.callId}');
          return call;
        },
      );
    });

    return callId;
  }

  /// Accept an incoming call
  /// Returns the CallEntity if successful, null if failed
  Future<CallEntity?> acceptCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) async {
    CallLogger.logInfo(
      'Accepting call: callId=$callId, channelId=$channelId, remoteUserId=$remoteUserId, callType=${callType.name}',
    );

    state = const AsyncValue.loading();

    CallEntity? acceptedCall;

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // 1. Send WebSocket accept message BEFORE joining
      // This notifies the caller that the call was accepted
      final sendResult = _signalingService?.sendCallAccept(callId: callId);

      // Handle WebSocket send result
      if (sendResult != null) {
        sendResult.fold(
          (failure) {
            CallLogger.logFailure(failure, context: 'acceptCall - WebSocket send');
            throw _mapFailureToException(failure);
          },
          (_) {
            CallLogger.logInfo('Sent call.accept WebSocket message: callId=$callId');
          },
        );
      }

      // 2. Request Agora token with invitation's channel ID and join the channel
      final result = await repository.joinCall(
        callId: callId,
        channelId: channelId, // Use channel ID from invitation
        remoteUserId: remoteUserId,
        callType: callType,
      );

      // Handle result
      return result.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'acceptCall');
          throw _mapFailureToException(failure);
        },
        (call) {
          CallLogger.logInfo('Call accepted successfully: callId=$callId');
          acceptedCall = call;
          return call;
        },
      );
    });

    return acceptedCall;
  }

  /// Join call as caller (when receiving call_accepted notification)
  /// This method joins the Agora channel WITHOUT sending call.accept WebSocket message
  /// Returns the CallEntity if successful, null if failed
  Future<CallEntity?> joinCallAsCaller({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) async {
    CallLogger.logInfo(
      'Joining call as caller: callId=$callId, channelId=$channelId, remoteUserId=$remoteUserId, callType=${callType.name}',
    );

    state = const AsyncValue.loading();

    CallEntity? joinedCall;

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // Join the Agora channel directly without sending call.accept WebSocket message
      // The callee already sent call.accept, so the caller just needs to join
      final result = await repository.joinCall(
        callId: callId,
        channelId: channelId,
        remoteUserId: remoteUserId,
        callType: callType,
      );

      // Handle result
      return result.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'joinCallAsCaller');
          throw _mapFailureToException(failure);
        },
        (call) {
          CallLogger.logInfo('Caller joined call successfully: callId=$callId');
          joinedCall = call;
          return call;
        },
      );
    });

    return joinedCall;
  }

  /// Reject an incoming call
  /// This method sends a WebSocket reject message without joining Agora channel
  Future<void> rejectCall(String callId, {String? reason}) async {
    final rejectReason = reason ?? 'declined';
    CallLogger.logInfo('Rejecting call: callId=$callId, reason=$rejectReason');

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Send WebSocket reject message
      final sendResult = _signalingService?.sendCallReject(callId: callId, reason: rejectReason);

      // Handle WebSocket send result
      if (sendResult != null) {
        sendResult.fold(
          (failure) {
            CallLogger.logFailure(failure, context: 'rejectCall');
            throw _mapFailureToException(failure);
          },
          (_) {
            CallLogger.logInfo('Sent call.reject WebSocket message: callId=$callId, reason=$rejectReason');
          },
        );
      }

      // Do NOT call endCall() - we never joined the Agora channel
      // Just clear the call state
      return null;
    });
  }

  /// Cancel an outgoing call (used for race condition handling)
  /// This method clears the call state without sending any messages
  void cancelOutgoingCall() {
    CallLogger.logInfo('Cancelling outgoing call due to race condition');
    // Simply reset the state to null
    // This will stop any ongoing call initiation process
    state = const AsyncValue.data(null);
  }

  /// End the current call
  Future<void> endCall(String callId) async {
    CallLogger.logInfo('Ending call: callId=$callId');

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // End the call
      final result = await repository.endCall(callId);

      // Handle result
      result.fold(
        (failure) {
          CallLogger.logFailure(failure, context: 'endCall');
          throw _mapFailureToException(failure);
        },
        (_) {
          CallLogger.logInfo('Call ended successfully: callId=$callId');
          return null;
        },
      );

      // Return null to indicate no active call
      return null;
    });
  }

  /// Generate a unique call ID
  String _generateCallId() {
    return 'call_${DateTime.now().millisecondsSinceEpoch}_${_generateRandomString(6)}';
  }

  /// Generate a unique channel ID
  String _generateChannelId() {
    return 'channel_${DateTime.now().millisecondsSinceEpoch}_${_generateRandomString(6)}';
  }

  /// Generate a random string of specified length
  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(length, (index) => chars[(random + index) % chars.length]).join();
  }

  /// Toggle microphone mute state
  Future<void> toggleMute() async {
    final currentCall = state.value;
    if (currentCall == null) {
      CallLogger.logWarning('Cannot toggle mute: no active call');
      return;
    }

    CallLogger.logInfo('Toggling audio mute: callId=${currentCall.callId}');

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.toggleAudioMute();

    result.fold(
      (failure) {
        CallLogger.logFailure(failure, context: 'toggleMute');
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newMuteState) {
        CallLogger.logInfo('Audio mute toggled: callId=${currentCall.callId}, muted=$newMuteState');
        // Update the call state with new mute status
        final updatedCall = currentCall.copyWith(isLocalAudioMuted: newMuteState);
        state = AsyncValue.data(updatedCall);
      },
    );
  }

  /// Toggle video on/off
  Future<void> toggleVideo() async {
    final currentCall = state.value;
    if (currentCall == null) {
      CallLogger.logWarning('Cannot toggle video: no active call');
      return;
    }

    CallLogger.logInfo('Toggling video: callId=${currentCall.callId}');

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.toggleVideo();

    result.fold(
      (failure) {
        CallLogger.logFailure(failure, context: 'toggleVideo');
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newVideoState) {
        CallLogger.logInfo('Video toggled: callId=${currentCall.callId}, muted=$newVideoState');
        // Update the call state with new video status
        final updatedCall = currentCall.copyWith(isLocalVideoMuted: newVideoState);
        state = AsyncValue.data(updatedCall);
      },
    );
  }

  /// Switch between front and rear camera
  Future<void> switchCamera() async {
    final currentCall = state.value;
    if (currentCall == null) {
      CallLogger.logWarning('Cannot switch camera: no active call');
      return;
    }

    CallLogger.logInfo('Switching camera: callId=${currentCall.callId}');

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.switchCamera();

    result.fold(
      (failure) {
        CallLogger.logFailure(failure, context: 'switchCamera');
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newCameraFacing) {
        CallLogger.logInfo('Camera switched: callId=${currentCall.callId}, facing=${newCameraFacing.name}');
        // Update the call state with new camera facing
        final updatedCall = currentCall.copyWith(cameraFacing: newCameraFacing);
        state = AsyncValue.data(updatedCall);
      },
    );
  }

  /// Map Failure to Exception for AsyncValue.guard
  Exception _mapFailureToException(Failure failure) {
    return failure.when(
      server: (message, errorCode) => ServerException(message, errorCode),
      network: (message) => NetworkException(message),
      validation: (message, errors) => ValidationException(message, errors),
      badRequest: (message, errorCode) => BadRequestException(message, errorCode),
      unauthorized: (message, errorCode) => UnauthorizedException(message, errorCode),
      forbidden: (message, errorCode) => ForbiddenException(message, errorCode),
      notFound: (message, errorCode) => NotFoundException(message, errorCode),
      conflict: (message, errorCode) => ConflictException(message, errorCode),
      rateLimitExceeded: (message) => RateLimitException(message),
      unknown: (message) => UnknownException(message),
      permission: (message) => PermissionException(message),
      agoraEngine: (message, code) => AgoraEngineException(message, code),
      tokenExpired: (message) => TokenExpiredException(message),
      channelJoin: (message) => ChannelJoinException(message),
      webSocketNotConnected: (message) => WebSocketNotConnectedException(message),
      webSocketSendFailed: (message) => WebSocketSendFailedException(message),
      callNotFound: (message) => CallNotFoundException(message),
      callAlreadyActive: (message) => CallAlreadyActiveException(message),
    );
  }
}

/// Custom exceptions matching Failure types
class ServerException implements Exception {
  final String message;
  final String? errorCode;
  ServerException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  final List<ValidationError>? errors;
  ValidationException(this.message, [this.errors]);

  @override
  String toString() {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.map((e) => e.message).join(', ');
    }
    return message;
  }
}

class BadRequestException implements Exception {
  final String message;
  final String? errorCode;
  BadRequestException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  final String? errorCode;
  UnauthorizedException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  final String? errorCode;
  ForbiddenException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  final String? errorCode;
  NotFoundException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class ConflictException implements Exception {
  final String message;
  final String? errorCode;
  ConflictException(this.message, [this.errorCode]);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);

  @override
  String toString() => message;
}

class PermissionException implements Exception {
  final String message;
  PermissionException(this.message);

  @override
  String toString() => message;
}

class AgoraEngineException implements Exception {
  final String message;
  final int? code;
  AgoraEngineException(this.message, [this.code]);

  @override
  String toString() => code != null ? '$message (Code: $code)' : message;
}

class TokenExpiredException implements Exception {
  final String message;
  TokenExpiredException(this.message);

  @override
  String toString() => message;
}

class ChannelJoinException implements Exception {
  final String message;
  ChannelJoinException(this.message);

  @override
  String toString() => message;
}

class WebSocketNotConnectedException implements Exception {
  final String message;
  WebSocketNotConnectedException(this.message);

  @override
  String toString() => message;
}

class WebSocketSendFailedException implements Exception {
  final String message;
  WebSocketSendFailedException(this.message);

  @override
  String toString() => message;
}

class CallNotFoundException implements Exception {
  final String message;
  CallNotFoundException(this.message);

  @override
  String toString() => message;
}

class CallAlreadyActiveException implements Exception {
  final String message;
  CallAlreadyActiveException(this.message);

  @override
  String toString() => message;
}
