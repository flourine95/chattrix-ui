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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);

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
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: searchController,
            focusNode: searchFocusNode,
            decoration: InputDecoration(
              hintText: 'Search messages',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            style: const TextStyle(fontSize: 15),
          ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          ),
        ),
      ),
      body: _buildBody(context, ref, asyncState, currentUser, isDark),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<dynamic>> asyncState,
    dynamic currentUser,
    bool isDark,
  ) {
    return switch (asyncState) {
      AsyncData(:final value) => _buildResults(context, ref, value, currentUser, isDark),
      AsyncError(:final error) => _buildError(context, error),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildResults(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> conversations,
    dynamic currentUser,
    bool isDark,
  ) {
    if (conversations.isEmpty) {
      return _buildEmptyState(context, 'No messages found');
    }

    return ListView.separated(
      itemCount: conversations.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 0.5,
        color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
        indent: 76,
      ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'An error occurred',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
