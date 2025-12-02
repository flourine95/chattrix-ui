import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_error_handler.dart';
import 'package:chattrix_ui/features/agora_call/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen displayed during an active call
/// Shows remote user video/audio, local preview, call controls, and call duration
/// Handles call.ended event to dismiss screen and clean up Agora resources
/// Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 6.4, 7.3
class ActiveCallScreen extends HookConsumerWidget {
  const ActiveCallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final callState = ref.watch(callStateProvider);
    final agoraService = ref.watch(agoraEngineServiceProvider);
    final networkQualityState = ref.watch(networkQualityProvider);

    // Track remote user ID
    final remoteUid = useState<int?>(null);

    // Track current orientation for video call handling (Requirement 8.3, 8.5)
    final currentOrientation = MediaQuery.of(context).orientation;

    // Register Agora event handlers
    // Requirement 8.2: Handle Agora SDK errors with notification and cleanup
    // Requirement 8.4: Show quality warnings without terminating call
    // Requirement 7.5: Listen to Agora network quality events
    useEffect(() {
      agoraService.registerEventHandlers(
        onUserJoined: (connection, uid, elapsed) {
          debugPrint('ActiveCallScreen: Remote user joined - uid: $uid');
          remoteUid.value = uid;
        },
        onUserOffline: (connection, uid, reason) {
          debugPrint('ActiveCallScreen: Remote user offline - uid: $uid, reason: $reason');
          remoteUid.value = null;
        },
        onNetworkQuality: (connection, localUid, txQuality, rxQuality) {
          // Update network quality provider with metrics (Requirement 7.5, 8.4)
          ref.read(networkQualityProvider.notifier).updateQuality(txQuality: txQuality, rxQuality: rxQuality);

          // Show warning if quality degrades significantly (Requirement 8.4)
          final overallQuality = txQuality.index > rxQuality.index ? txQuality : rxQuality;
          if (overallQuality.index > QualityType.qualityGood.index) {
            if (context.mounted) {
              CallErrorHandler.showNetworkQualityWarning(context);
            }
          }
        },
        onError: (err, msg) {
          debugPrint('ActiveCallScreen: Agora error - $err: $msg');
          // Handle Agora SDK errors (Requirement 8.2)
          if (context.mounted) {
            _handleAgoraError(context, ref, err, msg);
          }
        },
      );

      return null;
    }, []);

    // Listen to call state changes (Requirement 7.3)
    ref.listen<AsyncValue<CallEntity?>>(callStateProvider, (previous, next) {
      next.when(
        data: (call) {
          if (call == null || call.status == CallStatus.ended) {
            // Call ended - dismiss screen (Requirement 7.3)
            if (context.mounted) {
              context.pop();
            }
          }
        },
        loading: () {},
        error: (error, stack) {
          _showErrorDialog(context, ref, error.toString());
        },
      );
    });

    // Listen to quality warnings (Requirement 8.4)
    ref.listen<String?>(qualityWarningProvider, (previous, next) {
      if (next != null && context.mounted) {
        CallErrorHandler.showQualityWarning(context, next);
      }
    });

    // Listen to WebSocket connection status (Requirement 8.3)
    ref.listen<bool>(callWebSocketStatusProvider, (previous, next) {
      if (previous == true && next == false && context.mounted) {
        // WebSocket disconnected
        CallErrorHandler.showWebSocketDisconnectionWarning(context);
      } else if (previous == false && next == true && context.mounted) {
        // WebSocket reconnected
        CallErrorHandler.showWebSocketReconnectedMessage(context);
      }
    });

    // Handle device rotation for video calls (Requirement 8.3, 8.5)
    useEffect(() {
      final call = callState.value;
      if (call != null && call.callType == CallType.video) {
        debugPrint('ActiveCallScreen: Orientation changed to $currentOrientation');
        // Video views will automatically adjust to new orientation
        // No additional action needed as Agora SDK handles this internally
      }
      return null;
    }, [currentOrientation]);

    // Handle app lifecycle changes (Requirement 8.3, 8.5)
    useEffect(() {
      void handleLifecycleChange(AppLifecycleState state) {
        debugPrint('ActiveCallScreen: App lifecycle changed to $state');
        ref.read(callStateProvider.notifier).handleAppLifecycleChange(state);
      }

      final binding = WidgetsBinding.instance;
      binding.addObserver(_AppLifecycleObserver(handleLifecycleChange));

      return () {
        // Observer cleanup is handled by Flutter
      };
    }, []);

