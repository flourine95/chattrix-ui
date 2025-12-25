import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/conversation_settings.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for muting a conversation
class MuteConversationUseCase {
  final ConversationSettingsRepository _repository;

  MuteConversationUseCase(this._repository);

  Future<Either<Failure, ConversationSettings>> call({required int conversationId}) async {
    return await _repository.muteConversation(conversationId: conversationId);
  }
}
