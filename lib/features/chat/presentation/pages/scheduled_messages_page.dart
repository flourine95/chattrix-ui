import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/domain/enums/enums.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/scheduled_message.dart';
import '../../domain/entities/conversation.dart';
import '../state/scheduled_messages_notifier.dart';
import '../state/conversations_notifier.dart';
import '../utils/conversation_utils.dart';

/// Scheduled messages list page
///
/// Displays all pending, sent, or failed scheduled messages for a specific conversation
class ScheduledMessagesPage extends HookConsumerWidget {
  final int conversationId;

  const ScheduledMessagesPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scheduled Messages'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Sent'),
              Tab(text: 'Failed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ScheduledMessagesList(conversationId: conversationId, status: 'PENDING'),
            _ScheduledMessagesList(conversationId: conversationId, status: 'SENT'),
            _ScheduledMessagesList(conversationId: conversationId, status: 'FAILED'),
            _ScheduledMessagesList(conversationId: conversationId, status: 'CANCELLED'),
          ],
        ),
      ),
    );
  }
}

class _ScheduledMessagesList extends HookConsumerWidget {
  final int conversationId;
  final String status;

  const _ScheduledMessagesList({required this.conversationId, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduledMessagesAsync = ref.watch(scheduledMessagesProvider(conversationId: conversationId, status: status));

    return scheduledMessagesAsync.when(
      data: (messages) {
        if (messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  status == 'PENDING'
                      ? Icons.schedule
                      : status == 'SENT'
                      ? Icons.check_circle_outline
                      : status == 'FAILED'
                      ? Icons.error_outline
                      : Icons.cancel_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  status == 'PENDING'
                      ? 'No scheduled messages'
                      : status == 'SENT'
                      ? 'No sent messages'
                      : status == 'FAILED'
                      ? 'No failed messages'
                      : 'No cancelled messages',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(scheduledMessagesProvider(conversationId: conversationId, status: status).notifier)
                .refresh();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final message = messages[index];
              return _ScheduledMessageCard(conversationId: conversationId, message: message, status: status);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(scheduledMessagesProvider(conversationId: conversationId, status: status).notifier).refresh();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduledMessageCard extends ConsumerWidget {
  final int conversationId;
  final ScheduledMessage message;
  final String status;

  const _ScheduledMessageCard({required this.conversationId, required this.message, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final scheduledTime = message.scheduledTime;
    final messageStatus = message.scheduledStatus ?? status;

    // Get conversation details
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.maybeWhen(
      data: (conversations) => conversations.firstWhere(
        (c) => c.id == message.conversationId,
        orElse: () => Conversation(
          id: message.conversationId,
          type: ConversationType.direct,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          participants: [],
        ),
      ),
      orElse: () => null,
    );

    // Get conversation display name and avatar
    final currentUser = ref.read(currentUserProvider);
    final conversationName = conversation != null
        ? ConversationUtils.getConversationTitle(conversation, currentUser)
        : 'Conversation #${message.conversationId}';

    // Get avatar based on conversation type
    final conversationAvatar = conversation != null
        ? (conversation.type == ConversationType.group
              ? conversation.avatarUrl
              : ConversationUtils.getOtherParticipantAvatarUrl(conversation, currentUser))
        : null;

    // If scheduledTime is null, show a warning message
    if (scheduledTime == null) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with avatar
              Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: conversationAvatar != null ? NetworkImage(conversationAvatar) : null,
                    child: conversationAvatar == null
                        ? Text(
                            conversationName.isNotEmpty ? conversationName[0].toUpperCase() : '?',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      conversationName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.warning, size: 20, color: Colors.orange),
                ],
              ),
              const SizedBox(height: 8),
              // Message content
              Text(message.content, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),
              // Warning
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No schedule time (Backend issue)',
                        style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final timeUntil = scheduledTime.difference(now);
    final isOverdue = timeUntil.isNegative;

    String getTimeUntilText() {
      if (messageStatus != 'PENDING') {
        return DateFormat('HH:mm, dd/MM/yyyy').format(scheduledTime);
      }

      if (isOverdue) {
        return 'Processing...';
      }

      if (timeUntil.inMinutes < 60) {
        return 'In ${timeUntil.inMinutes} minutes';
      } else if (timeUntil.inHours < 24) {
        return 'In ${timeUntil.inHours} hours';
      } else {
        return 'In ${timeUntil.inDays} days';
      }
    }

    Color getStatusColor() {
      switch (messageStatus) {
        case 'PENDING':
          return Colors.blue;
        case 'SENT':
          return Colors.green;
        case 'FAILED':
          return Colors.red;
        case 'CANCELLED':
          return Colors.grey;
        default:
          return Colors.grey;
      }
    }

    IconData getStatusIcon() {
      switch (messageStatus) {
        case 'PENDING':
          return Icons.schedule;
        case 'SENT':
          return Icons.check_circle;
        case 'FAILED':
          return Icons.error;
        case 'CANCELLED':
          return Icons.cancel;
        default:
          return Icons.help;
      }
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to conversation if message is sent
          if (messageStatus == 'SENT') {
            context.go('/chat/${message.conversationId}', extra: {'highlightMessageId': message.id});
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Avatar + Conversation name + status
              Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: conversationAvatar != null ? NetworkImage(conversationAvatar) : null,
                    child: conversationAvatar == null
                        ? Text(
                            conversationName.isNotEmpty ? conversationName[0].toUpperCase() : '?',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      conversationName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(getStatusIcon(), size: 20, color: getStatusColor()),
                ],
              ),
              const SizedBox(height: 8),

              // Message content
              Text(message.content, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),

              // Time info
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    getTimeUntilText(),
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  if (messageStatus == 'PENDING') ...[
                    // Edit button
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
                        context.push(
                          '/chat/${message.conversationId}/schedule-message',
                          extra: {'existingMessage': message},
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    // Cancel button
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: Colors.red),
                      onPressed: () {
                        _showCancelBottomSheet(context, ref, message);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelBottomSheet(BuildContext context, WidgetRef ref, ScheduledMessage message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text('Cancel Scheduled Message', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Message preview
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            // Confirmation text
            const Text(
              'Are you sure you want to cancel this scheduled message?',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Keep Message'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      try {
                        await ref
                            .read(scheduledMessagesProvider(conversationId: conversationId, status: status).notifier)
                            .cancelScheduledMessage(conversationId: conversationId, scheduledMessageId: message.id);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Message cancelled'), backgroundColor: Colors.green),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Cancel Message'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
