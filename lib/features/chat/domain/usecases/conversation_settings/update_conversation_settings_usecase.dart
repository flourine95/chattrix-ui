import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/conversation_settings.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for updating conversation settings
class UpdateConversationSettingsUseCase {
  final ConversationSettingsRepository _repository;

  UpdateConversationSettingsUseCase(this._repository);

  Future<Either<Failure, ConversationSettings>> call({
    required int conversationId,
    bool? notificationsEnabled,
    String? customNickname,
    String? theme,
  }) async {
    return await _repository.updateSettings(
      conversationId: conversationId,
      notificationsEnabled: notificationsEnabled,
      customNickname: customNickname,
      theme: theme,
    );
  }
}
