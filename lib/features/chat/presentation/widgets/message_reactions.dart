import 'dart:convert';
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

  final String? reactions; // JSON string: {"👍": [1, 2, 3], "❤️": [4, 5]}
  final int currentUserId;
  final Function(String emoji) onReactionTap;
  final VoidCallback onAddReaction;

  @override
  Widget build(BuildContext context) {
    if (reactions == null || reactions!.isEmpty) {
      return const SizedBox.shrink();
    }

    final reactionsMap = _parseReactions(reactions!);
    if (reactionsMap.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          ...reactionsMap.entries.map((entry) {
            final emoji = entry.key;
            final userIds = entry.value;
            final hasReacted = userIds.contains(currentUserId);

            return GestureDetector(
              onTap: () => onReactionTap(emoji),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: hasReacted
                      ? colors.primaryContainer
                      : colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasReacted
                        ? colors.primary
                        : colors.outlineVariant,
                    width: hasReacted ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${userIds.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: hasReacted ? FontWeight.w600 : FontWeight.normal,
                        color: hasReacted
                            ? colors.onPrimaryContainer
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // Add reaction button
          GestureDetector(
            onTap: onAddReaction,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.outlineVariant,
                ),
              ),
              child: const Icon(
                Icons.add_reaction_outlined,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<int>> _parseReactions(String reactionsJson) {
    try {
      final decoded = jsonDecode(reactionsJson) as Map<String, dynamic>;
      final result = <String, List<int>>{};
      
      decoded.forEach((emoji, userIds) {
        if (userIds is List) {
          result[emoji] = userIds.cast<int>();
        }
      });
      
      return result;
    } catch (e) {
      return {};
    }
  }
}

/// Bottom sheet to pick emoji reactions
class ReactionPickerBottomSheet extends StatelessWidget {
  const ReactionPickerBottomSheet({
    super.key,
    required this.onEmojiSelected,
  });

  final Function(String emoji) onEmojiSelected;

  static const List<String> _commonEmojis = [
    '👍', '❤️', '😂', '😮', '😢', '😡',
    '🎉', '🔥', '👏', '💯', '✅', '❌',
    '🙏', '💪', '👀', '🤔', '😊', '😎',
    '🥳', '😍', '🤗', '😴', '🤯', '🙌',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            'React to message',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          // Emoji grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: _commonEmojis.length,
            itemBuilder: (context, index) {
              final emoji = _commonEmojis[index];
              return GestureDetector(
                onTap: () {
                  onEmojiSelected(emoji);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Show reaction picker bottom sheet
Future<void> showReactionPicker(
  BuildContext context,
  Function(String emoji) onEmojiSelected,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ReactionPickerBottomSheet(
      onEmojiSelected: onEmojiSelected,
    ),
  );
}

