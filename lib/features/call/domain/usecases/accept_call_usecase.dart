import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:fpdart/fpdart.dart';

class AcceptCallUseCase {
  final CallRepository repository;

  AcceptCallUseCase(this.repository);

  Future<Either<Failure, CallConnection>> call({required String callId}) {
    return repository.acceptCall(callId: callId);
  }
}
