import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/poll_entity.dart';
import '../entities/create_poll_params.dart';

/// Poll repository interface - defines contract
///
/// Implementation: Data Layer
abstract class PollRepository {
  /// Create a new poll in a conversation
  ///
  /// Returns [Right] with [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PollEntity>> createPoll({required CreatePollParams params});

  /// Vote on a poll
  ///
  /// Returns [Right] with updated [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PollEntity>> votePoll({required int pollId, required List<int> optionIds});

  /// Remove vote from a poll
  ///
  /// Returns [Right] with updated [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PollEntity>> removeVote({required int pollId});

  /// Get poll by ID
  ///
  /// Returns [Right] with [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PollEntity>> getPollById({required int pollId});

  /// Get all polls in a conversation
  ///
  /// Returns [Right] with List of [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<PollEntity>>> getConversationPolls({
    required int conversationId,
    int page = 0,
    int size = 20,
  });

  /// Close a poll (creator only)
  ///
  /// Returns [Right] with updated [PollEntity] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, PollEntity>> closePoll({required int pollId});

  /// Delete a poll (creator only)
  ///
  /// Returns [Right] with success message on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, String>> deletePoll({required int pollId});
}
