import 'package:flutter/material.dart';

/// Widget to display reactions on a message
class MessageReactions extends StatelessWidget {
  const MessageReactions({
    super.key,
    required this.reactions,
    required this.currentUserId,
    required this.onReactionTap,
    required this.onAddReaction,
  });

  final Map<String, List<int>>? reactions; // Map of emoji to user IDs: {"👍": [1, 2, 3], "❤️": [4, 5]}
  final int currentUserId;
  final Function(String emoji) onReactionTap;
  final VoidCallback onAddReaction;

  @override
  Widget build(BuildContext context) {
    if (reactions == null || reactions!.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          ...reactions!.entries.map((entry) {
            final emoji = entry.key;
            final userIds = entry.value;
            final hasReacted = userIds.contains(currentUserId);

            return GestureDetector(
              onTap: () => onReactionTap(emoji),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: hasReacted 
                      ? colors.primaryContainer.withValues(alpha: 0.8)
                      : colors.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: hasReacted 
                        ? colors.primary.withValues(alpha: 0.6)
                        : colors.outlineVariant.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(
                        fontSize: 14, // Smaller emoji
                        fontFamily: 'NotoColorEmoji',
                        fontFamilyFallback: ['Segoe UI Emoji', 'Apple Color Emoji'],
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${userIds.length}',
                      style: TextStyle(
                        fontSize: 11, // Smaller count
                        fontWeight: hasReacted ? FontWeight.w600 : FontWeight.w500,
                        color: hasReacted ? colors.onPrimaryContainer : colors.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // Add reaction button - smaller and more subtle
          GestureDetector(
            onTap: onAddReaction,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colors.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.add_reaction_outlined,
                size: 14, // Smaller icon
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
