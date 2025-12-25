import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/conversation_settings_datasource.dart';
import '../../data/models/conversation_settings_model.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';
import '../../../../core/constants/api_constants.dart';

part 'conversation_settings_provider.g.dart';

@riverpod
ConversationSettingsDataSource conversationSettingsDataSource(Ref ref) {
  return ConversationSettingsDataSourceImpl(ref.watch(dioProvider));
}

@riverpod
class ConversationSettings extends _$ConversationSettings {
  @override
  Future<ConversationSettingsModel?> build(String conversationId) async {
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = await dataSource.getSettings(conversationId);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<void> togglePin() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = current.pinned
          ? await dataSource.unpinConversation(conversationId)
          : await dataSource.pinConversation(conversationId);
      state = AsyncValue.data(response.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleHide() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = current.hidden
          ? await dataSource.unhideConversation(conversationId)
          : await dataSource.hideConversation(conversationId);
      state = AsyncValue.data(response.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleMute() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = current.muted
          ? await dataSource.unmuteConversation(conversationId)
          : await dataSource.muteConversation(conversationId);
      state = AsyncValue.data(response.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleBlock() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = current.blocked
          ? await dataSource.unblockUser(conversationId)
          : await dataSource.blockUser(conversationId);
      state = AsyncValue.data(response.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateNickname(String nickname) async {
    state = const AsyncValue.loading();
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = await dataSource.updateSettings(
        conversationId,
        UpdateConversationSettingsRequest(customNickname: nickname),
      );
      state = AsyncValue.data(response.data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> leaveGroup() async {
    try {
      final dio = ref.read(dioProvider);
      await dio.post(ApiConstants.leaveConversation(conversationId));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDescription(String description) async {
    try {
      final dio = ref.read(dioProvider);
      await dio.put(
        ApiConstants.conversationById(conversationId),
        data: {'description': description},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGroupName(String name) async {
    try {
      final dio = ref.read(dioProvider);
      await dio.put(
        ApiConstants.conversationById(conversationId),
        data: {'name': name},
      );
    } catch (e) {
      rethrow;
    }
  }
}

