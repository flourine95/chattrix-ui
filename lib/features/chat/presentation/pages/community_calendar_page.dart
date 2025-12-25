import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/event_providers.dart';
import '../../domain/entities/event.dart';
import 'event_form_page.dart';

class CommunityCalendarPage extends HookConsumerWidget {
  const CommunityCalendarPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Parse conversationId to int
    final convId = int.tryParse(conversationId) ?? 0;

    // Watch events data
    final eventsAsync = ref.watch(allEventsProvider(convId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Calendar'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _showCreateEventDialog(context, ref, convId)),
        ],
      ),
      body: eventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text('No events scheduled', style: textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showCreateEventDialog(context, ref, convId),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Event'),
                  ),
                ],
              ),
            );
          }

          // Sort events by start time
          final sortedEvents = List<Event>.from(events)..sort((a, b) => a.startTime.compareTo(b.startTime));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedEvents.length,
            itemBuilder: (context, index) {
              final event = sortedEvents[index];
              return _buildEventCard(context, ref, event, colors, textTheme);
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
              Text('Error loading events', style: textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text(error.toString(), style: textTheme.bodySmall, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => ref.invalidate(allEventsProvider(convId)),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, WidgetRef ref, Event event, ColorScheme colors, TextTheme textTheme) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final now = DateTime.now();
    final isPast = event.endTime.isBefore(now);
    final isToday =
        event.startTime.year == now.year && event.startTime.month == now.month && event.startTime.day == now.day;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showEventDetails(context, ref, event),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isPast
                          ? colors.surfaceContainerHighest
                          : isToday
                          ? colors.primaryContainer
                          : colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.event,
                      color: isPast
                          ? colors.onSurface.withValues(alpha: 0.6)
                          : isToday
                          ? colors.primary
                          : colors.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: isPast ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14, color: colors.onSurface.withValues(alpha: 0.6)),
                            const SizedBox(width: 4),
                            Text(
                              '${dateFormat.format(event.startTime)} • ${timeFormat.format(event.startTime)}',
                              style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showEventOptions(context, ref, event),
                  ),
                ],
              ),
              if (event.description != null && event.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(event.description!, style: textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
              if (event.location != null && event.location!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location!,
                        style: textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              // RSVP Status
              Row(
                children: [
                  _buildRsvpChip(context, 'Going', event.goingCount, Colors.green, colors),
                  const SizedBox(width: 8),
                  _buildRsvpChip(context, 'Maybe', event.maybeCount, Colors.orange, colors),
                  const SizedBox(width: 8),
                  _buildRsvpChip(context, 'Not Going', event.notGoingCount, Colors.red, colors),
                  const Spacer(),
                  if (event.currentUserRsvpStatus != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getRsvpColor(event.currentUserRsvpStatus!).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        event.currentUserRsvpStatus!,
                        style: textTheme.bodySmall?.copyWith(
                          color: _getRsvpColor(event.currentUserRsvpStatus!),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRsvpChip(BuildContext context, String label, int count, Color color, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            label == 'Going'
                ? Icons.check_circle
                : label == 'Maybe'
                ? Icons.help
                : Icons.cancel,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getRsvpColor(String status) {
    switch (status.toUpperCase()) {
      case 'GOING':
        return Colors.green;
      case 'MAYBE':
        return Colors.orange;
      case 'NOT_GOING':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showEventDetails(BuildContext context, WidgetRef ref, Event event) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Text(
                event.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Description
              if (event.description != null && event.description!.isNotEmpty) ...[
                Text(event.description!),
                const SizedBox(height: 16),
              ],

              // Details
              _buildDetailRow(
                Icons.access_time,
                'Start',
                '${dateFormat.format(event.startTime)} at ${timeFormat.format(event.startTime)}',
              ),
              _buildDetailRow(
                Icons.access_time,
                'End',
                '${dateFormat.format(event.endTime)} at ${timeFormat.format(event.endTime)}',
              ),
              if (event.location != null && event.location!.isNotEmpty)
                _buildDetailRow(Icons.location_on, 'Location', event.location!),
              _buildDetailRow(Icons.person, 'Created by', event.creator.fullName),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // RSVP Section
              Text(
                'Your Response',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRsvpButton(context, ref, event, 'GOING', Icons.check_circle, Colors.green),
                  _buildRsvpButton(context, ref, event, 'MAYBE', Icons.help, Colors.orange),
                  _buildRsvpButton(context, ref, event, 'NOT_GOING', Icons.cancel, Colors.red),
                ],
              ),

              const SizedBox(height: 24),

              // RSVP Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRsvpStat(context, 'Going', event.goingCount, Colors.green),
                  _buildRsvpStat(context, 'Maybe', event.maybeCount, Colors.orange),
                  _buildRsvpStat(context, 'Not Going', event.notGoingCount, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildRsvpButton(BuildContext context, WidgetRef ref, Event event, String status, IconData icon, Color color) {
    final isSelected = event.currentUserRsvpStatus?.toUpperCase() == status;

    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        await _handleRsvp(context, ref, event, status);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              status.replaceAll('_', ' '),
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRsvpStat(BuildContext context, String label, int count, Color color) {
    return Column(
      children: [
        Text(
          '$count',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }

  Future<void> _handleRsvp(BuildContext context, WidgetRef ref, Event event, String status) async {
    try {
      final useCase = ref.read(rsvpEventUseCaseProvider);
      final result = await useCase(conversationId: event.conversationId, eventId: event.id, response: status);

      result.fold(
        (failure) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to RSVP: ${failure.message}')));
          }
        },
        (_) {
          ref.invalidate(allEventsProvider(event.conversationId));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('RSVP updated successfully')));
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showEventOptions(BuildContext context, WidgetRef ref, Event event) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Event'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventFormPage(conversationId: event.conversationId, event: event),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Event', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, ref, event);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event?'),
        content: Text('Are you sure you want to delete "${event.title}"? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteEvent(context, ref, event);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteEvent(BuildContext context, WidgetRef ref, Event event) async {
    try {
      final useCase = ref.read(deleteEventUseCaseProvider);
      final result = await useCase(conversationId: event.conversationId, eventId: event.id);

      result.fold(
        (failure) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Failed to delete event: ${failure.message}')));
          }
        },
        (_) {
          ref.invalidate(allEventsProvider(event.conversationId));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event deleted successfully')));
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showCreateEventDialog(BuildContext context, WidgetRef ref, int conversationId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventFormPage(conversationId: conversationId)));
  }
}
