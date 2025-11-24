import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed while waiting for callee to respond
/// Shows "Calling {calleeName}..." with animated indicator
class WaitingCallScreen extends HookConsumerWidget {
  final String callId;
  final String calleeName;
  final bool isVideoCall;

  const WaitingCallScreen({super.key, required this.callId, required this.calleeName, required this.isVideoCall});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final callStatus = ref.watch(callStatusProvider);

    // Listen to status changes
    ref.listen(callStatusProvider, (previous, next) {
      if (next.status == CallStatus.rejected) {
        // Show rejection message and navigate back
        _showRejectionDialog(context, ref, next.rejectionReason ?? 'declined');
      } else if (next.status == CallStatus.timeout) {
        // Show timeout message and navigate back
        _showTimeoutDialog(context, ref);
      } else if (next.status == CallStatus.connectingToCall || next.status == CallStatus.active) {
        // Navigate to call screen
        if (context.mounted) {
          context.pushReplacement('/call/$callId');
        }
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top section - Call type indicator
                Text(
                  isVideoCall ? 'Video Call' : 'Audio Call',
                  style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                ),

                // Middle section - Callee information and status
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Avatar placeholder
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      child: Center(
                        child: Text(
                          _getInitials(calleeName),
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Callee name
                    Text(
                      calleeName,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Status message with animated indicator
                    _buildStatusMessage(context, callStatus),
                  ],
                ),

                // Bottom section - Cancel button
                _CallActionButton(
                  icon: FontAwesomeIcons.phoneSlash,
                  label: 'Cancel',
                  backgroundColor: Colors.red,
                  onPressed: () => _handleCancel(context, ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build status message based on call status
  Widget _buildStatusMessage(BuildContext context, CallStatusInfo statusInfo) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String message;
    switch (statusInfo.status) {
      case CallStatus.initiating:
        message = 'Connecting...';
        break;
      case CallStatus.waitingForResponse:
        message = 'Calling $calleeName...';
        break;
      case CallStatus.connectingToCall:
        message = 'Connecting to call...';
        break;
      default:
        message = 'Calling...';
    }

    return Column(
      children: [
        // Animated loading indicator
        SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
        const SizedBox(height: 12),

        // Status text
        Text(message, style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6))),
      ],
    );
  }

  /// Get initials from name
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Handle cancel action
  void _handleCancel(BuildContext context, WidgetRef ref) {
    // End the call
    ref.read(callProvider.notifier).endCall(callId);

    // Reset status
    ref.read(callStatusProvider.notifier).reset();

    // Navigate back
    if (context.mounted) {
      context.pop();
    }
  }

  /// Show rejection dialog
  void _showRejectionDialog(BuildContext context, WidgetRef ref, String reason) {
    final reasonText = reason == 'busy'
        ? '$calleeName is currently busy'
        : reason == 'declined'
        ? '$calleeName declined the call'
        : '$calleeName rejected the call: $reason';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Rejected'),
        content: Text(reasonText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(callStatusProvider.notifier).reset();
              if (context.mounted) {
                context.pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show timeout dialog
  void _showTimeoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('No Answer'),
        content: Text('$calleeName did not answer the call'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(callStatusProvider.notifier).reset();
              if (context.mounted) {
                context.pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Custom call action button widget
class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const _CallActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular button
        Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              child: FaIcon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Label
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
