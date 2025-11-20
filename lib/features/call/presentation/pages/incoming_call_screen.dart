import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed when receiving an incoming call invitation
class IncomingCallScreen extends HookConsumerWidget {
  final CallInvitation invitation;

  const IncomingCallScreen({super.key, required this.invitation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top section - Call type indicator
              Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    invitation.callType == CallType.video ? 'Incoming Video Call' : 'Incoming Audio Call',
                    style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                  ),
                ],
              ),

              // Middle section - Caller information
              Column(
                children: [
                  // Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(invitation.callerName),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Caller name
                  Text(
                    invitation.callerName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Calling status
                  Text(
                    'Calling...',
                    style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                ],
              ),

              // Bottom section - Action buttons
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Reject button
                      _CallActionButton(
                        icon: FontAwesomeIcons.phoneSlash,
                        label: 'Decline',
                        backgroundColor: Colors.red,
                        onPressed: () => _handleReject(context, ref),
                      ),

                      // Accept button
                      _CallActionButton(
                        icon: FontAwesomeIcons.phone,
                        label: 'Accept',
                        backgroundColor: Colors.green,
                        onPressed: () => _handleAccept(context, ref),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get initials from caller name
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Handle reject action
  void _handleReject(BuildContext context, WidgetRef ref) {
    // Reject the call through the notifier
    ref.read(callProvider.notifier).rejectCall(invitation.callId);

    // Navigate back
    if (context.mounted) {
      context.pop();
    }
  }

  /// Handle accept action
  Future<void> _handleAccept(BuildContext context, WidgetRef ref) async {
    // Accept the call through the notifier
    await ref
        .read(callProvider.notifier)
        .acceptCall(
          callId: invitation.callId,
          channelId: invitation.channelId,
          remoteUserId: invitation.callerId,
          callType: invitation.callType,
        );

    // Navigate to call screen
    if (context.mounted) {
      context.pushReplacement(
        '/call/${invitation.callId}',
        extra: {
          'remoteUserId': invitation.callerId,
          'callType': invitation.callType == CallType.video ? 'video' : 'audio',
        },
      );
    }
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
