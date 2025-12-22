import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Scheduled message bubble - centered, no bubble, similar to Zalo
/// Shows icon + time + message content (no container)
class ScheduledMessageBubble extends StatelessWidget {
  const ScheduledMessageBubble({super.key, required this.message, required this.isMe, this.isHighlighted = false});

  final Message message;
  final bool isMe;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Format scheduled time
    final scheduledTime = message.scheduledTime ?? message.sentAt ?? message.createdAt;
    final timeText = DateFormat('HH:mm').format(scheduledTime);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: isHighlighted ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isHighlighted
            ? (isDark ? Colors.blue.withValues(alpha: 0.2) : Colors.blue.withValues(alpha: 0.1))
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          children: [
            // Icon + time indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule_rounded, size: 12, color: isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  'Scheduled message • $timeText',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Message content - NO CONTAINER, just bold text
            Text(
              message.content,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
