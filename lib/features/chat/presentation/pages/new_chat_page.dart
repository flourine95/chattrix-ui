import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewChatPage extends ConsumerWidget {
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

  Future<void> _createConversation(
    BuildContext context,
    WidgetRef ref,
    User selectedUser,
    User? currentUser,
  ) async {
    if (currentUser == null) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final createUsecase = ref.read(createConversationUsecaseProvider);
    final result = await createUsecase(
      type: 'DIRECT',
      participantIds: [currentUser.id.toString(), selectedUser.id.toString()],
    );

    // Close loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    result.fold(
      (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        }
      },
      (conversation) {
        // Refresh conversations list
        ref.invalidate(conversationsProvider);

        // Navigate to chat view
        if (context.mounted) {
          final userName = selectedUser.fullName.isNotEmpty
              ? selectedUser.fullName
              : selectedUser.username;
          
          // Pop current page and navigate to chat
          context.pop();
          context.push(
            '/chat/${conversation.id}',
            extra: {
              'name': userName,
              'color': _avatarColor(context, selectedUser.id),
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final currentUser = ref.watch(currentUserProvider);
    final onlineUsersAsync = ref.watch(onlineUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat', style: textTheme.titleLarge),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: onlineUsersAsync.when(
        data: (users) {
          // Filter out current user
          final otherUsers = users
              .where((user) => user.id != currentUser?.id)
              .toList();

          if (otherUsers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No users available',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'There are no other users online right now',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: otherUsers.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = otherUsers[index];
              final userName = user.fullName.isNotEmpty
                  ? user.fullName
                  : user.username;
              final avatarColor = _avatarColor(context, user.id);
              final initial = userName.isNotEmpty ? userName.substring(0, 1) : '?';

              return ListTile(
                onTap: () => _createConversation(context, ref, user, currentUser),
                leading: CircleAvatar(
                  backgroundColor: avatarColor,
                  child: Text(
                    initial,
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(userName, style: textTheme.titleMedium),
                subtitle: Text(
                  '@${user.username}',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load users',
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.red[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(onlineUsersProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

