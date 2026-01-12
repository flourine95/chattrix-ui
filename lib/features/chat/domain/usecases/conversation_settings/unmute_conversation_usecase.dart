import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for unmuting a conversation
class UnmuteConversationUseCase {
  final ConversationSettingsRepository _repository;

  UnmuteConversationUseCase(this._repository);

  Future<Either<Failure, void>> call({required int conversationId}) async {
    return await _repository.unmuteConversation(conversationId: conversationId);
  }
}
