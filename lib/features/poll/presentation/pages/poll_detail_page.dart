import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/poll_entity.dart';
import '../../domain/entities/poll_option_entity.dart';
import '../providers/poll_detail_provider.dart';
import '../../../auth/domain/entities/user.dart';

/// Full screen page showing poll details and voters with clean design
class PollDetailPage extends HookConsumerWidget {
  final int conversationId;
  final int pollId;

  const PollDetailPage({super.key, required this.conversationId, required this.pollId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final asyncState = ref.watch(pollDetailProvider(conversationId, pollId));

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Poll Details', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(pollDetailProvider(conversationId, pollId).notifier).refresh();
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

    // Find winning option by highest vote count (not just last option)
    PollOptionEntity? winningOption;
    if (totalVotes > 0 && poll.options.isNotEmpty) {
      winningOption = poll.options.reduce((a, b) => a.voteCount > b.voteCount ? a : b);
      // Only consider it winning if it actually has votes
      if (winningOption.voteCount == 0) {
        winningOption = null;
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Card with Question
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.poll_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            poll.question,
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildStatChip(
                      icon: Icons.people_rounded,
                      label: '$totalVotes ${totalVotes == 1 ? 'voter' : 'voters'}',
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    if (poll.expiresAt != null)
                      _buildStatChip(
                        icon: Icons.access_time_rounded,
                        label: _formatDeadline(poll.expiresAt!),
                        color: Colors.white,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Creator Info Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                // Avatar with image or fallback to initial
                poll.creator.avatarUrl != null && poll.creator.avatarUrl!.isNotEmpty
                    ? CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(poll.creator.avatarUrl!),
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                      )
                    : CircleAvatar(
                        radius: 24,
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                        child: Text(
                          poll.creator.fullName[0].toUpperCase(),
                          style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        poll.creator.fullName,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Created ${_formatTimestamp(poll.createdAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_rounded, size: 14, color: theme.colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        'Creator',
                        style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(width: 12),
                Text('Voting Results', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Options with clean design
          ...poll.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isWinning = winningOption != null && option.id == winningOption.id && totalVotes > 0;
            return _buildOptionDetailCard(context, option, totalVotes, isDark, isWinning, index, theme);
          }),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionDetailCard(
    BuildContext context,
    PollOptionEntity option,
    int totalVotes,
    bool isDark,
    bool isWinning,
    int index,
    ThemeData theme,
  ) {
    final percentage = option.percentage;
    final voters = option.voters;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isWinning
              ? Border.all(color: theme.colorScheme.primary, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(
              color: isWinning
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: isWinning ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Option Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isWinning) ...[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.emoji_events_rounded, color: theme.colorScheme.primary, size: 20),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Text(
                          option.optionText,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${percentage.toStringAsFixed(1)}%',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Animated Progress Bar
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: 0.0, end: percentage / 100),
                        builder: (context, value, child) {
                          return FractionallySizedBox(
                            widthFactor: value,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Vote Count
                  Row(
                    children: [
                      Icon(Icons.how_to_vote_rounded, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        '${option.voteCount} ${option.voteCount == 1 ? 'vote' : 'votes'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Voters Section
            if (voters.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_rounded, size: 18, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Voters',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: voters.map((voter) {
                        return _buildVoterChip(voter, theme.colorScheme.primary, isDark);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, size: 18, color: Colors.grey.shade500),
                      const SizedBox(width: 12),
                      Text(
                        'No votes for this option yet',
                        style: TextStyle(color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoterChip(User voter, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with image or fallback to initial
          voter.avatarUrl != null && voter.avatarUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(voter.avatarUrl!),
                  backgroundColor: color.withValues(alpha: 0.2),
                )
              : CircleAvatar(
                  radius: 14,
                  backgroundColor: color.withValues(alpha: 0.2),
                  child: Text(
                    voter.fullName[0].toUpperCase(),
                    style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
          const SizedBox(width: 8),
          Text(
            voter.fullName,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.error_outline_rounded, size: 64, color: Colors.red),
          ),
          const SizedBox(height: 24),
          const Text('An error occurred', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            '$error',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Convert to local time for display
    final localTime = timestamp.toLocal();
    final now = DateTime.now();
    final diff = now.difference(localTime);

    if (diff.inMinutes < 1) {
      return 'just now';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      return '${localTime.day}/${localTime.month}/${localTime.year}';
    }
  }

  String _formatDeadline(DateTime deadline) {
    // Convert to local time for display
    final localDeadline = deadline.toLocal();
    final now = DateTime.now();

    if (localDeadline.isBefore(now)) {
      return 'Expired';
    }

    final diff = localDeadline.difference(now);
    if (diff.inDays > 0) {
      return '${diff.inDays}d left';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h left';
    } else {
      return '${diff.inMinutes}m left';
    }
  }
}