    // Clean up Agora resources on dispose (Requirement 6.4)
    useEffect(() {
      return () {
        debugPrint('ActiveCallScreen: Cleaning up Agora resources');
        // Reset call controls
        ref.read(callControlsProvider.notifier).reset();
        // Reset network quality
        ref.read(networkQualityProvider.notifier).reset();
      };
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: callState.when(
          data: (call) {
            if (call == null) {
              return Center(
                child: Text('No active call', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
              );
            }

            return _buildCallContent(
              context,
              theme,
              colorScheme,
              call,
              ref,
              remoteUid.value,
              networkQualityState.overallQuality,
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.triangleExclamation, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Call Error', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
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
    int? remoteUid,
    QualityType networkQuality,
  ) {
    final isVideoCall = call.callType == CallType.video;

    return Stack(
      children: [
        // Background - Remote video view for video calls (Requirement 5.1)
        if (isVideoCall && remoteUid != null)
          Positioned.fill(child: RemoteVideoView(remoteUid: remoteUid))
        else
          // Audio call or no remote user - show avatar
          Positioned.fill(child: _buildAudioCallBackground(call, theme)),

        // Top section - Remote user info and network quality (Requirement 5.2, 7.5)
        Positioned(top: 16, left: 16, right: 16, child: _buildTopSection(call, theme, networkQuality)),

        // Local video preview for video calls (Requirement 5.1)
        if (isVideoCall) const Positioned(top: 100, right: 16, child: LocalVideoPreview()),

        // Bottom section - Call controls and end button (Requirement 5.3, 5.4, 5.5, 6.4)
        Positioned(bottom: 40, left: 0, right: 0, child: _buildBottomSection(context, ref, call, isVideoCall)),
      ],
    );
  }

  /// Build top section with user info and network quality
  Widget _buildTopSection(CallEntity call, ThemeData theme, QualityType networkQuality) {
    // Determine remote user name (show the other person's name)
    final remoteUserName = call.calleeName;

    return Column(
      children: [
        // Remote user name
        Text(
          remoteUserName,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [const Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black45)],
          ),
        ),
        const SizedBox(height: 8),

        // Call duration timer (Requirement 5.2)
        CallDurationTimer(startTime: call.createdAt),
        const SizedBox(height: 8),

        // Network quality indicator (Requirement 7.5)
        NetworkQualityIndicator(quality: networkQuality),
      ],
    );
  }

  /// Build audio call background with avatar
  Widget _buildAudioCallBackground(CallEntity call, ThemeData theme) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            _buildAvatar(call, theme),
            const SizedBox(height: 24),

            // Remote user name
            Text(
              call.calleeName,
              style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /// Build avatar widget
  Widget _buildAvatar(CallEntity call, ThemeData theme) {
    if (call.calleeAvatar != null && call.calleeAvatar!.isNotEmpty) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(call.calleeAvatar!), fit: BoxFit.cover),
        ),
      );
    } else {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.2)),
        child: Center(
          child: Text(
            _getInitials(call.calleeName),
            style: theme.textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  /// Build bottom section with controls and end button
  Widget _buildBottomSection(BuildContext context, WidgetRef ref, CallEntity call, bool isVideoCall) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Call controls (Requirement 5.3, 5.4, 5.5)
        CallControlsWidget(isVideoCall: isVideoCall),
        const SizedBox(height: 32),

        // End call button (Requirement 6.4)
        _buildEndCallButton(context, ref, call.id),
      ],
    );
  }

  /// Build end call button
  Widget _buildEndCallButton(BuildContext context, WidgetRef ref, String callId) {
    return Material(
      color: Colors.red,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () => _handleEndCall(context, ref, callId),
        customBorder: const CircleBorder(),
        child: Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          child: const FaIcon(FontAwesomeIcons.phoneSlash, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  /// Get initials from name
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Handle end call action (Requirement 6.1, 6.2, 6.3, 6.4, 6.5)
  Future<void> _handleEndCall(BuildContext context, WidgetRef ref, String callId) async {
    // Get current call to calculate duration
    final currentCall = ref.read(callStateProvider).value;

    // End the call through the provider
    // This will:
    // - Leave Agora channel (Requirement 6.2)
    // - Release media resources (Requirement 6.3)
    // - Send end request to backend (Requirement 6.1)
    // - Clear call state
    await ref.read(callStateProvider.notifier).endCall(callId);

    // Display final call duration (Requirement 6.5)
    if (context.mounted && currentCall != null) {
      final duration = DateTime.now().difference(currentCall.createdAt);
      _showCallEndedDialog(context, duration);
    } else if (context.mounted) {
      // Navigate back immediately if no call data
      context.pop();
    }
  }

  /// Show call ended dialog with final duration
  void _showCallEndedDialog(BuildContext context, Duration duration) {
    final formattedDuration = _formatDuration(duration);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Ended'),
        content: Text('Call duration: $formattedDuration'),
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

  /// Format duration as MM:SS or HH:MM:SS
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Show error dialog
  void _showErrorDialog(BuildContext context, WidgetRef ref, String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Call Error'),
        content: Text('An error occurred: $error'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              // End the call on error
              final call = ref.read(callStateProvider).value;
              if (call != null) {
                await ref.read(callStateProvider.notifier).endCall(call.id, reason: 'error');
              }
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

  /// Handle Agora SDK errors with cleanup
  /// Requirement 8.2: Handle Agora SDK errors with notification and cleanup
  void _handleAgoraError(BuildContext context, WidgetRef ref, ErrorCodeType err, String msg) {
    // Critical errors that require ending the call
    final criticalErrors = [
      ErrorCodeType.errInvalidToken,
      ErrorCodeType.errTokenExpired,
      ErrorCodeType.errConnectionLost,
      ErrorCodeType.errConnectionInterrupted,
    ];

    if (criticalErrors.contains(err)) {
      // Show error dialog and end call
      CallErrorHandler.showAgoraErrorDialog(
        context,
        msg,
        onEndCall: () async {
          final call = ref.read(callStateProvider).value;
          if (call != null) {
            await ref.read(callStateProvider.notifier).endCall(call.id, reason: 'agora_error');
          }
          if (context.mounted) {
            context.pop();
          }
        },
      );
    } else {
      // Non-critical errors - show warning but continue call
      CallErrorHandler.showQualityWarning(context, 'Connection issue: $msg');
    }
  }
}

/// App lifecycle observer for handling app state changes during calls
/// Requirement 8.3, 8.5: Handle app termination during active call
class _AppLifecycleObserver extends WidgetsBindingObserver {
  final void Function(AppLifecycleState) onLifecycleChange;

  _AppLifecycleObserver(this.onLifecycleChange);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onLifecycleChange(state);
  }
}
