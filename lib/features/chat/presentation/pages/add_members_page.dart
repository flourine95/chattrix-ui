import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_state_provider.dart';
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

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final selectedUsers = useState<Set<int>>({});

    // Fetch users based on search query
    debugPrint('🔍 [AddMembers] Current search query: "${searchQuery.value}"');
    final usersAsync = ref.watch(searchUsersProvider(searchQuery.value));

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
          ApiConstants.conversationMembers(int.parse(conversationId)),
          data: {'userIds': selectedUsers.value.toList()},
        );

        debugPrint('✅ Add members response: ${response.data}');

        if (context.mounted) {
          // Close loading dialog
          Navigator.of(context, rootNavigator: true).pop();

          // Go back
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Text('${selectedUsers.value.length} member(s) added', style: const TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        }
      } catch (e) {
        debugPrint('❌ Error adding members: $e');
        if (context.mounted) {
          // Close loading dialog using rootNavigator
          Navigator.of(context, rootNavigator: true).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Failed to add members', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('Add Members', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        actions: [
          if (selectedUsers.value.isNotEmpty)
            TextButton(onPressed: handleAddMembers, child: Text('Add (${selectedUsers.value.length})')),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                debugPrint('🔍 [AddMembers] TextField onChanged: "$value"');
                searchQuery.value = value;
              },
            ),
          ),

          // Selected users chips
          if (selectedUsers.value.isNotEmpty)
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: usersAsync.when(
                data: (users) {
                  final selectedUsersList = users.where((u) => selectedUsers.value.contains(u.id)).toList();
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedUsersList.length,
                    itemBuilder: (context, index) {
                      final user = selectedUsersList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          avatar: UserAvatar(displayName: user.fullName, avatarUrl: user.avatarUrl, radius: 16),
                          label: Text(user.fullName),
                          onDeleted: () {
                            selectedUsers.value = {...selectedUsers.value}..remove(user.id);
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => const SizedBox.shrink(),
              ),
            ),

          // Users list
          Expanded(
            child: usersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: colors.error),
                    const SizedBox(height: 16),
                    Text('Failed to load users', style: textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      error.toString().replaceAll('Exception: ', ''),
                      style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              data: (users) {
                if (searchQuery.value.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: colors.onSurfaceVariant.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'Search for users to add',
                          style: textTheme.titleMedium?.copyWith(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Type a name or username to find users',
                          style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  );
                }

                if (searchQuery.value.length < 2) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: colors.onSurfaceVariant.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'Type at least 2 characters',
                          style: textTheme.titleMedium?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                }

                debugPrint(
                  '🔍 [AddMembers] Search results: ${users.length} users found for query "${searchQuery.value}"',
                );

                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_off_outlined,
                          size: 64,
                          color: colors.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text('No users found', style: textTheme.titleMedium?.copyWith(color: colors.onSurfaceVariant)),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search term',
                          style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant.withValues(alpha: 0.7)),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isSelected = selectedUsers.value.contains(user.id);

                    return ListTile(
                      leading: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          UserAvatar(displayName: user.fullName, avatarUrl: user.avatarUrl, radius: 24),
                          if (user.isOnline)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: colors.surface, width: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(user.fullName, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
                      subtitle: Text(
                        '@${user.username}',
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          if (value == true) {
                            selectedUsers.value = {...selectedUsers.value, user.id};
                          } else {
                            selectedUsers.value = {...selectedUsers.value}..remove(user.id);
                          }
                        },
                      ),
                      onTap: () {
                        if (isSelected) {
                          selectedUsers.value = {...selectedUsers.value}..remove(user.id);
                        } else {
                          selectedUsers.value = {...selectedUsers.value, user.id};
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
