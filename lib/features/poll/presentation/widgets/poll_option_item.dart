import 'package:flutter/material.dart';
import '../../domain/entities/poll_option_entity.dart';

/// Individual poll option with progress bar
class PollOptionItem extends StatelessWidget {
  const PollOptionItem({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isVotedByUser,
    required this.showResults,
    required this.allowMultiple,
    required this.canVote,
    this.onTap,
  });

  final PollOptionEntity option;
  final bool isSelected;
  final bool isVotedByUser;
  final bool showResults;
  final bool allowMultiple;
  final bool canVote;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isSelected || isVotedByUser
        ? (isDark ? Colors.grey.shade900 : Colors.grey.shade100)
        : (isDark ? Colors.grey.shade800 : Colors.white);

    final borderColor = isSelected || isVotedByUser
        ? theme.colorScheme.primary
        : (isDark ? Colors.grey.shade700 : Colors.grey.shade300);

    return InkWell(
      onTap: canVote ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Option text with checkbox/radio
            Row(
              children: [
                // Checkbox or Radio icon
                Icon(
                  isVotedByUser
                      ? (allowMultiple ? Icons.check_box : Icons.radio_button_checked)
                      : isSelected
                      ? (allowMultiple ? Icons.check_box_outline_blank : Icons.radio_button_unchecked)
                      : (allowMultiple ? Icons.check_box_outline_blank : Icons.radio_button_unchecked),
                  size: 20,
                  color: isVotedByUser || isSelected ? theme.colorScheme.primary : theme.textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option.optionText,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: isVotedByUser ? FontWeight.w600 : null),
                  ),
                ),
                if (showResults) ...[
                  const SizedBox(width: 8),
                  Text(
                    '${option.percentage.toStringAsFixed(0)}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),

            // Progress bar (only show if results are visible)
            if (showResults) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: option.percentage / 100,
                  minHeight: 6,
                  backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 12, color: theme.textTheme.bodySmall?.color),
                  const SizedBox(width: 4),
                  Text('${option.voteCount} phiếu', style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
