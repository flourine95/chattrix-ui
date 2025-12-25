import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/poll.dart';
import '../../repositories/poll_repository.dart';

/// Use case for creating a poll
class CreatePollUseCase {
  final PollRepository _repository;

  CreatePollUseCase(this._repository);

  Future<Either<Failure, Poll>> call({
    required int conversationId,
    required String question,
    required List<String> options,
    bool? allowMultipleAnswers,
    bool? isAnonymous,
    DateTime? expiresAt,
  }) async {
    // Validation
    if (question.trim().isEmpty) {
      return left(const Failure.validation(message: 'Poll question cannot be empty', code: 'INVALID_QUESTION'));
    }

    if (options.length < 2) {
      return left(const Failure.validation(message: 'Poll must have at least 2 options', code: 'INSUFFICIENT_OPTIONS'));
    }

    if (options.any((opt) => opt.trim().isEmpty)) {
      return left(const Failure.validation(message: 'Poll options cannot be empty', code: 'INVALID_OPTION'));
    }

    return await _repository.createPoll(
      conversationId: conversationId,
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleAnswers ?? false,
      expiresAt: expiresAt,
    );
  }
}
