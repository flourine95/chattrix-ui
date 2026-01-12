import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:fpdart/fpdart.dart';

class CallRepositoryImpl extends BaseRepository implements CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CallConnection>> initiateCall({required int calleeId, required CallType callType}) async {
    return executeApiCall(() async {
      final result = await remoteDataSource.initiateCall(calleeId: calleeId, callType: callType);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, CallConnection>> acceptCall({required String callId}) async {
    return executeApiCall(() async {
      final result = await remoteDataSource.acceptCall(callId: callId);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, CallInfo>> rejectCall({required String callId, required CallRejectReason reason}) async {
    return executeApiCall(() async {
      final result = await remoteDataSource.rejectCall(callId: callId, reason: reason);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, CallInfo>> endCall({required String callId, required CallEndReason reason}) async {
    return executeApiCall(() async {
      final result = await remoteDataSource.endCall(callId: callId, reason: reason);
      return result.toEntity();
    });
  }
}
