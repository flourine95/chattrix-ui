import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_participant_status.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:flutter/material.dart';

class ActiveCallBanner extends StatelessWidget {
  final CallInfo callInfo;
  final VoidCallback onJoinPressed;

  const ActiveCallBanner({super.key, required this.callInfo, required this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final participantsCount = callInfo.participants.where((p) => p.status == CallParticipantStatus.joined).length;

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
                  'Call in progress', // Đã đổi
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$participantsCount participants joined', // Đã đổi
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: onJoinPressed,
            icon: const Icon(Icons.phone, size: 16),
            label: const Text('Join'), // Đã đổi
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: const Size(0, 36),
            ),
          ),
        ],
      ),
    );
  }
}