import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../data/datasources/conversation_settings_datasource.dart';
import '../../data/models/conversation_settings_model.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';
import '../../../../core/constants/api_constants.dart';
import '../state/conversations_notifier.dart';

part 'conversation_settings_provider.g.dart';

@riverpod
ConversationSettingsDataSource conversationSettingsDataSource(Ref ref) {
  return ConversationSettingsDataSourceImpl(ref.watch(dioProvider));
}

@riverpod
class ConversationSettings extends _$ConversationSettings {
  @override
  Future<ConversationSettingsModel?> build(int conversationId) async {
    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = await dataSource.getSettings(conversationId);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<void> togglePin() async {
    debugPrint('🔍 [Provider] togglePin START - conversationId: $conversationId');

    // Ensure state is loaded first
    if (state.value == null) {
      debugPrint('🔍 [Provider] togglePin - state is null, fetching settings first...');
      try {
        await future; // Wait for build() to complete
      } catch (e) {
        debugPrint('🔍 [Provider] togglePin - failed to fetch settings: $e');
        throw Exception('Failed to load conversation settings');
      }
    }

    final current = state.value;
    if (current == null) {
      debugPrint('🔍 [Provider] togglePin - state is still null after fetch, aborting');
      return;
    }

    debugPrint('🔍 [Provider] togglePin - current.pinned: ${current.pinned}');
    state = const AsyncValue.loading();

    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      final response = current.pinned
          ? await dataSource.unpinConversation(conversationId)
          : await dataSource.pinConversation(conversationId);
      state = AsyncValue.data(response.data);

      // Invalidate conversations list to refresh with new pin state
      ref.invalidate(conversationsProvider);
      debugPrint('🔍 [Provider] togglePin - completed successfully');
    } catch (e, st) {
      debugPrint('🔍 [Provider] togglePin - error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> toggleHide() async {
    debugPrint('🔍 [Provider] toggleHide START - conversationId: $conversationId');

    // Ensure state is loaded first
    if (state.value == null) {
      debugPrint('🔍 [Provider] toggleHide - state is null, fetching settings first...');
      try {
        await future; // Wait for build() to complete
      } catch (e) {
        debugPrint('🔍 [Provider] toggleHide - failed to fetch settings: $e');
        throw Exception('Failed to load conversation settings');
      }
    }

    final current = state.value;
    if (current == null) {
      debugPrint('🔍 [Provider] toggleHide - state is still null after fetch, aborting');
      return;
    }

    debugPrint('🔍 [Provider] toggleHide - current.hidden: ${current.hidden}');
    state = const AsyncValue.loading();

    try {
      final dataSource = ref.read(conversationSettingsDataSourceProvider);
      debugPrint('🔍 [Provider] toggleHide - calling datasource...');

      final response = current.hidden
          ? await dataSource.unhideConversation(conversationId)
          : await dataSource.hideConversation(conversationId);

      debugPrint('🔍 [Provider] toggleHide - response received: ${response.data}');
      state = AsyncValue.data(response.data);

      // Invalidate conversations list to refresh with new hide state
      ref.invalidate(conversationsProvider);
      debugPrint('🔍 [Provider] toggleHide - completed successfully');
    } catch (e, st) {
      debugPrint('🔍 [Provider] toggleHide - error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
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
}
