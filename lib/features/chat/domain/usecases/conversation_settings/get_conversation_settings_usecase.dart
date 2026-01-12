import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/conversation_settings.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for getting conversation settings
class GetConversationSettingsUseCase {
  final ConversationSettingsRepository _repository;

  GetConversationSettingsUseCase(this._repository);

  Future<Either<Failure, ConversationSettings>> call({required int conversationId}) async {
    return await _repository.getSettings(conversationId: conversationId);
  }
}
