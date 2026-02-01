import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/data/datasources/conversation_settings_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/conversation_settings_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_settings.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/conversation_settings_repository.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';
import 'package:flutter/foundation.dart';
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
    debugPrint('🔧 [togglePin] START - current state: ${current?.pinned}');
    
    if (current == null) {
      debugPrint('🔧 [togglePin] ABORT - current state is null');
      return;
    }

    // Store the current state before toggling
    final previousState = current;
    final newPinnedState = !current.pinned;
    
    debugPrint('🔧 [togglePin] Optimistically updating to: $newPinnedState');
    // Optimistically update UI
    state = AsyncValue.data(current.copyWith(pinned: newPinnedState));

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      debugPrint('🔧 [togglePin] Calling API: ${current.pinned ? 'unpin' : 'pin'}');
      
      final result = current.pinned
          ? await repository.unpinConversation(conversationId: conversationId)
          : await repository.pinConversation(conversationId: conversationId);

      result.fold((failure) {
        debugPrint('🔧 [togglePin] API returned failure: ${failure.message}');
        
        // Check if it's an "already pinned/unpinned" error
        final errorMessage = failure.message.toLowerCase();
        final isAlreadyPinnedError = errorMessage.contains('already pinned') || 
                                      errorMessage.contains('already unpinned') ||
                                      errorMessage.contains('not pinned');
        
        if (isAlreadyPinnedError) {
          // Keep the new state (user's intention was correct, just API state mismatch)
          debugPrint('ℹ️ Conversation pin state mismatch, keeping new state: pinned=$newPinnedState');
        } else {
          // Real error - revert to previous state
          debugPrint('❌ Error toggling pin: ${failure.message}');
          state = AsyncValue.data(previousState);
        }
      }, (settings) {
        debugPrint('🔧 [togglePin] API success, keeping optimistic state');
        // Success - keep the optimistic update
        state = AsyncValue.data(current.copyWith(pinned: newPinnedState));
      });
      
      // Always refresh conversations list to get updated settings from server
      debugPrint('🔧 [togglePin] Refreshing conversationsProvider');
      await ref.refresh(conversationsProvider.future);
      debugPrint('🔧 [togglePin] DONE');
    } catch (e, st) {
      debugPrint('🔧 [togglePin] Exception caught: $e');
      
      // Check if it's an "already pinned/unpinned" error
      final errorMessage = e.toString().toLowerCase();
      final isAlreadyPinnedError = errorMessage.contains('already pinned') || 
                                    errorMessage.contains('already unpinned') ||
                                    errorMessage.contains('not pinned');
      
      if (isAlreadyPinnedError) {
        // Keep the new state (user's intention was correct, just API state mismatch)
        debugPrint('ℹ️ Conversation pin state mismatch, keeping new state: pinned=$newPinnedState');
      } else {
        // Real error - revert to previous state
        debugPrint('❌ Error toggling pin: $e');
        state = AsyncValue.data(previousState);
        rethrow;
      }
      
      // Always refresh conversations list
      debugPrint('🔧 [togglePin] Refreshing conversationsProvider (after exception)');
      await ref.refresh(conversationsProvider.future);
    }
  }

  Future<void> toggleHide() async {
    final current = state.value;
    if (current == null) return;

    // Store the current state before toggling
    final previousState = current;
    final newHiddenState = !current.hidden;
    
    // Optimistically update UI
    state = AsyncValue.data(current.copyWith(hidden: newHiddenState));

    try {
      final repository = ref.read(conversationSettingsRepositoryProvider);
      final result = current.hidden
          ? await repository.unhideConversation(conversationId: conversationId)
          : await repository.hideConversation(conversationId: conversationId);

      result.fold((failure) {
        // Check if it's an UnimplementedError
        final errorMessage = failure.message.toLowerCase();
        if (errorMessage.contains('not available') || errorMessage.contains('unimplemented')) {
          // Feature not implemented - revert and don't rethrow
          debugPrint('ℹ️ Hide conversation feature not yet implemented');
          state = AsyncValue.data(previousState);
        } else {
          // Real error - revert to previous state
          debugPrint('❌ Error toggling hide: ${failure.message}');
          state = AsyncValue.data(previousState);
        }
      }, (settings) {
        // Success - keep the optimistic update
        state = AsyncValue.data(current.copyWith(hidden: newHiddenState));
      });
      
      // Always refresh conversations list
      await ref.refresh(conversationsProvider.future);
    } catch (e, st) {
      // Check if it's an UnimplementedError
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('not available') || errorMessage.contains('unimplemented')) {
        // Feature not implemented - revert and don't rethrow
        debugPrint('ℹ️ Hide conversation feature not yet implemented');
        state = AsyncValue.data(previousState);
      } else {
        // Real error - revert to previous state
        debugPrint('❌ Error toggling hide: $e');
        state = AsyncValue.data(previousState);
        rethrow;
      }
      
      // Always refresh conversations list
      await ref.refresh(conversationsProvider.future);
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
