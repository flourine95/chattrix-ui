import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/poll_entity.dart';
import '../../domain/entities/poll_option_entity.dart';
import '../providers/poll_detail_provider.dart';

/// Full screen page showing poll details and voters
class PollDetailPage extends HookConsumerWidget {
  final int pollId;

  const PollDetailPage({super.key, required this.pollId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final asyncState = ref.watch(pollDetailProvider(pollId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết Poll'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(pollDetailProvider(pollId).notifier).refresh();
            },
          ),
        ],
      ),
      body: asyncState.when(
        data: (poll) => _buildContent(context, poll, isDark),
        error: (error, _) => _buildError(context, error),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PollEntity poll, bool isDark) {
    final theme = Theme.of(context);
    final totalVotes = poll.totalVoters;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          Text('❓ ${poll.question}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),

          // Creator and info
          Row(
            children: [
              const Icon(Icons.person, size: 16),
              const SizedBox(width: 4),
              Text(poll.creator.fullName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Text(
                '• ${_formatTimestamp(poll.createdAt)}',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Stats
          Row(
            children: [
              const Icon(Icons.people, size: 16),
              const SizedBox(width: 4),
              Text('$totalVotes người', style: theme.textTheme.bodySmall),
              if (poll.expiresAt != null) ...[
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(_formatDeadline(poll.expiresAt!), style: theme.textTheme.bodySmall),
              ],
            ],
          ),
          const SizedBox(height: 24),

          const Divider(),
          const SizedBox(height: 16),

          // Options with voters
          ...poll.options.map((option) {
            return _buildOptionDetail(context, option, totalVotes, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildOptionDetail(BuildContext context, PollOptionEntity option, int totalVotes, bool isDark) {
    final theme = Theme.of(context);
    final percentage = totalVotes > 0 ? (option.voteCount / totalVotes * 100) : 0.0;
    final voters = option.voters;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Option header
        Row(
          children: [
            Expanded(
              child: Text(option.optionText, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 6,
            backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(isDark ? Colors.white : Colors.black),
          ),
        ),
        const SizedBox(height: 8),

        // Vote count
        Text('${option.voteCount} phiếu', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
        const SizedBox(height: 12),

        // Voters list
        if (voters.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Chưa có ai bỏ phiếu',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600, fontStyle: FontStyle.italic),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: voters.asMap().entries.map((entry) {
                final index = entry.key;
                final voter = entry.value;
                final isLast = index == voters.length - 1;

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                        child: Text(
                          voter.fullName[0].toUpperCase(),
                          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        voter.fullName,
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '@${voter.username}',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                    if (!isLast)
                      Divider(height: 1, indent: 72, color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                  ],
                );
              }).toList(),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Lỗi: $error', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) {
      return 'vừa xong';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes} phút trước';
    } else if (diff.inDays < 1) {
      return '${diff.inHours} giờ trước';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ngày trước';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    if (deadline.isBefore(now)) {
      return 'Đã hết hạn';
    }

    return '${deadline.day}/${deadline.month}/${deadline.year} ${deadline.hour}:${deadline.minute.toString().padLeft(2, '0')}';
  }
}
