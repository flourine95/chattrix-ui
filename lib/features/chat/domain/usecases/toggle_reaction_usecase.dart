import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ToggleReactionUsecase {
  final ChatRepository repository;

  ToggleReactionUsecase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call({required String messageId, required String emoji}) {
    return repository.toggleReaction(messageId: messageId, emoji: emoji);
  }
}
