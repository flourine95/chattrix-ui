import 'package:chattrix_ui/core/widgets/bottom_sheets.dart';
import 'package:chattrix_ui/features/chat/domain/entities/event_entity.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/events_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventsPage extends HookConsumerWidget {
  final String conversationId;

  const EventsPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsListProvider(conversationId));
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateEventDialog(context, ref),
            tooltip: 'Create Event',
          ),
        ],
      ),
      body: eventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No events yet',
                    style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create an event to get started',
                    style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return _EventCard(
                event: event,
                conversationId: conversationId,
                onTap: () => _showEventDetails(context, ref, event),
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
              Text('Failed to load events', style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(error.toString(), style: textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(eventsListProvider(conversationId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _CreateEventDialog(conversationId: conversationId),
    );
  }

  void _showEventDetails(BuildContext context, WidgetRef ref, EventEntity event) {
    // TODO: Implement event details dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text('Event details coming soon', style: TextStyle(color: Colors.white)),
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

class _EventCard extends HookConsumerWidget {
  final EventEntity event;
  final String conversationId;
  final VoidCallback onTap;

  const _EventCard({required this.event, required this.conversationId, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        onLongPress: () => _showEventOptions(context, ref),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and creator
              Row(
                children: [
                  Expanded(
                    child: Text(event.title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: event.creator.avatarUrl != null ? NetworkImage(event.creator.avatarUrl!) : null,
                    child: event.creator.avatarUrl == null
                        ? Text(event.creator.username[0].toUpperCase(), style: const TextStyle(fontSize: 12))
                        : null,
                  ),
                ],
              ),

              if (event.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  event.description!,
                  style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 12),

              // Date and time
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(dateFormat.format(event.startTime), style: textTheme.bodySmall?.copyWith(color: colors.primary)),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(
                    '${timeFormat.format(event.startTime)} - ${timeFormat.format(event.endTime)}',
                    style: textTheme.bodySmall?.copyWith(color: colors.primary),
                  ),
                ],
              ),

              if (event.location != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event.location!,
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // RSVP counts and current user status
              Row(
                children: [
                  _RsvpChip(
                    icon: Icons.check_circle,
                    label: '${event.goingCount} Going',
                    color: Colors.green,
                    isSelected: event.currentUserRsvpStatus == 'GOING',
                    onTap: () => _rsvp(context, ref, RsvpStatus.going),
                  ),
                  const SizedBox(width: 8),
                  _RsvpChip(
                    icon: Icons.help_outline,
                    label: '${event.maybeCount} Maybe',
                    color: Colors.orange,
                    isSelected: event.currentUserRsvpStatus == 'MAYBE',
                    onTap: () => _rsvp(context, ref, RsvpStatus.maybe),
                  ),
                  const SizedBox(width: 8),
                  _RsvpChip(
                    icon: Icons.cancel,
                    label: '${event.notGoingCount} Not Going',
                    color: Colors.red,
                    isSelected: event.currentUserRsvpStatus == 'NOT_GOING',
                    onTap: () => _rsvp(context, ref, RsvpStatus.notGoing),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _rsvp(BuildContext context, WidgetRef ref, RsvpStatus status) async {
    try {
      await ref.read(eventsListProvider(conversationId).notifier).rsvpEvent(eventId: event.id, status: status.value);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text('RSVP updated', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.grey.shade900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
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
                child: Text('Failed to update RSVP: $e', style: TextStyle(color: Colors.white)),
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

  void _showEventOptions(BuildContext context, WidgetRef ref) {
    final options = <BottomSheetOption>[
      BottomSheetOption(
        icon: Icons.edit,
        label: 'Edit Event',
        onTap: () {
          // TODO: Implement edit event
        },
      ),
      BottomSheetOption(
        icon: Icons.delete,
        label: 'Delete Event',
        isDangerous: true,
        onTap: () async {
          final confirmed = await showConfirmationBottomSheet(
            context: context,
            title: 'Delete Event?',
            message: 'Are you sure you want to delete this event? This action cannot be undone.',
            icon: Icons.delete,
            isDangerous: true,
            confirmText: 'Delete',
          );

          if (confirmed == true && context.mounted) {
            try {
              await ref.read(eventsListProvider(conversationId).notifier).deleteEvent(event.id);

              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text('Event deleted', style: TextStyle(color: Colors.white)),
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
                        child: Text('Failed to delete event: $e', style: TextStyle(color: Colors.white)),
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
      ),
    ];

    showOptionsBottomSheet(context: context, title: 'Event Options', options: options);
  }
}

class _RsvpChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _RsvpChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(color: isSelected ? color : Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? color : Colors.grey),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateEventDialog extends HookConsumerWidget {
  final String conversationId;

  const _CreateEventDialog({required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final locationController = useTextEditingController();
    final startDate = useState<DateTime>(DateTime.now());
    final endDate = useState<DateTime>(DateTime.now().add(const Duration(hours: 1)));
    final isLoading = useState(false);

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Future<void> selectStartDate() async {
      final date = await showDatePicker(
        context: context,
        initialDate: startDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (date != null) {
        if (!context.mounted) return;
        final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(startDate.value));

        if (time != null) {
          startDate.value = DateTime(date.year, date.month, date.day, time.hour, time.minute);

          // Auto-adjust end date if it's before start date
          if (endDate.value.isBefore(startDate.value)) {
            endDate.value = startDate.value.add(const Duration(hours: 1));
          }
        }
      }
    }

    Future<void> selectEndDate() async {
      final date = await showDatePicker(
        context: context,
        initialDate: endDate.value,
        firstDate: startDate.value,
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (date != null) {
        if (!context.mounted) return;
        final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(endDate.value));

        if (time != null) {
          endDate.value = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        }
      }
    }

    Future<void> createEvent() async {
      if (titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Please enter event title', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      if (endDate.value.isBefore(startDate.value)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('End time must be after start time', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      isLoading.value = true;

      try {
        await ref
            .read(eventsListProvider(conversationId).notifier)
            .createEvent(
              title: titleController.text.trim(),
              description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
              startTime: startDate.value,
              endTime: endDate.value,
              location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
            );

        if (!context.mounted) return;
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Event created successfully', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      } catch (e) {
        isLoading.value = false;
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to create event: $e', style: TextStyle(color: Colors.white)),
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

    final dateFormat = DateFormat('MMM dd, yyyy h:mm a');

    return AlertDialog(
      title: const Text('Create Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Event Title *',
                hintText: 'Enter event title',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter event description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'Enter event location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            Text('Start Time', style: textTheme.labelMedium),
            const SizedBox(height: 8),
            InkWell(
              onTap: selectStartDate,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.outline),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20, color: colors.primary),
                    const SizedBox(width: 12),
                    Text(dateFormat.format(startDate.value)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('End Time', style: textTheme.labelMedium),
            const SizedBox(height: 8),
            InkWell(
              onTap: selectEndDate,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.outline),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20, color: colors.primary),
                    const SizedBox(width: 12),
                    Text(dateFormat.format(endDate.value)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: isLoading.value ? null : () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: isLoading.value ? null : createEvent,
          child: isLoading.value
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Create'),
        ),
      ],
    );
  }
}
