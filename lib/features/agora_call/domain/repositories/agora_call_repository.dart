import 'package:dartz/dartz.dart';
import '../entities/call_entity.dart';
import '../entities/call_connection_entity.dart';
import '../failures/call_failure.dart';

/// Repository interface for call operations
abstract class AgoraCallRepository {
  /// Initiates a call to another user
  Future<Either<CallFailure, CallConnectionEntity>> initiateCall({required int calleeId, required CallType callType});

  /// Accepts an incoming call
  Future<Either<CallFailure, CallConnectionEntity>> acceptCall({required String callId});

  /// Rejects an incoming call
  Future<Either<CallFailure, CallEntity>> rejectCall({required String callId, required String reason});

  /// Ends an active call
  Future<Either<CallFailure, CallEntity>> endCall({required String callId, String reason = 'hangup'});
}
