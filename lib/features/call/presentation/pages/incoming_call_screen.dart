import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/data/services/ringtone_service_provider.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_status_provider.dart';
import 'package:chattrix_ui/features/call/presentation/providers/incoming_call_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed when receiving an incoming call invitation
class IncomingCallScreen extends HookConsumerWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get invitation from provider instead of constructor parameter
    final invitation = ref.watch(currentIncomingCallProvider);

    // Track if call was accepted to prevent auto-navigate on dispose
    final wasAccepted = useState(false);

    // If no invitation, navigate to home (safety check)
    // BUT: Don't navigate if there's an active call (means invitation was cleared after accepting)
    if (invitation == null) {
      // Check if there's an active call - if yes, don't navigate to home
      // This prevents the bug where clearing invitation after accept triggers unwanted navigation
      final callState = ref.read(callProvider);
      final hasActiveCall = callState.value != null;

      debugPrint('🔍 [INCOMING CALL SCREEN] No invitation check:');
      debugPrint('   └─ hasActiveCall: $hasActiveCall');
      debugPrint('   └─ wasAccepted: ${wasAccepted.value}');
      debugPrint('   └─ callState: ${callState.runtimeType}');
      if (hasActiveCall) {
        debugPrint('   └─ Active call ID: ${callState.value?.callId}');
      }

      if (!hasActiveCall && !wasAccepted.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            debugPrint('⚠️ [INCOMING CALL SCREEN] No invitation and no active call - navigating to home');
            context.go('/');
          }
        });
      } else {
        debugPrint('✅ [INCOMING CALL SCREEN] No invitation but has active call or was accepted - not navigating to home');
      }
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final ringtoneService = ref.read(ringtoneServiceProvider);

    // Track remaining time for timeout
    final remainingSeconds = useState(60);

    // Clear invitation when screen is disposed ONLY if not accepted
    // (Reject and timeout already clear invitation explicitly)
    useEffect(() {
      // Capture the notifier reference before disposal
      final notifier = ref.read(incomingCallProvider.notifier);
      return () {
        // Only clear if call wasn't accepted (user backed out manually)
        if (!wasAccepted.value) {
          debugPrint('⚠️ [INCOMING CALL SCREEN] Disposed without accept, clearing invitation');
          // Delay the clear to avoid modifying provider during widget disposal
          Future.microtask(() => notifier.clearInvitation());
        } else {
          debugPrint('✅ [INCOMING CALL SCREEN] Disposed after accept, not clearing invitation');
        }
      };
    }, []);

    // Play ringtone when screen is displayed and stop when disposed
    useEffect(() {
      ringtoneService.playRingtone();

      return () {
        ringtoneService.stopRingtone();
      };
    }, []);

    // Implement 60-second timeout for incoming calls
    useEffect(() {
      // Start countdown timer
      final timer = Stream.periodic(const Duration(seconds: 1), (count) => 60 - count - 1).take(60).listen((seconds) {
        remainingSeconds.value = seconds;

        // Auto-dismiss after 60 seconds
        if (seconds == 0) {
          // Stop ringtone
          ringtoneService.stopRingtone();

          // Reject the call with timeout reason
          ref.read(callProvider.notifier).rejectCall(invitation.callId, reason: 'timeout');

          // Clear invitation before navigation
          ref.read(incomingCallProvider.notifier).clearInvitation();

          // Navigate to home
          if (context.mounted) {
            context.go('/');
          }
        }
      });

      return () {
        timer.cancel();
      };
    }, []);

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
                    invitation.callType == 'VIDEO' ? 'Incoming Video Call' : 'Incoming Audio Call',
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
                    child: invitation.callerAvatar != null
                        ? ClipOval(
                            child: Image.network(
                              invitation.callerAvatar!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback to initials if image fails to load
                                return Center(
                                  child: Text(
                                    _getInitials(invitation.callerName),
                                    style: theme.textTheme.displayMedium?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
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
                  const SizedBox(height: 8),

                  // Timeout indicator
                  Text(
                    'Call will timeout in ${remainingSeconds.value}s',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: remainingSeconds.value <= 10
                          ? Colors.red.withValues(alpha: 0.8)
                          : colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
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
                        onPressed: () => _handleReject(context, ref, invitation),
                      ),

                      // Accept button
                      _CallActionButton(
                        icon: FontAwesomeIcons.phone,
                        label: 'Accept',
                        backgroundColor: Colors.green,
                        onPressed: () => _handleAccept(context, ref, invitation, wasAccepted),
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
  void _handleReject(BuildContext context, WidgetRef ref, CallInvitationData invitation) {
    // Stop ringtone
    ref.read(ringtoneServiceProvider).stopRingtone();

    // Reject the call through the notifier with reason
    ref.read(callProvider.notifier).rejectCall(invitation.callId, reason: 'declined');

    // Clear invitation before navigation
    ref.read(incomingCallProvider.notifier).clearInvitation();

    // Navigate to home
    if (context.mounted) {
      context.go('/');
    }
  }

  /// Handle accept action
  Future<void> _handleAccept(
    BuildContext context,
    WidgetRef ref,
    CallInvitationData invitation,
    ValueNotifier<bool> wasAccepted,
  ) async {
    try {
      debugPrint('🎯 [ACCEPT CALL] Starting accept call flow');
      debugPrint('🎯 [ACCEPT CALL] Call ID: ${invitation.callId}');
      debugPrint('🎯 [ACCEPT CALL] Channel ID: ${invitation.channelId}');
      debugPrint('🎯 [ACCEPT CALL] Caller ID: ${invitation.callerId}');

      // Mark as accepted to prevent auto-clear on dispose
      wasAccepted.value = true;
      debugPrint('✅ [ACCEPT CALL] Marked as accepted');

      // Stop ringtone
      await ref.read(ringtoneServiceProvider).stopRingtone();
      debugPrint('✅ [ACCEPT CALL] Ringtone stopped');

      // Update status to connecting
      ref.read(callStatusProvider.notifier).setConnectingToCall();
      debugPrint('✅ [ACCEPT CALL] Status set to connecting');

      // Convert callType string to CallType enum
      final callType = invitation.callType == 'VIDEO' ? CallType.video : CallType.audio;
      debugPrint('✅ [ACCEPT CALL] Call type: $callType');

      // Accept the call and wait for the result
      debugPrint('🔄 [ACCEPT CALL] Calling acceptCall...');
      final acceptedCall = await ref
          .read(callProvider.notifier)
          .acceptCall(
            callId: invitation.callId,
            channelId: invitation.channelId,
            remoteUserId: invitation.callerId,
            callType: callType,
          );

      debugPrint('🔄 [ACCEPT CALL] acceptCall completed');
      debugPrint('🔄 [ACCEPT CALL] Accepted call result: $acceptedCall');

      // Verify the call was accepted successfully
      if (acceptedCall == null) {
        debugPrint('❌ [ACCEPT CALL] Failed to accept call - acceptedCall is null');
        // Show error if accept failed
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to accept call')));
        }
        return;
      }

      debugPrint('✅ [ACCEPT CALL] Call accepted successfully');
      debugPrint('✅ [ACCEPT CALL] Call details: callId=${acceptedCall.callId}, channelId=${acceptedCall.channelId}');

      // Navigate to call screen only after successful accept
      if (context.mounted) {
        final targetRoute = '/call/${invitation.callId}';
        debugPrint('🚀 [ACCEPT CALL] Navigating to: $targetRoute');
        debugPrint('🚀 [ACCEPT CALL] Extra data: remoteUserId=${invitation.callerId}, callType=${invitation.callType == 'VIDEO' ? 'video' : 'audio'}');

        // CRITICAL: Clear invitation BEFORE navigation to prevent router redirect to home
        debugPrint('🔄 [ACCEPT CALL] Clearing invitation BEFORE navigation...');
        ref.read(incomingCallProvider.notifier).clearInvitation();
        debugPrint('✅ [ACCEPT CALL] Invitation cleared BEFORE navigation');

        // Now navigate - at this point invitation is null but wasAccepted=true
        // so IncomingCallScreen won't auto-navigate to home on dispose
        context.go(
          targetRoute,
          extra: {'remoteUserId': invitation.callerId, 'callType': invitation.callType == 'VIDEO' ? 'video' : 'audio'},
        );

        debugPrint('✅ [ACCEPT CALL] Navigation completed');
      } else {
        debugPrint('❌ [ACCEPT CALL] Context not mounted, cannot navigate');
      }
    } catch (e, stackTrace) {
      // Handle any errors
      debugPrint('❌ [ACCEPT CALL] Error accepting call: $e');
      debugPrint('❌ [ACCEPT CALL] Stack trace: $stackTrace');
      CallLogger.logError('Error accepting call', error: e, stackTrace: stackTrace);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error accepting call: $e')));
      }
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
