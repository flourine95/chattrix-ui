import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/conversation_settings_datasource.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/conversation_settings.dart';
import '../../domain/repositories/conversation_settings_repository.dart';
import '../models/conversation_settings_model.dart';
import '../mappers/conversation_settings_mapper.dart';

class ConversationSettingsRepositoryImpl extends BaseRepository implements ConversationSettingsRepository {
  final ConversationSettingsDatasource _datasource;

  ConversationSettingsRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, ConversationSettings>> getSettings({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.getSettings(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> updateSettings({
    required int conversationId,
    bool? notificationsEnabled,
    String? customNickname,
    String? theme,
  }) async {
    return executeApiCall(() async {
      final request = UpdateConversationSettingsRequest(
        notificationsEnabled: notificationsEnabled,
        customNickname: customNickname,
        theme: theme,
      );
      final model = await _datasource.updateSettings(conversationId: conversationId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> muteConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.muteConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> unmuteConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unmuteConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> pinConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.pinConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> unpinConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unpinConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> hideConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.hideConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> unhideConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unhideConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> archiveConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.archiveConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> unarchiveConversation({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unarchiveConversation(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> blockUser({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.blockUser(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationSettings>> unblockUser({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unblockUser(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, MutedMember>> muteMember({
    required int conversationId,
    required int userId,
    required int duration,
  }) async {
    return executeApiCall(() async {
      final request = MuteMemberRequest(duration: duration);
      final model = await _datasource.muteMember(conversationId: conversationId, userId: userId, request: request);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, MutedMember>> unmuteMember({required int conversationId, required int userId}) async {
    return executeApiCall(() async {
      final model = await _datasource.unmuteMember(conversationId: conversationId, userId: userId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationPermissions>> getPermissions({required int conversationId}) async {
    return executeApiCall(() async {
      final model = await _datasource.getPermissions(conversationId: conversationId);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, ConversationPermissions>> updatePermissions({
    required int conversationId,
    String? sendMessages,
    String? addMembers,
    String? removeMembers,
    String? editGroupInfo,
    String? pinMessages,
    String? deleteMessages,
    String? createPolls,
  }) async {
    return executeApiCall(() async {
      final request = UpdateConversationPermissionsRequest(
        sendMessages: sendMessages,
        addMembers: addMembers,
        removeMembers: removeMembers,
        editGroupInfo: editGroupInfo,
        pinMessages: pinMessages,
        deleteMessages: deleteMessages,
        createPolls: createPolls,
      );
      final model = await _datasource.updatePermissions(conversationId: conversationId, request: request);
      return model.toEntity();
    });
  }
}
