import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/search_conversations_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/conversation_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Search conversations screen
///
/// Allows users to search for conversations by name or last message content
class SearchConversationsPage extends HookConsumerWidget {
  const SearchConversationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final asyncState = ref.watch(searchConversationsProvider);
    final currentUser = ref.watch(currentUserProvider);
    final colors = Theme.of(context).colorScheme;

    // Auto-focus search field on mount
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocusNode.requestFocus();
      });
      return null;
    }, []);

    // Debounced search
    useEffect(() {
      void onSearchChanged() {
        final query = searchController.text.trim();
        if (query.isEmpty) {
          ref.read(searchConversationsProvider.notifier).clear();
        } else {
          ref.read(searchConversationsProvider.notifier).search(query);
        }
      }

      searchController.addListener(onSearchChanged);
      return () => searchController.removeListener(onSearchChanged);
    }, [searchController]);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: TextField(
          controller: searchController,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm tin nhắn...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
          ),
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                ref.read(searchConversationsProvider.notifier).clear();
              },
            ),
        ],
      ),
      body: _buildBody(context, ref, asyncState, currentUser),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, AsyncValue<List<dynamic>> asyncState, dynamic currentUser) {
    return switch (asyncState) {
      AsyncData(:final value) => _buildResults(context, ref, value, currentUser),
      AsyncError(:final error) => _buildError(context, error),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildResults(BuildContext context, WidgetRef ref, List<dynamic> conversations, dynamic currentUser) {
    if (conversations.isEmpty) {
      return _buildEmptyState(context, 'Không tìm thấy tin nhắn nào');
    }

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ConversationListItem(
          conversation: conversation,
          currentUser: currentUser,
          onTap: () {
            context.push('/chat/${conversation.id}', extra: {'name': conversation.name});
          },
        );
      },
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Đã xảy ra lỗi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colors.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: TextStyle(fontSize: 14, color: colors.onSurface.withValues(alpha: 0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: colors.onSurface.withValues(alpha: 0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
