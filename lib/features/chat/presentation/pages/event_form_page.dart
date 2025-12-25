import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import '../providers/event_providers.dart';
import '../../domain/entities/event.dart';

class EventFormPage extends HookConsumerWidget {
  const EventFormPage({super.key, required this.conversationId, this.event});

  final int conversationId;
  final Event? event; // null = create, non-null = edit

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isEdit = event != null;

    // Controllers
    final titleController = useTextEditingController(text: event?.title ?? '');
    final descController = useTextEditingController(text: event?.description ?? '');
    final locationController = useTextEditingController(text: event?.location ?? '');

    // Date/Time states
    final startDate = useState(event?.startTime ?? DateTime.now().add(const Duration(days: 1)));
    final startTime = useState(
      TimeOfDay.fromDateTime(event?.startTime ?? DateTime.now().add(const Duration(hours: 1))),
    );
    final endDate = useState(event?.endTime ?? DateTime.now().add(const Duration(days: 1, hours: 1)));
    final endTime = useState(TimeOfDay.fromDateTime(event?.endTime ?? DateTime.now().add(const Duration(hours: 2))));

    final isLoading = useState(false);

    Future<void> handleSubmit() async {
      final title = titleController.text.trim();
      if (title.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide a title')));
        return;
      }

      final start = DateTime(
        startDate.value.year,
        startDate.value.month,
        startDate.value.day,
        startTime.value.hour,
        startTime.value.minute,
      );

      final end = DateTime(
        endDate.value.year,
        endDate.value.month,
        endDate.value.day,
        endTime.value.hour,
        endTime.value.minute,
      );

      if (end.isBefore(start)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('End time must be after start time')));
        return;
      }

      isLoading.value = true;

      try {
        if (isEdit) {
          // Update event
          final useCase = ref.read(updateEventUseCaseProvider);
          final result = await useCase(
            conversationId: conversationId,
            eventId: event!.id,
            title: title,
            description: descController.text.trim().isEmpty ? null : descController.text.trim(),
            location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
            startTime: start,
            endTime: end,
          );

          result.fold(
            (failure) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Failed to update event: ${failure.message}')));
              }
            },
            (_) {
              ref.invalidate(allEventsProvider(conversationId));
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event updated successfully')));
              }
            },
          );
        } else {
          // Create event
          final useCase = ref.read(createEventUseCaseProvider);
          final result = await useCase(
            conversationId: conversationId,
            title: title,
            description: descController.text.trim().isEmpty ? null : descController.text.trim(),
            location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
            startTime: start,
            endTime: end,
          );

          result.fold(
            (failure) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Failed to create event: ${failure.message}')));
              }
            },
            (_) {
              ref.invalidate(allEventsProvider(conversationId));
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event created successfully')));
              }
            },
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Event' : 'Create Event'),
        actions: [
          if (isLoading.value)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            )
          else
            TextButton(onPressed: handleSubmit, child: Text(isEdit ? 'Save' : 'Create')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Event Title *',
                hintText: 'e.g., Team Meeting',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.title),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Add event details...',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Location
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'e.g., Conference Room A',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.location_on),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),

            // Start Date & Time
            Text('Start Date & Time *', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate.value,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        startDate.value = date;
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormat('MMM dd, yyyy').format(startDate.value)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final time = await showTimePicker(context: context, initialTime: startTime.value);
                      if (time != null) {
                        startTime.value = time;
                      }
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(startTime.value.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // End Date & Time
            Text('End Date & Time *', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: endDate.value,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        endDate.value = date;
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormat('MMM dd, yyyy').format(endDate.value)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final time = await showTimePicker(context: context, initialTime: endTime.value);
                      if (time != null) {
                        endTime.value = time;
                      }
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(endTime.value.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isLoading.value ? null : handleSubmit,
                icon: isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(isEdit ? Icons.save : Icons.add),
                label: Text(isEdit ? 'Save Changes' : 'Create Event'),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
