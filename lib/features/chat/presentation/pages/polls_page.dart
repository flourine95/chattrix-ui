import 'package:flutter/material.dart';

class PollsPage extends StatefulWidget {
  const PollsPage({super.key, required this.conversationId});
  final String conversationId;

  @override
  State<PollsPage> createState() => _PollsPageState();
}

class _PollsPageState extends State<PollsPage> {
  final List<Map<String, dynamic>> _polls = [
    {
      'question': 'What time works best for the team meeting?',
      'options': ['9:00 AM', '2:00 PM', '4:00 PM'],
      'votes': [5, 12, 3],
      'userVoted': 1,
      'createdBy': 'John Doe',
      'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'question': 'Which features should we prioritize?',
      'options': ['Dark Mode', 'Voice Messages', 'File Sharing', 'Video Calls'],
      'votes': [18, 15, 22, 20],
      'userVoted': null,
      'createdBy': 'Jane Smith',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Polls'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Create poll feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _polls.length,
        itemBuilder: (context, index) {
          final poll = _polls[index];
          final totalVotes = (poll['votes'] as List<int>).reduce((a, b) => a + b);
          final hasVoted = poll['userVoted'] != null;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: colors.primaryContainer,
                        child: Icon(Icons.poll, size: 16, color: colors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(poll['createdBy'], style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                            Text(_getTimeAgo(poll['createdAt']), style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(poll['question'], style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...List.generate((poll['options'] as List).length, (optIndex) {
                    final option = poll['options'][optIndex];
                    final votes = poll['votes'][optIndex];
                    final percentage = totalVotes > 0 ? (votes / totalVotes * 100).round() : 0;
                    final isSelected = poll['userVoted'] == optIndex;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: hasVoted ? null : () {
                          setState(() {
                            poll['userVoted'] = optIndex;
                            poll['votes'][optIndex]++;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? colors.primaryContainer : colors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: isSelected ? colors.primary : Colors.transparent, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(option)),
                                  if (hasVoted) Text('$percentage%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              if (hasVoted) ...[
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: percentage / 100,
                                  backgroundColor: colors.surfaceContainerHigh,
                                  color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.3),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  Text('$totalVotes votes', style: textTheme.bodySmall),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}
