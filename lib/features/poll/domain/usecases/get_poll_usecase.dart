import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/poll_entity.dart';
import '../repositories/poll_repository.dart';

/// Use case for getting poll details
///
/// Single Responsibility: Retrieve a poll by ID
class GetPollUseCase {
  final PollRepository _repository;

  GetPollUseCase(this._repository);

  /// Execute the use case
  ///
  /// Parameters:
  /// - [pollId]: ID of the poll to retrieve
  ///
  /// Returns:
  /// - Right(PollEntity): Success
  /// - Left(Failure): Error occurred
  Future<Either<Failure, PollEntity>> call({required int pollId}) async {
    return await _repository.getPollById(pollId: pollId);
  }
}
