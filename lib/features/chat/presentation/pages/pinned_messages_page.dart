import 'package:chattrix_ui/core/widgets/bottom_sheets.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinnedMessagesPage extends HookConsumerWidget {
  final String conversationId;

  const PinnedMessagesPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinnedMessagesAsync = ref.watch(pinnedMessagesProvider(conversationId));
    final me = ref.watch(currentUserProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pinned Messages'), elevation: 0),
      body: pinnedMessagesAsync.when(
        data: (messages) {
          if (messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.push_pin_outlined, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No pinned messages',
                    style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Long press on a message to pin it',
                    style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final message = messages[index];
              final isMe = message.senderId == me?.id;

              return _PinnedMessageCard(
                message: message,
                isMe: isMe,
                conversationId: conversationId,
                onUnpin: () async {
                  final confirmed = await showConfirmationBottomSheet(
                    context: context,
                    title: 'Unpin Message?',
                    message: 'Are you sure you want to unpin this message?',
                    icon: Icons.push_pin,
                    confirmText: 'Unpin',
                  );

                  if (confirmed == true && context.mounted) {
                    try {
                      await ref.read(unpinMessageUsecaseProvider)(
                        conversationId: conversationId,
                        messageId: message.id.toString(),
                      );

                      // Refresh pinned messages
                      ref.invalidate(pinnedMessagesProvider(conversationId));

                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white, size: 20),
                              const SizedBox(width: 12),
                              Text('Message unpinned', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          backgroundColor: Colors.grey.shade900,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.white, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text('Failed to unpin: $e', style: TextStyle(color: Colors.white)),
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
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: colors.error),
              const SizedBox(height: 16),
              Text('Failed to load pinned messages', style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(error.toString(), style: textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(pinnedMessagesProvider(conversationId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinnedMessageCard extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String conversationId;
  final VoidCallback onUnpin;

  const _PinnedMessageCard({
    required this.message,
    required this.isMe,
    required this.conversationId,
    required this.onUnpin,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with sender info and unpin button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.push_pin, size: 16, color: colors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.senderFullName ?? 'Unknown',
                        style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      if (message.pinnedAt != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Pinned by ${message.pinnedByFullName ?? 'Unknown'}',
                          style: textTheme.labelSmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.close, size: 20), onPressed: onUnpin, tooltip: 'Unpin'),
              ],
            ),
          ),

          // Message content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: MessageBubble(message: message, isMe: isMe, currentUserId: message.senderId),
          ),
        ],
      ),
    );
  }
}
