import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:dartz/dartz.dart';

class CallRepositoryImpl implements CallRepository {
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CallConnection>> initiateCall({
    required int calleeId,
    required CallType callType,
  }) async {
    try {
      final result = await remoteDataSource.initiateCall(
        calleeId: calleeId,
        callType: callType,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CallConnection>> acceptCall({
    required String callId,
  }) async {
    try {
      final result = await remoteDataSource.acceptCall(callId: callId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CallInfo>> rejectCall({
    required String callId,
    required CallRejectReason reason,
  }) async {
    try {
      final result = await remoteDataSource.rejectCall(
        callId: callId,
        reason: reason,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, CallInfo>> endCall({
    required String callId,
    required CallEndReason reason,
  }) async {
    try {
      final result = await remoteDataSource.endCall(
        callId: callId,
        reason: reason,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }
}

