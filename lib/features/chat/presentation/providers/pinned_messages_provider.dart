import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pinned_messages_provider.g.dart';

/// Provider for pinned messages in a conversation
@riverpod
class PinnedMessages extends _$PinnedMessages {
  @override
  Future<List<Message>> build(String conversationId) async {
    final usecase = ref.read(getPinnedMessagesUsecaseProvider);
    return await usecase(conversationId);
  }

  /// Refresh pinned messages
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(conversationId));
  }
}
