import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../domain/entities/poll_entity.dart';
import 'poll_option_item.dart';
import 'poll_header.dart';

/// Main poll card with options and voting
///
/// Displays poll question, options, and voting controls
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

    // Initialize selected options from current user votes
    useEffect(() {
      selectedOptions.value = poll.currentUserVotedOptionIds.toSet();
      return null;
    }, [poll.id]);

    final isCreator = poll.creator.id == currentUserId;
    final canVote = poll.canVote && !isVoting.value;
    final hasVoted = poll.hasVoted;

    void handleOptionTap(int optionId) {
      if (!canVote) return;

      if (poll.allowMultipleVotes) {
        // Multiple choice - toggle selection
        final newSelection = Set<int>.from(selectedOptions.value);
        if (newSelection.contains(optionId)) {
          newSelection.remove(optionId);
        } else {
          newSelection.add(optionId);
        }
        selectedOptions.value = newSelection;
      } else {
        // Single choice - replace selection
        selectedOptions.value = {optionId};
      }
    }

    Future<void> handleVote() async {
      if (selectedOptions.value.isEmpty || isVoting.value) return;

      isVoting.value = true;
      try {
        await onVote?.call(selectedOptions.value.toList());
      } finally {
        isVoting.value = false;
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
          // Header
          PollHeader(poll: poll, isCreator: isCreator, onClose: onClose, onDelete: onDelete),

          const Divider(height: 1),

          // Question
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(poll.question, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
          ),

          // Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: poll.options.map((option) {
                final isSelected = selectedOptions.value.contains(option.id);
                final isVotedByUser = poll.currentUserVotedOptionIds.contains(option.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PollOptionItem(
                    option: option,
                    isSelected: isSelected,
                    isVotedByUser: isVotedByUser,
                    showResults: hasVoted || !poll.isActive,
                    allowMultiple: poll.allowMultipleVotes,
                    canVote: canVote,
                    onTap: () => handleOptionTap(option.id),
                  ),
                );
              }).toList(),
            ),
          ),

          // Vote button (only show if can vote and has selection)
          if (canVote && selectedOptions.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: isVoting.value ? null : handleVote,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 44)),
                child: isVoting.value
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Bỏ phiếu'),
              ),
            ),

          // Action buttons (for voted polls)
          if (hasVoted && poll.isActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        selectedOptions.value = {};
                      },
                      child: const Text('Đổi vote'),
                    ),
                  ),
                  if (onViewDetail != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(onPressed: onViewDetail, child: const Text('Xem chi tiết')),
                    ),
                  ],
                ],
              ),
            ),

          // View detail button (for closed polls)
          if (!poll.isActive && onViewDetail != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: OutlinedButton(onPressed: onViewDetail, child: const Text('Xem chi tiết')),
            ),

          // Footer info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Icon(Icons.people_outline, size: 14, color: theme.textTheme.bodySmall?.color),
                const SizedBox(width: 4),
                Text('${poll.totalVoters} người', style: theme.textTheme.bodySmall),
                if (poll.expiresAt != null) ...[
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, size: 14, color: theme.textTheme.bodySmall?.color),
                  const SizedBox(width: 4),
                  Text(_formatExpiry(poll.expiresAt!), style: theme.textTheme.bodySmall),
                ],
                if (!poll.isActive) ...[
                  const Spacer(),
                  Icon(Icons.lock_outline, size: 14, color: theme.textTheme.bodySmall?.color),
                  const SizedBox(width: 4),
                  Text(poll.isClosed ? 'Đã đóng' : 'Hết hạn', style: theme.textTheme.bodySmall),
                ],
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
      return 'Đã hết hạn';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút';
    } else {
      return 'Sắp hết hạn';
    }
  }
}
