import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/domain/failures/call_failure.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/agora_call_providers.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_error_handler.dart';
import 'package:chattrix_ui/features/agora_call/presentation/widgets/call_type_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Helper class for initiating calls with proper permission handling
class CallInitiationHelper {
  /// Shows call type selection dialog and initiates call
  ///
  /// Handles the complete flow:
  /// 1. Show call type selection dialog
  /// 2. Request permissions
  /// 3. Initiate call via CallStateNotifier
  /// 4. Navigate to OutgoingCallScreen on success
  /// 5. Show error message on failure
  ///
  /// [context] - Build context for navigation and dialogs
  /// [ref] - WidgetRef for accessing providers
  /// [calleeId] - ID of the user to call
  /// [calleeName] - Name of the user to call (for display)
  static Future<void> initiateCallWithDialog({
    required BuildContext context,
    required WidgetRef ref,
    required int calleeId,
    required String calleeName,
  }) async {
    // Step 1: Show call type selection dialog
    final callType = await CallTypeDialog.show(context);

    if (callType == null || !context.mounted) {
      // User cancelled
      return;
    }

    // Step 2: Request permissions
    final permissionService = ref.read(permissionServiceProvider);
    final hasPermissions = await permissionService.requestCallPermissions(callType);

    if (!hasPermissions) {
      // Check if permissions are permanently denied
      final isPermanentlyDenied = await permissionService.arePermissionsPermanentlyDenied(callType);

      if (!context.mounted) return;

      if (isPermanentlyDenied) {
        // Show dialog to open settings
        _showPermissionDeniedDialog(context, permissionService, callType);
      } else {
        // Show simple error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              callType == CallType.video
                  ? 'Camera and microphone permissions are required for video calls'
                  : 'Microphone permission is required for audio calls',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                initiateCallWithDialog(context: context, ref: ref, calleeId: calleeId, calleeName: calleeName);
              },
            ),
          ),
        );
      }
      return;
    }

    // Step 3: Show loading indicator
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Step 4: Initiate call
      await ref.read(callStateProvider.notifier).initiateCall(calleeId: calleeId, callType: callType);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Step 5: Navigate to OutgoingCallScreen
      if (context.mounted) {
        context.push('/agora-call/outgoing');
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Step 6: Show error message
      // Requirement 8.1: Handle API errors with user-friendly messages
      if (context.mounted) {
        if (e is CallFailure) {
          CallErrorHandler.showErrorSnackBar(context, e);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to start call: ${e.toString()}'), backgroundColor: Colors.red));
        }
      }
    }
  }

  /// Initiates a call with a specific call type (no dialog)
  ///
  /// Useful when the call type is already known
  ///
  /// [context] - Build context for navigation and dialogs
  /// [ref] - WidgetRef for accessing providers
  /// [calleeId] - ID of the user to call
  /// [calleeName] - Name of the user to call (for display)
  /// [callType] - Type of call (audio or video)
  static Future<void> initiateCall({
    required BuildContext context,
    required WidgetRef ref,
    required int calleeId,
    required String calleeName,
    required CallType callType,
  }) async {
    // Step 1: Request permissions
    final permissionService = ref.read(permissionServiceProvider);
    final hasPermissions = await permissionService.requestCallPermissions(callType);

    if (!hasPermissions) {
      // Check if permissions are permanently denied
      final isPermanentlyDenied = await permissionService.arePermissionsPermanentlyDenied(callType);

      if (!context.mounted) return;

      if (isPermanentlyDenied) {
        // Show dialog to open settings
        _showPermissionDeniedDialog(context, permissionService, callType);
      } else {
        // Show simple error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              callType == CallType.video
                  ? 'Camera and microphone permissions are required for video calls'
                  : 'Microphone permission is required for audio calls',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                initiateCall(
                  context: context,
                  ref: ref,
                  calleeId: calleeId,
                  calleeName: calleeName,
                  callType: callType,
                );
              },
            ),
          ),
        );
      }
      return;
    }

    // Step 2: Show loading indicator
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Step 3: Initiate call
      await ref.read(callStateProvider.notifier).initiateCall(calleeId: calleeId, callType: callType);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Step 4: Navigate to OutgoingCallScreen
      if (context.mounted) {
        context.push('/agora-call/outgoing');
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Step 5: Show error message
      // Requirement 8.1: Handle API errors with user-friendly messages
      if (context.mounted) {
        if (e is CallFailure) {
          CallErrorHandler.showErrorSnackBar(context, e);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to start call: ${e.toString()}'), backgroundColor: Colors.red));
        }
      }
    }
  }

  /// Shows a dialog when permissions are permanently denied
  ///
  /// Offers the user the option to open app settings
  static void _showPermissionDeniedDialog(BuildContext context, dynamic permissionService, CallType callType) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(
          callType == CallType.video
              ? 'Camera and microphone permissions are required for video calls. Please enable them in app settings.'
              : 'Microphone permission is required for audio calls. Please enable it in app settings.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await permissionService.openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
