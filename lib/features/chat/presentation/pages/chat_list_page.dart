import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  Color _avatarColor(BuildContext context, int seed) {
    final colors = <Color>[
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
    ];
    return colors[seed % colors.length];
  }

  String _conversationTitle(Conversation c, User? me) {
    if (c.type.toUpperCase() == 'DIRECT') {
      final other = c.participants.firstWhere(
        (p) => p.userId != me?.id,
        orElse: () => c.participants.first,
      );
      return other.fullName.isNotEmpty ? other.fullName : other.username;
    }
    return c.name ?? 'Group';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;
    final me = ref.watch(currentUserProvider);

    final conversationsAsync = ref.watch(conversationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Chats', style: textTheme.titleLarge)),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return Center(
              child: Text('No conversations yet', style: textTheme.bodyMedium),
            );
          }
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final c = conversations[index];
              final title = _conversationTitle(c, me);
              final avatarColor = _avatarColor(context, index + 21);
              final initial = title.isNotEmpty ? title.substring(0, 1) : '?';
              return ListTile(
                onTap: () =>
                    context.go('/chat/${c.id}', extra: {'name': title}),
                leading: CircleAvatar(
                  backgroundColor: avatarColor,
                  child: Text(
                    initial,
                    style: textTheme.titleMedium?.copyWith(
                      color: avatarColor == primary
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                title: Text(title, style: textTheme.titleMedium),
                subtitle: Text(c.name ?? c.type, style: textTheme.bodySmall),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text(
            'Failed to load conversations',
            style: textTheme.bodyMedium,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const FaIcon(FontAwesomeIcons.solidPenToSquare),
      ),
    );
  }
}
