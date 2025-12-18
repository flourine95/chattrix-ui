import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/search_conversations_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_conversations_provider.g.dart';

/// Provider for SearchConversationsUseCase
@riverpod
SearchConversationsUseCase searchConversationsUseCase(Ref ref) {
  final dio = ref.watch(dioProvider);
  final datasource = ChatRemoteDatasourceImpl(dio: dio);
  final repository = ChatRepositoryImpl(remoteDatasource: datasource);
  return SearchConversationsUseCase(repository);
}

/// Provider for search conversations state
///
/// **State**: AsyncValue<List<Conversation>>
/// **Lifecycle**: Auto-dispose
@riverpod
class SearchConversations extends _$SearchConversations {
  late final SearchConversationsUseCase _useCase;

  @override
  Future<List<Conversation>> build() async {
    _useCase = ref.read(searchConversationsUseCaseProvider);

    // Initial state - empty list
    return [];
  }

  /// Execute search with query
  Future<void> search(String query) async {
    // Set loading state
    state = const AsyncValue.loading();

    // Execute use case
    final result = await _useCase(query: query);

    // Update state based on result
    state = result.fold(
      (failure) => AsyncValue.error(Exception(failure.message), StackTrace.current),
      (conversations) => AsyncValue.data(conversations),
    );
  }

  /// Clear search results
  void clear() {
    state = const AsyncValue.data([]);
  }
}
