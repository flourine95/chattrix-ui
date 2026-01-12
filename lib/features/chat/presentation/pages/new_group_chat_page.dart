import 'dart:async';

import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewGroupChatPage extends HookConsumerWidget {
  const NewGroupChatPage({super.key});

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

  Future<void> _createGroup(
    BuildContext context,
    WidgetRef ref,
    String groupName,
    List<SearchUser> selectedUsers,
  ) async {
    // Validate group name
    if (groupName.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a group name'), backgroundColor: Colors.orange));
      return;
    }

    // Validate member count (at least 2 members excluding current user)
    if (selectedUsers.length < 2) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select at least 2 members'), backgroundColor: Colors.orange));
      return;
    }

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

    // Prepare participant IDs (current user + selected users)
    final participantIds = [currentUser.id.toString(), ...selectedUsers.map((u) => u.id.toString())];

    final createUsecase = ref.read(createConversationUsecaseProvider);
    final result = await createUsecase(name: groupName.trim(), type: 'GROUP', participantIds: participantIds);

    // Close loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    result.fold(
      (failure) {
        // Handle group creation failure
        if (context.mounted) {
          // Use the when method to handle different failure types
          final errorMessage = failure.when(
            validation: (message, code, details, requestId) => 'Invalid group: $message',
            conflict: (message, code, requestId) => 'Group already exists',
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
        // Handle group creation success
        // Refresh conversations list to show the new group
        ref.invalidate(conversationsProvider);

        // Navigate to chat view
        if (context.mounted) {
          // Pop current page and navigate to chat
          context.pop();
          context.push(
            '/chat/${conversation.id}',
            extra: {'name': groupName.trim(), 'color': _avatarColor(context, conversation.id)},
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final searchController = useTextEditingController();
    final groupNameController = useTextEditingController();
    final searchQuery = useState('');
    final searchResults = useState<List<SearchUser>>([]);
    final selectedUsers = useState<List<SearchUser>>([]);
    final isSearching = useState(false);
    final searchError = useState<String?>(null);

    // Debounce timer for search
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
        title: Text('New Group', style: textTheme.titleLarge),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          TextButton(
            onPressed: () => _createGroup(context, ref, groupNameController.text, selectedUsers.value),
            child: Text(
              'Create',
              style: textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Group Name Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText: 'Group name',
                prefixIcon: const Icon(Icons.group),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),

          // Selected Users Chips
          if (selectedUsers.value.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedUsers.value.length,
                itemBuilder: (context, index) {
                  final user = selectedUsers.value[index];
                  final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: _avatarColor(context, user.id),
                        child: Text(
                          userName.substring(0, 1),
                          style: textTheme.labelSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                      label: Text(userName),
                      onDeleted: () {
                        selectedUsers.value = List.from(selectedUsers.value)..removeAt(index);
                      },
                    ),
                  );
                },
              ),
            ),

          // Search TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search users to add...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
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
              selectedUsers.value,
              isSearching.value,
              searchError.value,
              (user) {
                if (selectedUsers.value.contains(user)) {
                  selectedUsers.value = List.from(selectedUsers.value)..remove(user);
                } else {
                  selectedUsers.value = [...selectedUsers.value, user];
                }
              },
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
    List<SearchUser> selectedUsers,
    bool isSearching,
    String? error,
    void Function(SearchUser) onUserToggle,
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
            Text('Search failed', style: textTheme.titleMedium?.copyWith(color: Colors.red[700])),
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
            Icon(Icons.group_add, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('Add members to your group', style: textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('Search for users to add', style: textTheme.bodySmall?.copyWith(color: Colors.grey[500])),
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
            Text('No users found', style: textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('Try a different search term', style: textTheme.bodySmall?.copyWith(color: Colors.grey[500])),
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
        final isSelected = selectedUsers.contains(user);
        return _buildUserTile(context, ref, textTheme, user, isSelected, onUserToggle);
      },
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    WidgetRef ref,
    TextTheme textTheme,
    SearchUser user,
    bool isSelected,
    void Function(SearchUser) onUserToggle,
  ) {
    final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
    final avatarColor = _avatarColor(context, user.id);

    return ListTile(
      onTap: () => onUserToggle(user),
      leading: UserAvatar(displayName: userName, avatarUrl: user.avatarUrl, radius: 20, backgroundColor: avatarColor),
      title: Row(
        children: [
          Expanded(child: Text(userName, style: textTheme.titleMedium)),
          if (user.isContact)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Contact',
                style: textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
        ],
      ),
      subtitle: Text('@${user.username}', style: textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
      trailing: Checkbox(value: isSelected, onChanged: (_) => onUserToggle(user)),
    );
  }
}
