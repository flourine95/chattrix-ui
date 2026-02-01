import 'dart:async';

import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Page to add members to a group conversation
///
/// Uses searchUsersProvider to fetch and search users
/// Calls POST /conversations/{conversationId}/members API
class AddMembersPage extends HookConsumerWidget {
  const AddMembersPage({super.key, required this.conversationId});

  final int conversationId;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final searchQuery = useState('');
    final selectedUsers = useState<List<dynamic>>([]);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);

    // Debounce timer for search
    useEffect(() {
      Timer? debounceTimer;

      void onSearchChanged() {
        debounceTimer?.cancel();
        debounceTimer = Timer(const Duration(milliseconds: 500), () {
          searchQuery.value = searchController.text.trim();
        });
      }

      searchController.addListener(onSearchChanged);

      return () {
        debounceTimer?.cancel();
        searchController.removeListener(onSearchChanged);
      };
    }, [searchController]);

    Future<void> handleAddMembers() async {
      if (selectedUsers.value.isEmpty) return;

      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final dio = ref.read(dioProvider);
        final response = await dio.post(
          ApiConstants.conversationMembers(conversationId),
          data: {'userIds': selectedUsers.value.map((u) => u.id).toList()},
        );

        debugPrint('✅ Add members response: ${response.data}');

        // Refresh conversations immediately to update participants list
        await ref.refresh(conversationsProvider.future);

        if (context.mounted) {
          // Close loading dialog
          Navigator.of(context, rootNavigator: true).pop();

          // Go back with success result
          context.pop(true);

          // Show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    '${selectedUsers.value.length} member(s) added successfully',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        debugPrint('❌ Error adding members: $e');

        // Extract error message
        String errorMessage = 'Failed to add members';
        if (e.toString().contains('Only admins can perform this action')) {
          errorMessage = 'Only admins can add members to this group';
        } else if (e.toString().contains('FORBIDDEN')) {
          errorMessage = 'You don\'t have permission to add members';
        } else if (e.toString().contains('NOT_FOUND')) {
          errorMessage = 'Group not found';
        } else if (e.toString().contains('ALREADY_MEMBER')) {
          errorMessage = 'Some users are already members';
        }

        if (context.mounted) {
          // Close loading dialog
          Navigator.of(context, rootNavigator: true).pop();

          // Show error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(errorMessage, style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Add Members', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        actions: [
          if (selectedUsers.value.isNotEmpty)
            TextButton(
              onPressed: handleAddMembers,
              child: Text(
                'Add (${selectedUsers.value.length})',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
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
      body: Column(
        children: [
          // Selected Users Chips
          if (selectedUsers.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Container(
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserAvatar(
                              displayName: userName,
                              avatarUrl: user.avatarUrl,
                              radius: 14,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                selectedUsers.value = List.from(selectedUsers.value)..removeAt(index);
                              },
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          // Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search users to add',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(icon: const Icon(Icons.clear, size: 20), onPressed: () => searchController.clear())
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),

          // Results
          Expanded(
            child: _buildSearchResults(context, ref, searchQuery.value, selectedUsers.value, isDark, (user) {
              if (selectedUsers.value.contains(user)) {
                selectedUsers.value = List.from(selectedUsers.value)..remove(user);
              } else {
                selectedUsers.value = [...selectedUsers.value, user];
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    WidgetRef ref,
    String query,
    List<dynamic> selectedUsers,
    bool isDark,
    void Function(dynamic) onUserToggle,
  ) {
    // Empty query state
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Add members to group',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text('Search for users to add', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
          ],
        ),
      );
    }

    // Watch search provider
    final searchAsync = ref.watch(searchUsersProvider(query));

    return searchAsync.when(
      data: (results) {
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                ),
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
            final isSelected = selectedUsers.contains(user);
            return _buildUserTile(context, ref, user, isSelected, isDark, onUserToggle);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Search failed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red[700]),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    WidgetRef ref,
    dynamic user,
    bool isSelected,
    bool isDark,
    void Function(dynamic) onUserToggle,
  ) {
    final userName = user.fullName.isNotEmpty ? user.fullName : user.username;
    final avatarColor = _avatarColor(context, user.id);

    return ListTile(
      onTap: () => onUserToggle(user),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          UserAvatar(displayName: userName, avatarUrl: user.avatarUrl, radius: 24, backgroundColor: avatarColor),
          if (user.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF31A24C),
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
      subtitle: Text('@${user.username}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[400]!, width: 2),
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
        ),
        child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
      ),
    );
  }
}
