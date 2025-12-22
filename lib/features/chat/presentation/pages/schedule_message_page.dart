import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/scheduled_message.dart';
import '../state/scheduled_messages_notifier.dart';
import '../widgets/time_picker_bottom_sheet.dart';

/// Schedule message page
///
/// Create or edit scheduled messages
class ScheduleMessagePage extends HookConsumerWidget {
  const ScheduleMessagePage({super.key, required this.conversationId, this.existingMessage});

  final int conversationId;
  final ScheduledMessage? existingMessage;

  bool get isEditMode => existingMessage != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Controllers
    final contentController = useTextEditingController(text: existingMessage?.content ?? '');
    final selectedTime = useState<DateTime>(
      existingMessage?.scheduledTime ?? DateTime.now().add(const Duration(hours: 1)),
    );
    final isLoading = useState(false);
    final hasUnsavedChanges = useState(false);

    // Track changes
    useEffect(() {
      void listener() {
        hasUnsavedChanges.value = contentController.text.isNotEmpty;
      }

      contentController.addListener(listener);
      return () => contentController.removeListener(listener);
    }, [contentController]);

    // Validation
    final isValid = contentController.text.trim().isNotEmpty && selectedTime.value.isAfter(DateTime.now());

    // Format time display
    String formatTime(DateTime time) {
      final now = DateTime.now();
      final difference = time.difference(now);

      if (difference.inMinutes < 60) {
        return 'In ${difference.inMinutes} minutes';
      } else if (difference.inHours < 24) {
        return 'In ${difference.inHours} hours';
      } else if (difference.inDays == 1) {
        return 'Tomorrow at ${DateFormat('HH:mm').format(time)}';
      } else {
        return DateFormat('HH:mm, dd/MM/yyyy').format(time);
      }
    }

    // Handle back button
    Future<bool> onWillPop() async {
      if (!hasUnsavedChanges.value) return true;

      final shouldPop = await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Discard Changes?',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Unsaved content will be lost.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Continue Editing', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Discard', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );

      return shouldPop ?? false;
    }

    // Handle schedule/update
    Future<void> handleSubmit() async {
      if (!isValid || isLoading.value) return;

      isLoading.value = true;

      try {
        if (isEditMode) {
          // Update existing message
          await ref
              .read(scheduledMessagesProvider(status: 'PENDING').notifier)
              .updateScheduledMessage(
                scheduledMessageId: existingMessage!.id,
                content: contentController.text.trim(),
                scheduledTime: selectedTime.value,
              );

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Message updated'), backgroundColor: Colors.green));
            context.pop();
          }
        } else {
          // Create new message
          await ref
              .read(scheduledMessagesProvider(status: 'PENDING').notifier)
              .scheduleMessage(
                conversationId: conversationId,
                content: contentController.text.trim(),
                type: 'TEXT',
                scheduledTime: selectedTime.value,
              );

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Message scheduled'), backgroundColor: Colors.green));
            context.pop();
          }
        }
      } catch (e) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to ${isEditMode ? 'update' : 'create'} message: $e'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    // Handle cancel message
    Future<void> handleCancel() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cancel Scheduled Message'),
          content: const Text('Are you sure you want to cancel this message?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Cancel Message'),
            ),
          ],
        ),
      );

      if (confirmed == true && context.mounted) {
        isLoading.value = true;
        try {
          await ref
              .read(scheduledMessagesProvider(status: 'PENDING').notifier)
              .cancelScheduledMessage(scheduledMessageId: existingMessage!.id);

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Message cancelled'), backgroundColor: Colors.green));
            context.pop();
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
          }
        } finally {
          isLoading.value = false;
        }
      }
    }

    return PopScope(
      canPop: !hasUnsavedChanges.value,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await onWillPop();
          if (shouldPop && context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode ? 'Edit Scheduled Message' : 'Schedule Message'),
          actions: [
            if (!isEditMode)
              IconButton(
                icon: const Icon(Icons.list),
                tooltip: 'View Scheduled Messages',
                onPressed: () {
                  context.push('/scheduled-messages');
                },
              ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Message content input
                  Card(
                    elevation: 0,
                    color: colors.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Message Content',
                            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: contentController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter message content...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              filled: true,
                              fillColor: colors.surface,
                            ),
                            enabled: !isLoading.value,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Time selection
                  Card(
                    elevation: 0,
                    color: colors.surfaceContainerHighest,
                    child: InkWell(
                      onTap: isLoading.value
                          ? null
                          : () async {
                              final newTime = await TimePickerBottomSheet.show(
                                context,
                                initialTime: selectedTime.value,
                              );

                              if (newTime != null) {
                                selectedTime.value = newTime;
                              }
                            },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colors.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.schedule, color: colors.onPrimaryContainer),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Send Time',
                                    style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(selectedTime.value),
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat('HH:mm, dd/MM/yyyy').format(selectedTime.value),
                                    style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Warning if time is in the past
                  if (!selectedTime.value.isAfter(DateTime.now())) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Time must be in the future',
                              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.orange.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Submit button
                  FilledButton(
                    onPressed: isValid && !isLoading.value ? handleSubmit : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading.value
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(
                            isEditMode ? 'Update' : 'Schedule',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),

                  // Cancel button (only in edit mode)
                  if (isEditMode) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: isLoading.value ? null : handleCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Loading overlay
            if (isLoading.value)
              Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
