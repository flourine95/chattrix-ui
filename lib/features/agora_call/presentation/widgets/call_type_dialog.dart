import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Dialog for selecting call type (audio or video)
///
/// Shows two options: Audio Call and Video Call
/// Returns the selected CallType or null if cancelled
class CallTypeDialog extends StatelessWidget {
  const CallTypeDialog({super.key});

  /// Shows the call type selection dialog
  ///
  /// Returns the selected [CallType] or null if cancelled
  static Future<CallType?> show(BuildContext context) {
    return showDialog<CallType>(context: context, builder: (context) => const CallTypeDialog());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text('Select Call Type', style: theme.textTheme.titleLarge),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Audio call option
          _CallTypeOption(
            icon: FontAwesomeIcons.phone,
            label: 'Audio Call',
            description: 'Voice only',
            color: colorScheme.primary,
            onTap: () => Navigator.of(context).pop(CallType.audio),
          ),
          const SizedBox(height: 16),

          // Video call option
          _CallTypeOption(
            icon: FontAwesomeIcons.video,
            label: 'Video Call',
            description: 'Voice and video',
            color: colorScheme.secondary,
            onTap: () => Navigator.of(context).pop(CallType.video),
          ),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))],
    );
  }
}

/// Individual call type option widget
class _CallTypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _CallTypeOption({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Center(child: FaIcon(icon, color: color, size: 20)),
            ),
            const SizedBox(width: 16),

            // Label and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}
