import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/poll/domain/entities/create_poll_params.dart';
import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:chattrix_ui/features/poll/domain/repositories/poll_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreatePollUseCase {
  final PollRepository _repository;

  CreatePollUseCase(this._repository);

  Future<Either<Failure, PollEntity>> call({required CreatePollParams params}) async {
    final validationError = params.validate();
    if (validationError != null) {
      return left(const Failure.validation(message: 'Invalid poll parameters', code: 'INVALID_POLL_PARAMS'));
    }

    return await _repository.createPoll(params: params);
  }
}
