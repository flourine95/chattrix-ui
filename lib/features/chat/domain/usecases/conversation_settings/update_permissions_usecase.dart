import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/conversation_settings.dart';
import '../../repositories/conversation_settings_repository.dart';

/// Use case for updating conversation permissions
class UpdatePermissionsUseCase {
  final ConversationSettingsRepository _repository;

  UpdatePermissionsUseCase(this._repository);

  Future<Either<Failure, ConversationPermissions>> call({
    required int conversationId,
    String? sendMessages,
    String? addMembers,
    String? removeMembers,
    String? editGroupInfo,
    String? pinMessages,
    String? deleteMessages,
    String? createPolls,
  }) async {
    return await _repository.updatePermissions(
      conversationId: conversationId,
      sendMessages: sendMessages,
      addMembers: addMembers,
      removeMembers: removeMembers,
      editGroupInfo: editGroupInfo,
      pinMessages: pinMessages,
      deleteMessages: deleteMessages,
      createPolls: createPolls,
    );
  }
}
