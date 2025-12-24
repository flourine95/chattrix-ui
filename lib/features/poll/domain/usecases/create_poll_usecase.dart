import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/poll_entity.dart';
import '../entities/create_poll_params.dart';
import '../repositories/poll_repository.dart';

/// Use case for creating a poll
///
/// Single Responsibility: Create a poll in a conversation
class CreatePollUseCase {
  final PollRepository _repository;

  CreatePollUseCase(this._repository);

  /// Execute the use case
  ///
  /// Parameters:
  /// - [params]: Poll creation parameters
  ///
  /// Returns:
  /// - Right(PollEntity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, PollEntity>> call({required CreatePollParams params}) async {
    // Validate parameters
    final validationError = params.validate();
    if (validationError != null) {
      return left(const Failure.validation(message: 'Invalid poll parameters', code: 'INVALID_POLL_PARAMS'));
    }

    // Call repository
    return await _repository.createPoll(params: params);
  }
}
