import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_messages_provider.g.dart';

@riverpod
class SearchMessages extends _$SearchMessages {
  @override
  Future<List<Message>> build(int conversationId, String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final useCase = ref.read(searchMessagesUsecaseProvider);
    final result = await useCase(conversationId: conversationId, query: query);

    return result.fold((failure) => throw Exception(failure.message), (messages) => messages);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
