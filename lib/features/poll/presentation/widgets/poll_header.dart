import 'package:flutter/material.dart';
import '../../domain/entities/poll_entity.dart';

/// Poll header with creator info and actions
class PollHeader extends StatelessWidget {
  const PollHeader({super.key, required this.poll, required this.isCreator, this.onClose, this.onDelete});

  final PollEntity poll;
  final bool isCreator;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Poll icon
          Icon(Icons.poll_outlined, size: 20, color: theme.textTheme.bodySmall?.color),
          const SizedBox(width: 8),
          Text('POLL', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
          if (poll.allowMultipleVotes) ...[
            const SizedBox(width: 4),
            Text('• Chọn nhiều', style: theme.textTheme.labelSmall),
          ],
          if (!poll.isActive) ...[
            const SizedBox(width: 4),
            Icon(Icons.lock_outline, size: 14, color: theme.textTheme.bodySmall?.color),
            const SizedBox(width: 2),
            Text(poll.isClosed ? 'ĐÃ ĐÓNG' : 'HẾT HẠN', style: theme.textTheme.labelSmall),
          ],
          const Spacer(),
          // Creator actions menu
          if (isCreator && (onClose != null || onDelete != null))
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, size: 20),
              onSelected: (value) {
                if (value == 'close' && onClose != null) {
                  onClose!();
                } else if (value == 'delete' && onDelete != null) {
                  onDelete!();
                }
              },
              itemBuilder: (context) => [
                if (poll.isActive && onClose != null)
                  const PopupMenuItem(
                    value: 'close',
                    child: Row(children: [Icon(Icons.lock_outline, size: 18), SizedBox(width: 12), Text('Đóng poll')]),
                  ),
                if (onDelete != null)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(children: [Icon(Icons.delete_outline, size: 18), SizedBox(width: 12), Text('Xóa poll')]),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
