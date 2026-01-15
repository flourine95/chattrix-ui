import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import '../providers/poll_providers.dart';
import '../../domain/entities/poll.dart';
import '../../../poll/presentation/pages/create_poll_page.dart';
import '../../../poll/presentation/pages/poll_detail_page.dart';
import '../../../poll/domain/entities/poll_entity.dart';
import '../../../poll/domain/entities/poll_option_entity.dart';

enum PollFilter { all, active, expired }

class PollsPage extends HookConsumerWidget {
  const PollsPage({super.key, required this.conversationId});
  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final convId = conversationId;

    // Watch polls data
    final pollsAsync = ref.watch(pollsListProvider(convId));
    final pollsNotifier = ref.watch(pollsListProvider(convId).notifier);

    // Filter state
    final selectedFilter = useState(PollFilter.all);

    // Map filter to API status parameter
    String getStatusParam(PollFilter filter) {
      switch (filter) {
        case PollFilter.all:
          return 'all';
        case PollFilter.active:
          return 'active';
        case PollFilter.expired:
          return 'closed';
      }
    }

    // Handle filter change
    void handleFilterChange(PollFilter newFilter) {
      selectedFilter.value = newFilter;
      pollsNotifier.filterByStatus(getStatusParam(newFilter));
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Polls', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePollPage(conversationId: convId)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'All',
                  icon: Icons.poll_rounded,
                  isSelected: selectedFilter.value == PollFilter.all,
                  onTap: () => handleFilterChange(PollFilter.all),
                ),
                _buildFilterChip(
                  context,
                  label: 'Active',
                  icon: Icons.check_circle_outline,
                  isSelected: selectedFilter.value == PollFilter.active,
                  onTap: () => handleFilterChange(PollFilter.active),
                ),
                _buildFilterChip(
                  context,
                  label: 'Expired',
                  icon: Icons.lock_clock,
                  isSelected: selectedFilter.value == PollFilter.expired,
                  onTap: () => handleFilterChange(PollFilter.expired),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: pollsAsync.when(
              data: (polls) {
                if (polls.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.poll_rounded, size: 64, color: theme.colorScheme.primary),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          selectedFilter.value == PollFilter.all
                              ? 'No polls yet'
                              : 'No ${selectedFilter.value.name} polls',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedFilter.value == PollFilter.all
                              ? 'Create your first poll using the button above'
                              : 'Try selecting a different filter',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: polls.length,
                        itemBuilder: (context, index) {
                          final poll = polls[index];
                          return _buildPollCard(context, ref, poll, theme, isDark);
                        },
                      ),
                    ),
                    // Load More button
                    if (pollsNotifier.hasNextPage)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton.icon(
                          onPressed: () => pollsNotifier.loadMore(status: getStatusParam(selectedFilter.value)),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Load More'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.error_outline_rounded, size: 64, color: Colors.red),
                    ),
                    const SizedBox(height: 24),
                    const Text('Error loading polls', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        error.toString(),
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => ref.invalidate(pollsListProvider(convId)),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                  color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPollCard(BuildContext context, WidgetRef ref, Poll poll, ThemeData theme, bool isDark) {
    final isActive = poll.active && !poll.closed && !poll.expired;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PollDetailPage(
                  conversationId: poll.conversationId,
                  pollId: poll.id,
                  initialPoll: _convertPollToPollEntity(poll), // Convert and pass cached data
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    // Creator avatar
                    poll.creator.avatarUrl != null && poll.creator.avatarUrl!.isNotEmpty
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(poll.creator.avatarUrl!),
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                            child: Text(
                              poll.creator.fullName[0].toUpperCase(),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poll.creator.fullName,
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            _formatDateTime(poll.createdAt),
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Status badge
                    if (!isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock_outline, size: 14, color: Colors.red.shade700),
                            const SizedBox(width: 4),
                            Text(
                              poll.closed ? 'Closed' : 'Expired',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.red.shade700),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Question
                Text(
                  poll.question,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Quick stats
                Row(
                  children: [
                    _buildStatChip(
                      icon: Icons.people_rounded,
                      label: '${poll.totalVoters} ${poll.totalVoters == 1 ? 'voter' : 'voters'}',
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    _buildStatChip(
                      icon: Icons.how_to_vote_rounded,
                      label: '${poll.options.length} options',
                      color: theme.colorScheme.primary,
                    ),
                    if (poll.allowMultipleVotes) ...[
                      const SizedBox(width: 8),
                      _buildStatChip(
                        icon: Icons.check_box_rounded,
                        label: 'Multiple',
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ],
                ),

                if (poll.expiresAt != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        _formatExpiry(poll.expiresAt!),
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  String _formatExpiry(DateTime expiresAt) {
    final now = DateTime.now();
    final difference = expiresAt.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Expiring soon';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays > 7) {
      return DateFormat('MMM dd, yyyy').format(dateTime);
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Convert Poll (chat feature) to PollEntity (poll feature)
  PollEntity _convertPollToPollEntity(Poll poll) {
    return PollEntity(
      id: poll.id,
      question: poll.question,
      conversationId: poll.conversationId,
      creator: poll.creator,
      allowMultipleVotes: poll.allowMultipleVotes,
      expiresAt: poll.expiresAt,
      isClosed: poll.closed,
      isExpired: poll.expired,
      isActive: poll.active,
      createdAt: poll.createdAt,
      totalVoters: poll.totalVoters,
      options: poll.options.map((opt) => PollOptionEntity(
        id: opt.id,
        optionText: opt.optionText,
        optionOrder: opt.optionOrder,
        voteCount: opt.voteCount,
        percentage: opt.percentage,
        voters: opt.voters,
      )).toList(),
      currentUserVotedOptionIds: poll.currentUserVotedOptionIds,
    );
  }
}
