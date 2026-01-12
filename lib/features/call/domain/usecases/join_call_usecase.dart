import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for joining an ongoing call
class JoinCallUseCase {
  final CallRepository _repository;

  JoinCallUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [callId]: The call ID to join
  ///
  /// **Returns:**
  /// - Right(CallConnection): Success with Agora token
  /// - Left(Failure): Error occurred
  Future<Either<Failure, CallConnection>> call({required String callId}) async {
    return await _repository.joinCall(callId: callId);
  }
}
