import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunityCalendarPage extends StatefulWidget {
  const CommunityCalendarPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<CommunityCalendarPage> createState() => _CommunityCalendarPageState();
}

class _CommunityCalendarPageState extends State<CommunityCalendarPage> {
  final List<CalendarEvent> _events = [
    CalendarEvent(
      id: '1',
      title: 'Team Meeting',
      description: 'Discuss Q1 goals and objectives',
      startTime: DateTime.now().add(const Duration(days: 1, hours: 14)),
      endTime: DateTime.now().add(const Duration(days: 1, hours: 15)),
      location: 'Conference Room A',
      createdBy: 'John Doe',
    ),
    CalendarEvent(
      id: '2',
      title: 'Project Deadline',
      description: 'Submit final deliverables',
      startTime: DateTime.now().add(const Duration(days: 3)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
      location: 'Online',
      createdBy: 'Jane Smith',
    ),
    CalendarEvent(
      id: '3',
      title: 'Team Lunch',
      description: 'Monthly team bonding lunch',
      startTime: DateTime.now().add(const Duration(days: 7, hours: 12)),
      endTime: DateTime.now().add(const Duration(days: 7, hours: 13)),
      location: 'Italian Restaurant',
      createdBy: 'Admin',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateEventDialog(context),
          ),
        ],
      ),
      body: _events.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text('No events scheduled', style: textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => _showCreateEventDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Event'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return _buildEventCard(event, colors, textTheme);
              },
            ),
    );
  }

  Widget _buildEventCard(CalendarEvent event, ColorScheme colors, TextTheme textTheme) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showEventDetails(event),
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
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.event, color: colors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        Text(
                          '${dateFormat.format(event.startTime)} • ${timeFormat.format(event.startTime)}',
                          style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showEventOptions(event),
                  ),
                ],
              ),
              if (event.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(event.description, style: textTheme.bodyMedium),
              ],
              if (event.location.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
                    const SizedBox(width: 4),
                    Text(event.location, style: textTheme.bodySmall),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetails(CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.access_time, 'Time', DateFormat('MMM dd, h:mm a').format(event.startTime)),
            _buildDetailRow(Icons.location_on, 'Location', event.location),
            _buildDetailRow(Icons.person, 'Created by', event.createdBy),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showEventOptions(CalendarEvent event) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Event'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement edit
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Event', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _events.remove(event));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateEventDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final locationController = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay selectedTime = const TimeOfDay(hour: 14, minute: 0);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Event'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
              TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              setState(() {
                _events.add(CalendarEvent(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descController.text,
                  startTime: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute),
                  endTime: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour + 1, selectedTime.minute),
                  location: locationController.text,
                  createdBy: 'You',
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String createdBy;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.createdBy,
  });
}

