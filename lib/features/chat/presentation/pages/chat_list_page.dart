import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends HookConsumerWidget {
  const ChatListPage({super.key});

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
    final textTheme = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;
    final me = ref.watch(currentUserProvider);

    final conversationsAsync = ref.watch(conversationsProvider);

    // Watch WebSocket connection to ensure it's initialized
    ref.watch(webSocketConnectionProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Chats', style: textTheme.titleLarge)),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return Center(child: Text('No conversations yet', style: textTheme.bodyMedium));
          }
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final c = conversations[index];
              final title = ConversationUtils.getConversationTitle(c, me);
              final avatarColor = _avatarColor(context, index + 21);

              // Get last message and format it
              final lastMessageText = ConversationUtils.formatLastMessage(c.lastMessage, me);

              // Check if user is online (for DIRECT conversations)
              final isOnline = ConversationUtils.isUserOnline(c, me);
              final lastSeen = ConversationUtils.getLastSeen(c, me);

              // Format subtitle based on conversation type
              String subtitle;
              if (c.type.toUpperCase() == 'DIRECT') {
                // For DIRECT: show last message or last seen status
                if (c.lastMessage != null) {
                  subtitle = lastMessageText;
                } else {
                  subtitle = ConversationUtils.formatLastSeen(isOnline, lastSeen);
                }
              } else {
                // For GROUP: show last message
                subtitle = lastMessageText;
              }

              return ListTile(
                onTap: () =>
                    context.push('/chat/${c.id}', extra: {'name': title, 'color': _avatarColor(context, index + 21)}),
                leading: Stack(
                  children: [
                    UserAvatar(
                      displayName: title,
                      avatarUrl: ConversationUtils.getOtherParticipantAvatarUrl(c, me),
                      radius: 24,
                      backgroundColor: avatarColor,
                    ),
                    // Online indicator for DIRECT conversations
                    if (c.type.toUpperCase() == 'DIRECT' && isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(title, style: textTheme.titleMedium),
                subtitle: Text(subtitle, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: c.lastMessage != null
                    ? Text(
                        ConversationUtils.formatTimeAgo(c.lastMessage!.createdAt),
                        style: textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      )
                    : null,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Failed to load conversations', style: textTheme.bodyMedium)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new-chat'),
        backgroundColor: primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const FaIcon(FontAwesomeIcons.solidPenToSquare),
      ),
    );
  }
}
