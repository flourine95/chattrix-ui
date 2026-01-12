import 'package:chattrix_ui/features/poll/domain/entities/poll_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'poll_header.dart';
import 'poll_option_item.dart';

class PollCard extends HookConsumerWidget {
  const PollCard({
    super.key,
    required this.poll,
    required this.currentUserId,
    this.onVote,
    this.onViewDetail,
    this.onClose,
    this.onDelete,
  });

  final PollEntity poll;
  final int currentUserId;
  final Function(List<int> optionIds)? onVote;
  final VoidCallback? onViewDetail;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedOptions = useState<Set<int>>({});
    final isVoting = useState(false);

    useEffect(() {
      selectedOptions.value = poll.currentUserVotedOptionIds.toSet();
      return null;
    }, [poll.currentUserVotedOptionIds.join(','), poll.id, poll.totalVoters]);

    final isCreator = poll.creator.id == currentUserId;
    final canVote = poll.canVote && !isVoting.value;
    final hasVoted = poll.hasVoted;

    void handleOptionTap(int optionId) {
      if (!canVote && !hasVoted) return;

      if (poll.allowMultipleVotes) {
        final newSelection = Set<int>.from(selectedOptions.value);
        if (newSelection.contains(optionId)) {
          newSelection.remove(optionId);
        } else {
          newSelection.add(optionId);
        }
        selectedOptions.value = newSelection;
      } else {
        if (selectedOptions.value.contains(optionId)) {
          selectedOptions.value = {};
        } else {
          selectedOptions.value = {optionId};
        }
      }
    }

    Future<void> handleVote() async {
      if (selectedOptions.value.isEmpty || isVoting.value) return;

      isVoting.value = true;
      try {
        await onVote?.call(selectedOptions.value.toList());
      } catch (e) {
        debugPrint('❌ [PollCard] Vote failed: $e');
        if (context.mounted) {
          selectedOptions.value = poll.currentUserVotedOptionIds.toSet();
        }
      } finally {
        if (context.mounted) {
          isVoting.value = false;
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PollHeader(poll: poll, isCreator: isCreator, onClose: onClose, onDelete: onDelete),

          const Divider(height: 1),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(poll.question, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: poll.options.map((option) {
                final isSelected = selectedOptions.value.contains(option.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PollOptionItem(
                    option: option,
                    isSelected: isSelected,
                    showResults: hasVoted || !poll.isActive,
                    allowMultiple: poll.allowMultipleVotes,
                    canVote: canVote,
                    onTap: () => handleOptionTap(option.id),
                  ),
                );
              }).toList(),
            ),
          ),

          if ((canVote && selectedOptions.value.isNotEmpty) ||
              (hasVoted && selectedOptions.value != poll.currentUserVotedOptionIds.toSet()))
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: isVoting.value ? null : handleVote,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: isVoting.value ? 0 : 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: isVoting.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.how_to_vote, size: 20),
                label: Text(
                  isVoting.value
                      ? 'Voting...'
                      : hasVoted
                      ? 'Change Vote'
                      : 'Vote',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

          if (hasVoted && poll.isActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  if (onViewDetail != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onViewDetail,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: Icon(Icons.bar_chart, size: 18, color: theme.colorScheme.primary),
                        label: Text('Details', style: TextStyle(color: theme.colorScheme.primary)),
                      ),
                    ),
                ],
              ),
            ),

          if (!poll.isActive && onViewDetail != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: OutlinedButton.icon(
                onPressed: onViewDetail,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(Icons.bar_chart, size: 18, color: theme.colorScheme.primary),
                label: Text('View Details', style: TextStyle(color: theme.colorScheme.primary)),
              ),
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 16,
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${poll.totalVoters} ${poll.totalVoters == 1 ? 'voter' : 'voters'}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                if (poll.expiresAt != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatExpiry(poll.expiresAt!),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                if (!poll.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, size: 14, color: Colors.red.shade700),
                        const SizedBox(width: 4),
                        Text(
                          poll.isClosed ? 'Closed' : 'Expired',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.red.shade700),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
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
}
