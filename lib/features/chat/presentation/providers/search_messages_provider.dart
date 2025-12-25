import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_messages_provider.g.dart';

/// Provider for searching messages in a conversation
///
/// **State**: AsyncValue<List<Message>>
@riverpod
class SearchMessages extends _$SearchMessages {
  @override
  Future<List<Message>> build(String conversationId, String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final useCase = ref.read(searchMessagesUsecaseProvider);
    final result = await useCase(conversationId: conversationId, query: query);

    return result.fold((failure) => throw Exception(failure.message), (messages) => messages);
  }

  /// Refresh search results
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
