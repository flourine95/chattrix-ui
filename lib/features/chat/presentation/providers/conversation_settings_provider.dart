import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/data/datasources/conversation_settings_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/conversation_settings_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_settings.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/conversation_settings_repository.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_settings_provider.g.dart';

@riverpod
ConversationSettingsDatasourceImpl conversationSettingsDataSource(Ref ref) {
  final dio = ref.read(dioProvider);
  return ConversationSettingsDatasourceImpl(dio: dio);
}

@riverpod
ConversationSettingsRepository conversationSettingsRepository(Ref ref) {
  final datasource = ref.watch(conversationSettingsDataSourceProvider);
  return ConversationSettingsRepositoryImpl(datasource);
}

@riverpod
class ConversationSettingsNotifier extends _$ConversationSettingsNotifier {
  @override
  Future<ConversationSettings?> build(int conversationId) async {
    final repository = ref.read(conversationSettingsRepositoryProvider);
    final result = await repository.getSettings(conversationId: conversationId);

    return result.fold((failure) => null, (settings) => settings);
  }

  Future<void> togglePin() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = current.pinned
          ? await repository.unpinConversation(conversationId: conversationId)
          : await repository.pinConversation(conversationId: conversationId);

      result.fold((failure) => state = AsyncValue.error(failure, StackTrace.current), (settings) {
        state = AsyncValue.data(settings);
        ref.invalidate(conversationsProvider);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> toggleHide() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = current.hidden
          ? await repository.unhideConversation(conversationId: conversationId)
          : await repository.hideConversation(conversationId: conversationId);

      result.fold((failure) => state = AsyncValue.error(failure, StackTrace.current), (settings) {
        state = AsyncValue.data(settings);
        ref.invalidate(conversationsProvider);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> toggleMute() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = current.muted
          ? await repository.unmuteConversation(conversationId: conversationId)
          : await repository.muteConversation(conversationId: conversationId);

      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (settings) => state = AsyncValue.data(settings),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleBlock() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = current.blocked
          ? await repository.unblockUser(conversationId: conversationId)
          : await repository.blockUser(conversationId: conversationId);

      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (settings) => state = AsyncValue.data(settings),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateNickname(String nickname) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = await repository.updateSettings(conversationId: conversationId, customNickname: nickname);

      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (settings) => state = AsyncValue.data(settings),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Additional methods for group management
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
      await dio.put(ApiConstants.conversationById(conversationId), data: {'description': description});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGroupName(String name) async {
    try {
      final dio = ref.read(dioProvider);
      await dio.put(ApiConstants.conversationById(conversationId), data: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteGroupAvatar() async {
    try {
      final dio = ref.read(dioProvider);
      await dio.delete(ApiConstants.conversationAvatar(conversationId));
    } catch (e) {
      rethrow;
    }
  }
}
