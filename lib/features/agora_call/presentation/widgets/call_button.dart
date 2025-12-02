import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/utils/call_initiation_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Button widget for initiating calls
///
/// Can be configured for audio or video calls, or to show a dialog
class CallButton extends ConsumerWidget {
  final int calleeId;
  final String calleeName;
  final CallType? callType; // If null, shows dialog to select type
  final String? tooltip;
  final double? iconSize;

  const CallButton({
    super.key,
    required this.calleeId,
    required this.calleeName,
    this.callType,
    this.tooltip,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IconData icon;
    final String defaultTooltip;

    if (callType == CallType.audio) {
      icon = FontAwesomeIcons.phone;
      defaultTooltip = 'Audio call';
    } else if (callType == CallType.video) {
      icon = FontAwesomeIcons.video;
      defaultTooltip = 'Video call';
    } else {
      icon = FontAwesomeIcons.phone;
      defaultTooltip = 'Call';
    }

    return IconButton(
      icon: FaIcon(icon, size: iconSize ?? 20),
      onPressed: () => _handleCallPress(context, ref),
      tooltip: tooltip ?? defaultTooltip,
    );
  }

  Future<void> _handleCallPress(BuildContext context, WidgetRef ref) async {
    if (callType != null) {
      // Call type is specified, initiate directly
      await CallInitiationHelper.initiateCall(
        context: context,
        ref: ref,
        calleeId: calleeId,
        calleeName: calleeName,
        callType: callType!,
      );
    } else {
      // No call type specified, show dialog
      await CallInitiationHelper.initiateCallWithDialog(
        context: context,
        ref: ref,
        calleeId: calleeId,
        calleeName: calleeName,
      );
    }
  }
}
