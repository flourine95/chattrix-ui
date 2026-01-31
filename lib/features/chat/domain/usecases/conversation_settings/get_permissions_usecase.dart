import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/conversation_settings.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for getting conversation permissions
class GetPermissionsUseCase {
  final ConversationSettingsRepository _repository;

  GetPermissionsUseCase(this._repository);

  Future<Either<Failure, ConversationPermissions>> call({
    required int conversationId,
  }) async {
    return await _repository.getPermissions(conversationId: conversationId);
  }
}
