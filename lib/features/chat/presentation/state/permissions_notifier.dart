import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/conversation_settings.dart';
import '../providers/chat_websocket_provider_new.dart';
import '../providers/conversation_settings_providers.dart';

part 'permissions_notifier.g.dart';

@riverpod
class PermissionsNotifier extends _$PermissionsNotifier {
  StreamSubscription<Map<String, dynamic>>? _permissionsSubscription;

  @override
  Future<ConversationPermissions?> build(int conversationId) async {
    // Listen to WebSocket permissions updates
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);
    _permissionsSubscription = wsDataSource.conversationPermissionsUpdatedStream.listen((data) {
      final eventConversationId = data['conversationId'] as int?;
      if (eventConversationId == conversationId) {
        final permissions = data['permissions'] as Map<String, dynamic>?;
        if (permissions != null) {
          updateFromWebSocket(permissions);
        }
      }
    });

    ref.onDispose(() {
      _permissionsSubscription?.cancel();
    });

    return _loadPermissions();
  }

  Future<ConversationPermissions?> _loadPermissions() async {
    final useCase = ref.read(getPermissionsUseCaseProvider);
    final result = await useCase(conversationId: conversationId);

    return result.fold(
      (failure) {
        // Log error but don't throw - return null to indicate no permissions loaded
        print('❌ [Permissions] Failed to load: ${failure.message}');
        return null;
      },
      (permissions) => permissions,
    );
  }

  /// Refresh permissions from server
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPermissions());
  }

  /// Update permissions (admin only)
  Future<bool> updatePermissions({
    String? sendMessages,
    String? addMembers,
    String? editGroupInfo,
    String? pinMessages,
    String? deleteMessages,
    String? createPolls,
  }) async {
    final useCase = ref.read(updatePermissionsUseCaseProvider);

    final result = await useCase(
      conversationId: conversationId,
      sendMessages: sendMessages,
      addMembers: addMembers,
      editGroupInfo: editGroupInfo,
      pinMessages: pinMessages,
      deleteMessages: deleteMessages,
      createPolls: createPolls,
    );

    return result.fold(
      (failure) {
        print('❌ [Permissions] Update failed: ${failure.message}');
        return false;
      },
      (updatedPermissions) {
        // Update state with new permissions
        state = AsyncValue.data(updatedPermissions);
        print('✅ [Permissions] Updated successfully');
        return true;
      },
    );
  }

  /// Update permissions from WebSocket event
  void updateFromWebSocket(Map<String, dynamic> permissionsData) {
    final currentState = state.value;
    if (currentState == null) return;

    final updated = currentState.copyWith(
      sendMessages: permissionsData['sendMessages'] ?? currentState.sendMessages,
      addMembers: permissionsData['addMembers'] ?? currentState.addMembers,
      editGroupInfo: permissionsData['editGroupInfo'] ?? currentState.editGroupInfo,
      pinMessages: permissionsData['pinMessages'] ?? currentState.pinMessages,
      deleteMessages: permissionsData['deleteMessages'] ?? currentState.deleteMessages,
      createPolls: permissionsData['createPolls'] ?? currentState.createPolls,
    );

    state = AsyncValue.data(updated);
    print('🔧 [Permissions] Updated from WebSocket');
  }
}
