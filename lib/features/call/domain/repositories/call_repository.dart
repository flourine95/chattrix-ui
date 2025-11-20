import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CallRepository {
  /// Initialize Agora RTC Engine
  Future<Either<Failure, void>> initialize();

  /// Create and join a new call channel
  Future<Either<Failure, CallEntity>> createCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
    String? callerId,
    String? callerName,
  });

  /// Join an existing call channel
  Future<Either<Failure, CallEntity>> joinCall({
    required String callId,
    required String channelId,
    required String remoteUserId,
    required CallType callType,
  });

  /// Leave the current call and cleanup resources
  Future<Either<Failure, void>> endCall(String callId);

  /// Toggle local audio mute state
  Future<Either<Failure, bool>> toggleAudioMute();

  /// Toggle local video enable state
  Future<Either<Failure, bool>> toggleVideo();

  /// Switch between front and rear camera
  Future<Either<Failure, CameraFacing>> switchCamera();

  /// Get current call state
  Stream<CallEntity> watchCallState(String callId);

  /// Get network quality updates
  Stream<NetworkQuality> watchNetworkQuality();

  /// Save call to history
  Future<Either<Failure, void>> saveCallHistory(CallEntity call);

  /// Get call history
  Future<Either<Failure, List<CallHistoryEntity>>> getCallHistory();

  /// Dispose resources
  Future<void> dispose();
}
