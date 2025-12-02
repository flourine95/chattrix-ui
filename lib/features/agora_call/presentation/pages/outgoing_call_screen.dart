import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/failures/call_failure.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed when initiating a call to another user
/// Shows callee information and "Calling..." or "Ringing..." status
/// Handles call state transitions (accepted, rejected, timeout, ended)
class OutgoingCallScreen extends HookConsumerWidget {
  const OutgoingCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final callState = ref.watch(callStateProvider);

    // Listen to call state changes
    ref.listen<AsyncValue<CallEntity?>>(callStateProvider, (previous, next) {
      next.when(
        data: (call) {
          if (call == null) {
            // Call ended or cleared - dismiss screen
            if (context.mounted) {
              context.pop();
            }
          } else if (call.status == CallStatus.connected) {
            // Call accepted - navigate to ActiveCallScreen
            if (context.mounted) {
              context.pushReplacement('/agora-call/active');
            }
          } else if (call.status == CallStatus.rejected) {
            // Call rejected - show error dialog
            _showRejectionDialog(context, ref, call);
          } else if (call.status == CallStatus.ended) {
            // Call ended - dismiss screen
            if (context.mounted) {
              context.pop();
            }
          }
        },
        loading: () {
          // Loading state - do nothing
        },
        error: (error, stack) {
          // Error state - show error dialog
          // Requirement 8.1: Handle API errors with user-friendly messages
          if (error is CallFailure) {
            CallErrorHandler.showErrorDialog(
              context,
              error,
              onDismiss: () {
                if (context.mounted) {
                  context.pop();
                }
              },
            );
          } else {
            _showErrorDialog(context, ref, error);
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: callState.when(
          data: (call) {
            if (call == null) {
              // No active call - this shouldn't happen, but handle gracefully
              return Center(child: Text('No active call', style: theme.textTheme.bodyLarge));
            }

            return _buildCallContent(context, theme, colorScheme, call, ref);
          },
          loading: () =>
              Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary))),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.triangleExclamation, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Failed to initiate call', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the main call content
  Widget _buildCallContent(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    CallEntity call,
    WidgetRef ref,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top section - Call type indicator
            Text(
              call.callType == CallType.video ? 'Video Call' : 'Audio Call',
              style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
            ),

            // Middle section - Callee information and status
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                _buildAvatar(call, colorScheme, theme),
                const SizedBox(height: 24),

                // Callee name
                Text(
                  call.calleeName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Status message with animated indicator
                _buildStatusMessage(context, call, colorScheme, theme),
              ],
            ),

            // Bottom section - Cancel button
            _CallActionButton(
              icon: FontAwesomeIcons.phoneSlash,
              label: 'Cancel',
              backgroundColor: Colors.red,
              onPressed: () => _handleCancel(context, ref, call.id),
            ),
          ],
        ),
      ),
    );
  }

  /// Build avatar widget
  Widget _buildAvatar(CallEntity call, ColorScheme colorScheme, ThemeData theme) {
    if (call.calleeAvatar != null && call.calleeAvatar!.isNotEmpty) {
      // Show network image if avatar URL is available
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(call.calleeAvatar!), fit: BoxFit.cover),
        ),
      );
    } else {
      // Show initials if no avatar
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary.withValues(alpha: 0.1)),
        child: Center(
          child: Text(
            _getInitials(call.calleeName),
            style: theme.textTheme.displayMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  /// Build status message based on call status
  Widget _buildStatusMessage(BuildContext context, CallEntity call, ColorScheme colorScheme, ThemeData theme) {
    String message;
    switch (call.status) {
      case CallStatus.initiating:
        message = 'Connecting...';
        break;
      case CallStatus.ringing:
        message = 'Ringing...';
        break;
      case CallStatus.connecting:
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
  void _handleCancel(BuildContext context, WidgetRef ref, String callId) {
    // End the call
    ref.read(callStateProvider.notifier).endCall(callId);

    // Navigate back
    if (context.mounted) {
      context.pop();
    }
  }

  /// Show rejection dialog
  void _showRejectionDialog(BuildContext context, WidgetRef ref, CallEntity call) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Rejected'),
        content: Text('${call.calleeName} declined the call'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
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

  /// Show error dialog
  void _showErrorDialog(BuildContext context, WidgetRef ref, Object error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Failed'),
        content: Text('Failed to initiate call: ${error.toString()}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
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
