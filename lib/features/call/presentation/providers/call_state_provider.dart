import 'package:chattrix_ui/core/errors/failures.dart';
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
    );
  }
}

/// Main call state notifier using AsyncNotifier
/// Manages call state with automatic loading/error handling
@Riverpod(keepAlive: true)
class Call extends _$Call {
  @override
  Future<CallEntity?> build() async {
    // Initially no active call
    return null;
  }

  /// Initiate a call to another user
  Future<void> initiateCall({
    required String remoteUserId,
    required CallType callType,
    String? callerId,
    String? callerName,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // Generate unique IDs for the call
      final callId = _generateCallId();
      final channelId = _generateChannelId();

      // Create the call
      final result = await repository.createCall(
        callId: callId,
        channelId: channelId,
        remoteUserId: remoteUserId,
        callType: callType,
        callerId: callerId,
        callerName: callerName,
      );

      // Handle result
      return result.fold((failure) => throw _mapFailureToException(failure), (call) => call);
    });
  }

  /// Accept an incoming call
  Future<void> acceptCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // Join the call
      final result = await repository.joinCall(
        callId: callId,
        channelId: channelId,
        remoteUserId: remoteUserId,
        callType: callType,
      );

      // Handle result
      return result.fold((failure) => throw _mapFailureToException(failure), (call) => call);
    });
  }

  /// Reject an incoming call
  Future<void> rejectCall(String callId) async {
    // For now, rejecting a call is similar to ending it
    // In the future, we might want to send a specific rejection message
    await endCall(callId);
  }

  /// End the current call
  Future<void> endCall(String callId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(callRepositoryProvider);

      // End the call
      final result = await repository.endCall(callId);

      // Handle result
      result.fold((failure) => throw _mapFailureToException(failure), (_) => null);

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
      return;
    }

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.toggleAudioMute();

    result.fold(
      (failure) {
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newMuteState) {
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
      return;
    }

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.toggleVideo();

    result.fold(
      (failure) {
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newVideoState) {
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
      return;
    }

    final repository = ref.read(callRepositoryProvider);

    final result = await repository.switchCamera();

    result.fold(
      (failure) {
        // Handle error but don't change the overall state
        // Could show a toast or error message
      },
      (newCameraFacing) {
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
