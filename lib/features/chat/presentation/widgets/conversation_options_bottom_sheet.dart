import 'package:flutter/material.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';

/// Bottom sheet with conversation options
///
/// Displayed when user long-presses a conversation in the list.
/// Similar to Messenger's conversation options.
///
/// **Options:**
/// - Mark as unread/read
/// - Pin conversation (future)
/// - Mute notifications (future)
/// - Delete conversation (future)
/// - Block user (future, for DM only)
class ConversationOptionsBottomSheet extends StatelessWidget {
  final Conversation conversation;
  final bool isMarkedUnread;
  final bool hasUnreadMessages;
  final VoidCallback onMarkAsUnread;
  final VoidCallback onMarkAsRead;
  final VoidCallback? onPin;
  final VoidCallback? onMute;
  final VoidCallback? onDelete;
  final VoidCallback? onBlock;

  const ConversationOptionsBottomSheet({
    super.key,
    required this.conversation,
    required this.isMarkedUnread,
    required this.hasUnreadMessages,
    required this.onMarkAsUnread,
    required this.onMarkAsRead,
    this.onPin,
    this.onMute,
    this.onDelete,
    this.onBlock,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Conversation Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Options list
              _buildOption(
                context: context,
                icon: Icons.push_pin_outlined,
                label: 'Pin conversation',
                onTap: onPin,
                enabled: onPin != null,
              ),

              _buildOption(
                context: context,
                icon: Icons.notifications_off_outlined,
                label: 'Mute notifications',
                onTap: onMute,
                enabled: onMute != null,
              ),

              // Mark as unread/read - conditional based on state
              if (isMarkedUnread || hasUnreadMessages)
                _buildOption(
                  context: context,
                  icon: Icons.mark_email_read_outlined,
                  label: 'Mark as read',
                  onTap: () {
                    Navigator.pop(context);
                    onMarkAsRead();
                  },
                  enabled: true,
                  color: theme.colorScheme.primary,
                )
              else
                _buildOption(
                  context: context,
                  icon: Icons.mark_email_unread_outlined,
                  label: 'Mark as unread',
                  onTap: () {
                    Navigator.pop(context);
                    onMarkAsUnread();
                  },
                  enabled: true,
                  color: theme.colorScheme.primary,
                ),

              _buildOption(
                context: context,
                icon: Icons.delete_outline,
                label: 'Delete conversation',
                onTap: onDelete,
                enabled: onDelete != null,
                color: Colors.red,
              ),

              // Block user - only for DM
              if (conversation.type.toString().toUpperCase() == 'DIRECT')
                _buildOption(
                  context: context,
                  icon: Icons.block_outlined,
                  label: 'Block user',
                  onTap: onBlock,
                  enabled: onBlock != null,
                  color: Colors.red,
                ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool enabled,
    Color? color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveColor = !enabled
        ? (isDark ? Colors.grey[600] : Colors.grey[400])
        : (color ?? (isDark ? Colors.white : Colors.black87));

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: effectiveColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: effectiveColor,
                  fontWeight: enabled ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (!enabled)
              Text(
                'Coming soon',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
