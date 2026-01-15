import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../poll/presentation/widgets/date_time_picker_bottom_sheet.dart';
import '../providers/events_providers.dart';

/// Show date time picker bottom sheet
Future<DateTime?> showDateTimePickerBottomSheet({
  required BuildContext context,
  required DateTime initialDateTime,
}) async {
  return await showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DateTimePickerBottomSheet(
      initialDateTime: initialDateTime,
    ),
  );
}

class CreateEventPage extends HookConsumerWidget {
  const CreateEventPage({super.key, required this.conversationId});

  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Form state
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final locationController = useTextEditingController();
    final startTime = useState<DateTime?>(null);
    final endTime = useState<DateTime?>(null);
    final isCreating = useState(false);

    Future<void> handleCreate() async {
      if (titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter event title')),
        );
        return;
      }

      if (startTime.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select start time')),
        );
        return;
      }

      isCreating.value = true;

      try {
        await ref.read(eventsListProvider(conversationId).notifier).createEvent(
              title: titleController.text.trim(),
              description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
              location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
              startTime: startTime.value!,
              endTime: endTime.value ?? startTime.value!.add(const Duration(hours: 1)),
            );

        if (!context.mounted) return;

        // Invalidate events list to refresh
        ref.invalidate(eventsListProvider(conversationId));

        // Success - navigate back
        context.pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                const Text('Event created successfully'),
              ],
            ),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        
        // Check if it's a backend not implemented error
        final errorMessage = e.toString();
        final isNotImplemented = errorMessage.contains('404') || 
                                 errorMessage.contains('not found') ||
                                 errorMessage.contains('Unknown error');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isNotImplemented ? Icons.info_outline : Icons.error_outline,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isNotImplemented 
                            ? 'Event creation not yet supported by backend'
                            : 'Failed to create event',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                if (!isNotImplemented) ...[
                  const SizedBox(height: 4),
                  Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ],
            ),
            backgroundColor: isNotImplemented ? Colors.orange.shade900 : Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      } finally {
        isCreating.value = false;
      }
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.surface,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Create Event', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          TextButton(
            onPressed: isCreating.value ? null : handleCreate,
            child: isCreating.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('Create', style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            _buildSection(
              context,
              title: 'Event Title',
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter event title',
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                maxLength: 100,
              ),
            ),

            const SizedBox(height: 24),

            // Description
            _buildSection(
              context,
              title: 'Description (Optional)',
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Add event description',
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                maxLines: 3,
                maxLength: 500,
              ),
            ),

            const SizedBox(height: 24),

            // Location
            _buildSection(
              context,
              title: 'Location (Optional)',
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Add location',
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                maxLength: 200,
              ),
            ),

            const SizedBox(height: 24),

            // Start Time
            _buildSection(
              context,
              title: 'Start Time',
              child: InkWell(
                onTap: () async {
                  final selectedDateTime = await showDateTimePickerBottomSheet(
                    context: context,
                    initialDateTime: startTime.value ?? DateTime.now().add(const Duration(hours: 1)),
                  );
                  if (selectedDateTime != null) {
                    startTime.value = selectedDateTime;
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: colors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          startTime.value != null
                              ? _formatDateTime(startTime.value!)
                              : 'Select start time',
                          style: TextStyle(
                            fontSize: 16,
                            color: startTime.value != null ? colors.onSurface : colors.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: colors.onSurface.withValues(alpha: 0.5)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // End Time
            _buildSection(
              context,
              title: 'End Time (Optional)',
              child: InkWell(
                onTap: () async {
                  final selectedDateTime = await showDateTimePickerBottomSheet(
                    context: context,
                    initialDateTime: endTime.value ?? (startTime.value?.add(const Duration(hours: 1)) ?? DateTime.now().add(const Duration(hours: 2))),
                  );
                  if (selectedDateTime != null) {
                    endTime.value = selectedDateTime;
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: colors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          endTime.value != null
                              ? _formatDateTime(endTime.value!)
                              : 'Select end time',
                          style: TextStyle(
                            fontSize: 16,
                            color: endTime.value != null ? colors.onSurface : colors.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: colors.onSurface.withValues(alpha: 0.5)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dateStr;
    if (date == today) {
      dateStr = 'Today';
    } else if (date == tomorrow) {
      dateStr = 'Tomorrow';
    } else {
      dateStr = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }

    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$dateStr at $hour:$minute';
  }
}
