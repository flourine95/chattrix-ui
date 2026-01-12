import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for checking active call in a conversation
class GetActiveCallUseCase {
  final CallRepository _repository;

  GetActiveCallUseCase(this._repository);

  /// Execute the use case
  ///
  /// **Parameters:**
  /// - [conversationId]: The conversation ID to check
  ///
  /// **Returns:**
  /// - Right(CallInfo?): Active call info or null if no active call
  /// - Left(Failure): Error occurred
  Future<Either<Failure, CallInfo?>> call({required int conversationId}) async {
    return await _repository.getActiveCall(conversationId: conversationId);
  }
}
