import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:flutter/material.dart';

/// Banner widget to show when there's an active call in the conversation
class ActiveCallBanner extends StatelessWidget {
  final CallInfo callInfo;
  final VoidCallback onJoinPressed;

  const ActiveCallBanner({super.key, required this.callInfo, required this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final participantsCount = callInfo.participants.where((p) => p.status.name == 'JOINED').length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        border: Border(bottom: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: Row(
        children: [
          Icon(
            callInfo.callType == CallType.video ? Icons.videocam : Icons.call,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Cuộc gọi đang diễn ra',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$participantsCount người đang tham gia',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onJoinPressed,
            icon: const Icon(Icons.phone, size: 18),
            label: const Text('Tham gia'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
