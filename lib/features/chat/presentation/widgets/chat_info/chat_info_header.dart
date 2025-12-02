import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInfoHeader extends ConsumerWidget {
  const ChatInfoHeader({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final me = ref.watch(currentUserProvider);

    final isGroup = conversation.type.toUpperCase() == 'GROUP';
    final displayName = isGroup
        ? (conversation.name ?? 'Group ${conversation.id}')
        : ConversationUtils.getConversationTitle(conversation, me);

    final memberCount = conversation.participants.length;

    // For direct chat, get other user's online status
    final isOnline = !isGroup && ConversationUtils.isUserOnline(conversation, me);
    final lastSeen = !isGroup ? ConversationUtils.getLastSeen(conversation, me) : null;
    final statusText = !isGroup ? ConversationUtils.formatLastSeen(isOnline, lastSeen) : null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.1))),
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: colors.primary,
            child: Text(
              displayName.substring(0, 1).toUpperCase(),
              style: textTheme.headlineMedium?.copyWith(color: colors.onPrimary),
            ),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            displayName,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Status or member count
          if (isGroup)
            Text(
              '$memberCount members',
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            )
          else if (statusText != null)
            Text(
              statusText,
              style: textTheme.bodyMedium?.copyWith(
                color: isOnline ? Colors.green : colors.onSurface.withValues(alpha: 0.6),
              ),
            ),

          const SizedBox(height: 16),

          // Quick actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _QuickActionButton(
                icon: Icons.notifications_outlined,
                label: 'Mute',
                onTap: () {
                  // TODO: Implement mute notifications
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: colors.primary, size: 24),
            ),
            const SizedBox(height: 8),
            Text(label, style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
