import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/failures/call_failure.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed when receiving an incoming call
/// Shows caller information, plays ringtone, and provides accept/reject actions
/// Handles call state transitions (accepted, rejected, timeout, ended)
/// Requirements: 2.2, 2.3, 2.4, 3.5, 4.3
class IncomingCallScreen extends HookConsumerWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final callState = ref.watch(callStateProvider);
    final ringtoneService = ref.watch(ringtoneServiceProvider);

    // Start ringtone when screen appears (Requirement 2.4)
    useEffect(() {
      ringtoneService.play();

      // Stop ringtone when screen is disposed
      return () {
        ringtoneService.stop();
      };
    }, []);

    // Listen to call state changes
    ref.listen<AsyncValue<CallEntity?>>(callStateProvider, (previous, next) {
      next.when(
        data: (call) {
          if (call == null) {
            // Call ended or cleared - stop ringtone and dismiss screen
            ringtoneService.stop();
            if (context.mounted) {
              context.pop();
            }
          } else if (call.status == CallStatus.connected) {
            // Call accepted - stop ringtone and navigate to ActiveCallScreen
            ringtoneService.stop();
            if (context.mounted) {
              context.pushReplacement('/agora-call/active');
            }
          } else if (call.status == CallStatus.rejected) {
            // Call rejected - stop ringtone and dismiss screen
            ringtoneService.stop();
            if (context.mounted) {
              context.pop();
            }
          } else if (call.status == CallStatus.ended) {
            // Call ended - stop ringtone and dismiss screen (Requirement 4.3)
            ringtoneService.stop();
            if (context.mounted) {
              context.pop();
            }
          }
        },
        loading: () {
          // Loading state - do nothing
        },
        error: (error, stack) {
          // Error state - stop ringtone and show error dialog
          // Requirement 8.1: Handle API errors with user-friendly messages
          ringtoneService.stop();
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
            _showErrorDialog(context, error);
          }
        },
      );
    });

    // Auto-dismiss on timeout (handled by WebSocket event in provider)
    // The provider will clear the state when call.timeout is received

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: callState.when(
          data: (call) {
            if (call == null) {
              // No active call - this shouldn't happen, but handle gracefully
              return Center(child: Text('No incoming call', style: theme.textTheme.bodyLarge));
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
                Text('Call Error', style: theme.textTheme.titleMedium),
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
            // Top section - Call type indicator (Requirement 2.3)
            Column(
              children: [
                Text(
                  'Incoming Call',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                _buildCallTypeIndicator(call.callType, theme, colorScheme),
              ],
            ),

            // Middle section - Caller information (Requirement 2.2)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                _buildAvatar(call, colorScheme, theme),
                const SizedBox(height: 24),

                // Caller name
                Text(
                  call.callerName,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Ringing indicator
                _buildRingingIndicator(colorScheme, theme),
              ],
            ),

            // Bottom section - Accept and Reject buttons (Requirement 2.3)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reject button (red) (Requirement 2.3)
                _CallActionButton(
                  icon: FontAwesomeIcons.phoneSlash,
                  label: 'Reject',
                  backgroundColor: Colors.red,
                  onPressed: () => _handleReject(context, ref, call.id),
                ),

                // Accept button (green) (Requirement 2.3)
                _CallActionButton(
                  icon: FontAwesomeIcons.phone,
                  label: 'Accept',
                  backgroundColor: Colors.green,
                  onPressed: () => _handleAccept(context, ref, call.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build call type indicator (audio/video)
  Widget _buildCallTypeIndicator(CallType callType, ThemeData theme, ColorScheme colorScheme) {
    final isVideo = callType == CallType.video;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(isVideo ? FontAwesomeIcons.video : FontAwesomeIcons.phone, size: 16, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            isVideo ? 'Video Call' : 'Audio Call',
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Build avatar widget
  Widget _buildAvatar(CallEntity call, ColorScheme colorScheme, ThemeData theme) {
    if (call.callerAvatar != null && call.callerAvatar!.isNotEmpty) {
      // Show network image if avatar URL is available
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(call.callerAvatar!), fit: BoxFit.cover),
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
            _getInitials(call.callerName),
            style: theme.textTheme.displayMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  /// Build ringing indicator
  Widget _buildRingingIndicator(ColorScheme colorScheme, ThemeData theme) {
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

        // Ringing text
        Text(
          'Ringing...',
          style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
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

  /// Handle accept action (Requirement 3.1, 3.2, 3.3, 3.4, 3.5)
  void _handleAccept(BuildContext context, WidgetRef ref, String callId) {
    // Stop ringtone (Requirement 3.5)
    final ringtoneService = ref.read(ringtoneServiceProvider);
    ringtoneService.stop();

    // Call acceptCall() on provider (Requirement 3.1)
    ref.read(callStateProvider.notifier).acceptCall(callId);

    // The provider will handle:
    // - Sending accept request to backend (Requirement 3.1)
    // - Receiving Agora token (Requirement 3.2)
    // - Joining Agora channel (Requirement 3.3)
    // - Transitioning to active call screen (Requirement 3.4)
  }

  /// Handle reject action (Requirement 4.1, 4.2, 4.3)
  void _handleReject(BuildContext context, WidgetRef ref, String callId) {
    // Stop ringtone (Requirement 4.3)
    final ringtoneService = ref.read(ringtoneServiceProvider);
    ringtoneService.stop();

    // Call rejectCall() on provider (Requirement 4.1)
    ref.read(callStateProvider.notifier).rejectCall(callId: callId, reason: 'declined');

    // The provider will handle:
    // - Sending reject request to backend (Requirement 4.1)
    // - Closing the incoming call screen (Requirement 4.2)
    // - Not joining Agora channel (Requirement 4.4)

    // Navigate back
    if (context.mounted) {
      context.pop();
    }
  }

  /// Show error dialog
  void _showErrorDialog(BuildContext context, Object error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Error'),
        content: Text('An error occurred: ${error.toString()}'),
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
