import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// Call History Item widget - displays a single call history entry
/// Shows participant name, avatar, call type, status, timestamp, and duration
/// Handles tap to show call back option
class CallHistoryItem extends HookConsumerWidget {
  const CallHistoryItem({super.key, required this.callHistory});

  final CallHistoryEntity callHistory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: _buildAvatar(colorScheme),
      title: Row(
        children: [
          Expanded(
            child: Text(callHistory.remoteUserName, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          _buildCallTypeIcon(colorScheme),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              _buildStatusIcon(colorScheme),
              const SizedBox(width: 4),
              Text(
                _formatStatus(callHistory.status),
                style: textTheme.bodySmall?.copyWith(color: _getStatusColor(callHistory.status, colorScheme)),
              ),
              const SizedBox(width: 8),
              Text('•', style: textTheme.bodySmall?.copyWith(color: colorScheme.outline)),
              const SizedBox(width: 8),
              Text(
                _formatTimestamp(callHistory.timestamp),
                style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
              ),
            ],
          ),
          if (callHistory.durationSeconds != null) ...[
            const SizedBox(height: 2),
            Text(
              'Duration: ${_formatDuration(callHistory.durationSeconds!)}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
            ),
          ],
        ],
      ),
      trailing: IconButton(
        icon: Icon(callHistory.callType == CallType.video ? Icons.videocam : Icons.phone, color: colorScheme.primary),
        onPressed: () => _handleCallBack(context, ref),
        tooltip: 'Call back',
      ),
      onTap: () => _handleCallBack(context, ref),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return CircleAvatar(
      backgroundColor: colorScheme.primaryContainer,
      child: Text(
        callHistory.remoteUserName.isNotEmpty ? callHistory.remoteUserName[0].toUpperCase() : '?',
        style: TextStyle(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCallTypeIcon(ColorScheme colorScheme) {
    return FaIcon(
      callHistory.callType == CallType.video ? FontAwesomeIcons.video : FontAwesomeIcons.phone,
      size: 14,
      color: colorScheme.outline,
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme) {
    IconData icon;
    Color color;

    switch (callHistory.status) {
      case CallStatus.ended:
        icon = Icons.call_made;
        color = Colors.green;
        break;
      case CallStatus.missed:
        icon = Icons.call_missed;
        color = Colors.red;
        break;
      case CallStatus.rejected:
        icon = Icons.call_end;
        color = Colors.orange;
        break;
      case CallStatus.failed:
        icon = Icons.error_outline;
        color = colorScheme.error;
        break;
      default:
        icon = Icons.phone;
        color = colorScheme.outline;
    }

    return Icon(icon, size: 14, color: color);
  }

  String _formatStatus(CallStatus status) {
    switch (status) {
      case CallStatus.ended:
        return 'Completed';
      case CallStatus.missed:
        return 'Missed';
      case CallStatus.rejected:
        return 'Rejected';
      case CallStatus.failed:
        return 'Failed';
      default:
        return status.name;
    }
  }

  Color _getStatusColor(CallStatus status, ColorScheme colorScheme) {
    switch (status) {
      case CallStatus.ended:
        return Colors.green;
      case CallStatus.missed:
        return Colors.red;
      case CallStatus.rejected:
        return Colors.orange;
      case CallStatus.failed:
        return colorScheme.error;
      default:
        return colorScheme.outline;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today - show time
      return DateFormat('HH:mm').format(timestamp);
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // This week - show day name
      return DateFormat('EEEE').format(timestamp);
    } else {
      // Older - show date
      return DateFormat('MMM d').format(timestamp);
    }
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${secs}s';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }

  void _handleCallBack(BuildContext context, WidgetRef ref) {
    // Show bottom sheet with call options
    showModalBottomSheet(
      context: context,
      builder: (context) => _CallBackBottomSheet(
        callHistory: callHistory,
        onCallBack: (callType) {
          Navigator.pop(context);
          _initiateCallBack(ref, callType);
        },
      ),
    );
  }

  void _initiateCallBack(WidgetRef ref, CallType callType) {
    final notifier = ref.read(callProvider.notifier);
    notifier.initiateCall(remoteUserId: callHistory.remoteUserId, callType: callType);
  }
}

/// Bottom sheet for call back options
class _CallBackBottomSheet extends StatelessWidget {
  const _CallBackBottomSheet({required this.callHistory, required this.onCallBack});

  final CallHistoryEntity callHistory;
  final void Function(CallType) onCallBack;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      callHistory.remoteUserName.isNotEmpty ? callHistory.remoteUserName[0].toUpperCase() : '?',
                      style: TextStyle(color: colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      callHistory.remoteUserName,
                      style: textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            ListTile(
              leading: Icon(Icons.videocam, color: colorScheme.primary),
              title: const Text('Video Call'),
              onTap: () => onCallBack(CallType.video),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: colorScheme.primary),
              title: const Text('Audio Call'),
              onTap: () => onCallBack(CallType.audio),
            ),
          ],
        ),
      ),
    );
  }
}
