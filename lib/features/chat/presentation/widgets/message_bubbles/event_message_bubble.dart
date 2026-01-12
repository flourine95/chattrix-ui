import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/events_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// Event Message Bubble - displays event information in chat
class EventMessageBubble extends HookConsumerWidget {
  final Message message;
  final int currentUserId;

  const EventMessageBubble({super.key, required this.message, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = message.eventData;

    if (event == null) {
      return const SizedBox.shrink();
    }

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      constraints: const BoxConstraints(maxWidth: 320),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.primary.withValues(alpha: 0.3), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event icon and title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.event, color: colors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (event.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            event.description!,
                            style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // Date and time
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: colors.onSurface.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Text(
                    dateFormat.format(event.startTime),
                    style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, size: 14, color: colors.onSurface.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${timeFormat.format(event.startTime)} - ${timeFormat.format(event.endTime)}',
                      style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              if (event.location != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: colors.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        event.location!,
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 12),

              // RSVP status chips - Make them tappable
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _RsvpChip(
                    icon: Icons.check_circle,
                    label: '${event.goingCount}',
                    color: Colors.green,
                    isSelected: event.currentUserRsvpStatus == 'GOING',
                    onTap: () => _handleRsvp(context, ref, event.id, 'GOING'),
                  ),
                  _RsvpChip(
                    icon: Icons.help_outline,
                    label: '${event.maybeCount}',
                    color: Colors.orange,
                    isSelected: event.currentUserRsvpStatus == 'MAYBE',
                    onTap: () => _handleRsvp(context, ref, event.id, 'MAYBE'),
                  ),
                  _RsvpChip(
                    icon: Icons.cancel,
                    label: '${event.notGoingCount}',
                    color: Colors.red,
                    isSelected: event.currentUserRsvpStatus == 'NOT_GOING',
                    onTap: () => _handleRsvp(context, ref, event.id, 'NOT_GOING'),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // View details button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showEventDetailsBottomSheet(context, ref, event);
                  },
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('View Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(color: colors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRsvp(BuildContext context, WidgetRef ref, int eventId, String status) async {
    try {
      final notifier = ref.read(eventsListProvider(message.conversationId.toString()).notifier);
      await notifier.rsvpEvent(eventId: eventId, status: status);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                status == 'GOING'
                    ? Icons.check_circle
                    : status == 'MAYBE'
                    ? Icons.help_outline
                    : Icons.cancel,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text('RSVP updated to ${status.toLowerCase()}'),
            ],
          ),
          backgroundColor: Colors.grey.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Text('Failed to update RSVP: $e'),
            ],
          ),
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showEventDetailsBottomSheet(BuildContext context, WidgetRef ref, dynamic event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EventDetailsBottomSheet(event: event, message: message, currentUserId: currentUserId),
    );
  }
}

class _EventDetailsBottomSheet extends HookConsumerWidget {
  final dynamic event;
  final Message message;
  final int currentUserId;

  const _EventDetailsBottomSheet({required this.event, required this.message, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('EEEE, MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    final isCreator = event.creator.id == currentUserId;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.event, color: colors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        'Created by ${event.creator.fullName ?? event.creator.username}',
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                ),
                if (isCreator)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'delete') {
                        _handleDelete(context, ref);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete Event', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  if (event.description != null) ...[
                    Text('Description', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(event.description!, style: textTheme.bodyMedium),
                    const SizedBox(height: 16),
                  ],

                  // Date & Time
                  _InfoRow(icon: Icons.calendar_today, label: 'Date', value: dateFormat.format(event.startTime)),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: '${timeFormat.format(event.startTime)} - ${timeFormat.format(event.endTime)}',
                  ),

                  // Location
                  if (event.location != null) ...[
                    const SizedBox(height: 12),
                    _InfoRow(icon: Icons.location_on, label: 'Location', value: event.location!),
                  ],

                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // RSVP Section
                  Text('RSVP Status', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _RsvpStatusCard(
                          icon: Icons.check_circle,
                          label: 'Going',
                          count: event.goingCount,
                          color: Colors.green,
                          isSelected: event.currentUserRsvpStatus == 'GOING',
                          onTap: () => _handleRsvp(context, ref, event.id, 'GOING'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _RsvpStatusCard(
                          icon: Icons.help_outline,
                          label: 'Maybe',
                          count: event.maybeCount,
                          color: Colors.orange,
                          isSelected: event.currentUserRsvpStatus == 'MAYBE',
                          onTap: () => _handleRsvp(context, ref, event.id, 'MAYBE'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _RsvpStatusCard(
                          icon: Icons.cancel,
                          label: 'Not Going',
                          count: event.notGoingCount,
                          color: Colors.red,
                          isSelected: event.currentUserRsvpStatus == 'NOT_GOING',
                          onTap: () => _handleRsvp(context, ref, event.id, 'NOT_GOING'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRsvp(BuildContext context, WidgetRef ref, int eventId, String status) async {
    try {
      final notifier = ref.read(eventsListProvider(message.conversationId.toString()).notifier);
      await notifier.rsvpEvent(eventId: eventId, status: status);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                status == 'GOING'
                    ? Icons.check_circle
                    : status == 'MAYBE'
                    ? Icons.help_outline
                    : Icons.cancel,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text('RSVP updated to ${status.toLowerCase().replaceAll('_', ' ')}'),
            ],
          ),
          backgroundColor: Colors.grey.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Text('Failed to update RSVP: $e'),
            ],
          ),
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final notifier = ref.read(eventsListProvider(message.conversationId.toString()).notifier);
      await notifier.deleteEvent(event.id);

      if (!context.mounted) return;

      Navigator.pop(context); // Close bottom sheet

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Event deleted successfully'),
            ],
          ),
          backgroundColor: Colors.grey.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Text('Failed to delete event: $e'),
            ],
          ),
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

class _RsvpStatusCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _RsvpStatusCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          border: Border.all(color: isSelected ? color : Colors.grey.withValues(alpha: 0.3), width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 24),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? color : Colors.grey),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? color : Colors.grey),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
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
