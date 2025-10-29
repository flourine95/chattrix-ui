import 'dart:async';

import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewChatPage extends HookConsumerWidget {
  const NewChatPage({super.key});

  Color _avatarColor(BuildContext context, int seed) {
    final palette = <Color>[
      const Color(0xFFEF5350), // red
      const Color(0xFFAB47BC), // purple
      const Color(0xFF5C6BC0), // indigo
      const Color(0xFF29B6F6), // blue
      const Color(0xFF26A69A), // teal
      const Color(0xFF66BB6A), // green
      const Color(0xFFFFCA28), // amber
      const Color(0xFFFF7043), // deep orange
      const Color(0xFF8D6E63), // brown
      const Color(0xFF78909C), // blue grey
    ];

    final index = seed % palette.length;
    return palette[index];
  }

  Future<void> _handleUserTap(
    BuildContext context,
    WidgetRef ref,
    SearchUser user,
  ) async {
    // If already has conversation, navigate to it
    if (user.hasConversation && user.conversationId != null) {
      final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
      context.pop();
      context.push(
        '/chat/${user.conversationId}',
        extra: {'name': userName, 'color': _avatarColor(context, user.id)},
      );
      return;
    }

    // Otherwise, create new conversation
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final createUsecase = ref.read(createConversationUsecaseProvider);
    final result = await createUsecase(
      type: 'DIRECT',
      participantIds: [currentUser.id.toString(), user.id.toString()],
    );

    // Close loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    result.fold(
      (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      (conversation) {
        // Refresh conversations list
        ref.invalidate(conversationsProvider);

        // Navigate to chat view
        if (context.mounted) {
          final userName = user.fullName.isNotEmpty
              ? user.fullName
              : user.username;

          // Pop current page and navigate to chat
          context.pop();
          context.push(
            '/chat/${conversation.id}',
            extra: {'name': userName, 'color': _avatarColor(context, user.id)},
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final searchResults = useState<List<SearchUser>>([]);
    final isSearching = useState(false);
    final searchError = useState<String?>(null);

    // Debounce timer
    useEffect(() {
      Timer? debounceTimer;

      void performSearch() async {
        final query = searchController.text.trim();

        if (query.isEmpty) {
          searchQuery.value = '';
          searchResults.value = [];
          isSearching.value = false;
          searchError.value = null;
          return;
        }

        searchQuery.value = query;
        isSearching.value = true;
        searchError.value = null;

        final searchUsecase = ref.read(searchUsersUsecaseProvider);
        final result = await searchUsecase(query: query, limit: 50);

        result.fold(
          (failure) {
            isSearching.value = false;
            searchError.value = failure.message;
          },
          (users) {
            isSearching.value = false;
            searchResults.value = users;
          },
        );
      }

      void onSearchChanged() {
        debounceTimer?.cancel();
        debounceTimer = Timer(const Duration(milliseconds: 500), performSearch);
      }

      searchController.addListener(onSearchChanged);

      return () {
        debounceTimer?.cancel();
        searchController.removeListener(onSearchChanged);
      };
    }, [searchController]);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat', style: textTheme.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              autofocus: true,
            ),
          ),

          // Results
          Expanded(
            child: _buildSearchResults(
              context,
              ref,
              textTheme,
              searchQuery.value,
              searchResults.value,
              isSearching.value,
              searchError.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    WidgetRef ref,
    TextTheme textTheme,
    String query,
    List<SearchUser> results,
    bool isSearching,
    String? error,
  ) {
    // Loading state
    if (isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    debugPrint('🔍 Search error: ${error}');
    // Error state
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Search failed',
              style: textTheme.titleMedium?.copyWith(color: Colors.red[700]),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Empty query state
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Search for users',
              style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter a name, username, or email',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    // No results state
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No users found',
              style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    // Results list
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final user = results[index];
        return _buildUserTile(context, ref, textTheme, user);
      },
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    WidgetRef ref,
    TextTheme textTheme,
    SearchUser user,
  ) {
    final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
    final avatarColor = _avatarColor(context, user.id);
    final initial = userName.isNotEmpty ? userName.substring(0, 1) : '?';

    return ListTile(
      onTap: () => _handleUserTap(context, ref, user),
      leading: CircleAvatar(
        backgroundColor: avatarColor,
        child: Text(
          initial,
          style: textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
      title: Row(
        children: [
          Expanded(child: Text(userName, style: textTheme.titleMedium)),
          if (user.contact)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Contact',
                style: textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@${user.username}',
            style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          if (user.hasConversation)
            Text(
              'Already chatting',
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
