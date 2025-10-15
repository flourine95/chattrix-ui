import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  Color _avatarColor(BuildContext context, int seed) {
    final colors = <Color>[
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
    ];
    return colors[seed % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text('Chats', style: textTheme.titleLarge)),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final unread = index % 2 == 0 ? (index % 5) + 1 : 0;
          final username = 'User ${index + 1}';
          final lastMessage = 'Last message from $username';
          final avatarColor = _avatarColor(context, index + 3 * 7);
          return ListTile(
            onTap: () =>
                context.go('/chat/${index + 1}', extra: {'name': username}),
            leading: CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(
                username.substring(0, 1),
                style: textTheme.titleMedium?.copyWith(
                  color: avatarColor == primary
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            title: Text(username, style: textTheme.titleMedium),
            subtitle: Text(lastMessage, style: textTheme.bodySmall),
            trailing: unread > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unread',
                      style: textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
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
