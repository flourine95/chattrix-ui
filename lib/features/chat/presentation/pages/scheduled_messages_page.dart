import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:chattrix_ui/features/chat/domain/entities/scheduled_message.dart';
import 'package:chattrix_ui/features/chat/presentation/state/scheduled_messages_notifier.dart';

/// Scheduled messages list page
///
/// Displays all pending, sent, or failed scheduled messages for a specific conversation
class ScheduledMessagesPage extends HookConsumerWidget {
  final int conversationId;

  const ScheduledMessagesPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          title: const Text('Scheduled Messages', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(49),
            child: Column(
              children: [
                TabBar(
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  tabs: const [
                    Tab(text: 'Pending'),
                    Tab(text: 'Sent'),
                    Tab(text: 'Failed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
                Container(
                  height: 0.5,
                  color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                ),
              ],
            ),
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
                  color: Colors.grey[400],
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
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return _MessageBubble(conversationId: conversationId, message: message, status: status);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Failed to load messages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red[700]),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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

class _MessageBubble extends ConsumerWidget {
  final int conversationId;
  final ScheduledMessage message;
  final String status;

  const _MessageBubble({required this.conversationId, required this.message, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();
    final scheduledTime = message.scheduledTime;
    final messageStatus = message.scheduledStatus ?? status;

    // Colors based on status
    final bubbleColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getStatusColor(messageStatus).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(_getStatusIcon(messageStatus), size: 18, color: _getStatusColor(messageStatus)),
          ),
          const SizedBox(width: 12),

          // Message bubble
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (messageStatus == 'SENT') {
                  context.go('/chat/${message.conversationId}', extra: {'highlightMessageId': message.id});
                }
              },
              onLongPress: messageStatus == 'PENDING' ? () => _showOptionsBottomSheet(context, ref, message) : null,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Message content
                    Text(message.content, style: TextStyle(fontSize: 15, color: textColor)),
                    const SizedBox(height: 8),

                    // Time info
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _getTimeText(scheduledTime, messageStatus, now),
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Action buttons for pending messages
          if (messageStatus == 'PENDING') ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              onPressed: () => _showOptionsBottomSheet(context, ref, message),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
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

  IconData _getStatusIcon(String status) {
    switch (status) {
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

  String _getTimeText(DateTime? scheduledTime, String status, DateTime now) {
    if (scheduledTime == null) {
      return 'No schedule time';
    }

    if (status != 'PENDING') {
      return DateFormat('HH:mm, dd/MM/yyyy').format(scheduledTime);
    }

    final timeUntil = scheduledTime.difference(now);

    if (timeUntil.isNegative) {
      return 'Processing...';
    }

    if (timeUntil.inMinutes < 60) {
      return 'In ${timeUntil.inMinutes} min';
    } else if (timeUntil.inHours < 24) {
      return 'In ${timeUntil.inHours} hours';
    } else if (timeUntil.inDays < 7) {
      return 'In ${timeUntil.inDays} days';
    } else {
      return DateFormat('HH:mm, dd/MM/yyyy').format(scheduledTime);
    }
  }

  void _showOptionsBottomSheet(BuildContext context, WidgetRef ref, ScheduledMessage message) {
    final colors = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Edit option
            ListTile(
              leading: Icon(Icons.edit, color: colors.onSurface),
              title: const Text('Edit Message'),
              onTap: () {
                Navigator.pop(context);
                context.push('/chat/${message.conversationId}/schedule-message', extra: {'existingMessage': message});
              },
            ),

            // Cancel option
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Cancel Message', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showCancelConfirmation(context, ref, message);
              },
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, WidgetRef ref, ScheduledMessage message) {
    final colors = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
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
              decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
              child: Text(
                message.content,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),

            // Confirmation text
            Text(
              'Are you sure you want to cancel this scheduled message?',
              style: TextStyle(fontSize: 14, color: colors.onSurface.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Keep'),
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
                          AppToast.success(
                            context,
                            title: 'Message Cancelled',
                            description: 'Scheduled message has been cancelled',
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          AppToast.error(context, title: 'Failed to cancel', description: e.toString());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
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
