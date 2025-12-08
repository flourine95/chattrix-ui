import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:dartz/dartz.dart';

class InitiateCallUseCase {
  final CallRepository repository;

  InitiateCallUseCase(this.repository);

  Future<Either<Failure, CallConnection>> call({required int calleeId, required CallType callType}) {
    return repository.initiateCall(calleeId: calleeId, callType: callType);
  }
}
