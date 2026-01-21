import 'dart:async';

import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
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

  Future<void> _handleUserTap(BuildContext context, WidgetRef ref, SearchUser user) async {
    // If already has conversation, navigate to it (duplicate conversation handling)
    if (user.hasConversation && user.conversationId != null) {
      final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
      context.go('/chat/${user.conversationId}', extra: {'name': userName, 'color': _avatarColor(context, user.id)});
      return;
    }

    // Otherwise, create new conversation
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in')));
      }
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final createUsecase = ref.read(createConversationUsecaseProvider);
    final result = await createUsecase(type: 'DIRECT', participantIds: [currentUser.id, user.id]);

    // Close loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    result.fold(
      (failure) {
        // Handle conversation creation failure
        if (context.mounted) {
          // Use the when method to handle different failure types
          final errorMessage = failure.when(
            validation: (message, code, details, requestId) => 'Invalid conversation: $message',
            conflict: (message, code, requestId) => 'Conversation already exists',
            network: (message, code) => 'Network error: $message',
            auth: (message, code, requestId) => 'Authentication error: $message',
            server: (message, code, requestId) => 'Server error: $message',
            notFound: (message, code, requestId) => 'Not found: $message',
            rateLimit: (message, code, requestId) => 'Too many requests: $message',
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red, duration: const Duration(seconds: 3)),
          );
        }
      },
      (conversation) {
        // Handle conversation creation success
        // Optimistically add conversation to list immediately
        ref.read(conversationsProvider.notifier).addConversation(conversation);

        // Navigate to chat view
        if (context.mounted) {
          final userName = user.fullName.isNotEmpty ? user.fullName : user.username;

          // Use go instead of pop + push to avoid navigation conflicts
          context.go('/chat/${conversation.id}', extra: {'name': userName, 'color': _avatarColor(context, user.id)});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final searchQuery = useState('');
    final searchResults = useState<List<SearchUser>>([]);
    final isSearching = useState(false);
    final searchError = useState<String?>(null);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);

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
        title: const Text('New Chat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          ),
        ),
      ),
      body: Column(
        children: [
          // New Group Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push('/new-group'),
                icon: const Icon(Icons.group_add, size: 20),
                label: const Text('New Group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                ),
              ),
            ),
          ),

          // Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search users',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () => searchController.clear(),
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),

          // Results
          Expanded(
            child: _buildSearchResults(
              context,
              ref,
              searchQuery.value,
              searchResults.value,
              isSearching.value,
              searchError.value,
              isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    WidgetRef ref,
    String query,
    List<SearchUser> results,
    bool isSearching,
    String? error,
    bool isDark,
  ) {
    // Loading state
    if (isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    // Error state
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text('Search failed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red[700])),
            const SizedBox(height: 8),
            Text(error, style: TextStyle(fontSize: 14, color: Colors.grey[600]), textAlign: TextAlign.center),
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
            Text('Search for users', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('Enter a name, username, or email', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
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
            Text('No users found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('Try a different search term', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
          ],
        ),
      );
    }

    // Results list
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 0.5,
        color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
        indent: 76,
      ),
      itemBuilder: (context, index) {
        final user = results[index];
        return _buildUserTile(context, ref, user, isDark);
      },
    );
  }

  Widget _buildUserTile(BuildContext context, WidgetRef ref, SearchUser user, bool isDark) {
    final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
    final avatarColor = _avatarColor(context, user.id);

    return ListTile(
      onTap: () => _handleUserTap(context, ref, user),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: UserAvatar(
        displayName: userName,
        avatarUrl: user.avatarUrl,
        radius: 24,
        backgroundColor: avatarColor,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (user.isContact)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Contact',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('@${user.username}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          if (user.hasConversation)
            Text(
              'Already chatting',
              style: TextStyle(
                fontSize: 12,
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
          color: user.isOnline ? const Color(0xFF31A24C) : Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
        ),
      ),
    );
  }
}
