import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsSectionWidget extends HookConsumerWidget {
  const SettingsSectionWidget({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMuted = useState(false);
    final isBlocked = useState(false);
    final notificationsEnabled = useState(true);

    final isGroup = conversation.type == ConversationType.group;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Customization section
        _SectionHeader(title: 'Customization'),
        const SizedBox(height: 8),
        _SettingsTile(
          icon: Icons.color_lens_outlined,
          title: 'Theme & Colors',
          subtitle: 'Change conversation appearance',
          onTap: () {
            // TODO: Implement theme customization
            _showThemeCustomization(context);
          },
        ),
        if (!isGroup)
          _SettingsTile(
            icon: Icons.edit_outlined,
            title: 'Nickname',
            subtitle: 'Set a nickname for this person',
            onTap: () {
              // TODO: Implement nickname
              _showNicknameDialog(context);
            },
          ),
        if (isGroup)
          _SettingsTile(
            icon: Icons.image_outlined,
            title: 'Change Group Photo',
            subtitle: 'Update group avatar',
            onTap: () {
              // TODO: Implement change group avatar
            },
          ),
        if (isGroup)
          _SettingsTile(
            icon: Icons.edit_outlined,
            title: 'Rename Group',
            subtitle: 'Change group name',
            onTap: () {
              // TODO: Implement change group name
              _showRenameGroupDialog(context);
            },
          ),

        const SizedBox(height: 24),

        // Notifications section
        _SectionHeader(title: 'Notifications'),
        const SizedBox(height: 8),
        _SettingsSwitchTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: notificationsEnabled.value
              ? 'Receive notifications from this conversation'
              : 'Notifications disabled',
          value: notificationsEnabled.value,
          onChanged: (value) {
            notificationsEnabled.value = value;
            // TODO: Update notification settings
          },
        ),
        _SettingsSwitchTile(
          icon: Icons.volume_off_outlined,
          title: 'Mute',
          subtitle: isMuted.value ? 'Conversation is muted' : 'Mute notification sounds',
          value: isMuted.value,
          onChanged: (value) {
            isMuted.value = value;
            // TODO: Implement mute/unmute
          },
        ),

        const SizedBox(height: 24),

        // Privacy & Support section
        _SectionHeader(title: 'Privacy & Support'),
        const SizedBox(height: 8),
        if (!isGroup)
          _SettingsSwitchTile(
            icon: Icons.block_outlined,
            title: 'Block',
            subtitle: isBlocked.value ? 'User is blocked' : 'Block messages and calls',
            value: isBlocked.value,
            onChanged: (value) {
              isBlocked.value = value;
              // TODO: Implement block/unblock
              _confirmBlock(context, value);
            },
            isDestructive: true,
          ),
        _SettingsTile(
          icon: Icons.report_outlined,
          title: 'Report',
          subtitle: 'Report spam or abuse',
          onTap: () {
            // TODO: Implement report
            _showReportDialog(context);
          },
        ),

        const SizedBox(height: 24),

        // Danger zone
        _SectionHeader(title: 'Danger Zone', isDestructive: true),
        const SizedBox(height: 8),
        if (isGroup)
          _SettingsTile(
            icon: Icons.exit_to_app_outlined,
            title: 'Leave Group',
            subtitle: 'You will no longer be a member',
            onTap: () {
              // TODO: Implement leave group
              _confirmLeaveGroup(context);
            },
            isDestructive: true,
          ),
        _SettingsTile(
          icon: Icons.delete_outline,
          title: 'Delete Conversation',
          subtitle: 'Delete all message history',
          onTap: () {
            // TODO: Implement delete conversation
            _confirmDeleteConversation(context);
          },
          isDestructive: true,
        ),
      ],
    );
  }

  void _showThemeCustomization(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose Theme Color'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [Colors.blue, Colors.green, Colors.red, Colors.purple, Colors.orange].map((color) {
                return InkWell(
                  onTap: () {
                    // TODO: Update theme color
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showNicknameDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Nickname'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter nickname...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Update nickname
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showRenameGroupDialog(BuildContext context) {
    final controller = TextEditingController(text: conversation.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Group'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter group name...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Update group name
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmBlock(BuildContext context, bool block) {
    if (!block) return; // No confirmation needed for unblock

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text(
          'You will not receive messages and calls from this person. '
          'They will not be notified that you blocked them.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Block user
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Spam'),
              onTap: () {
                // TODO: Report as spam
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Abuse'),
              onTap: () {
                // TODO: Report as abuse
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Inappropriate Content'),
              onTap: () {
                // TODO: Report inappropriate content
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLeaveGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Group'),
        content: const Text(
          'Are you sure you want to leave this group? '
          'You will not be able to see new messages.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Leave group
              Navigator.pop(context);
              context.pop(); // Go back to conversations list
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteConversation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Conversation'),
        content: const Text(
          'Are you sure you want to delete this conversation? '
          'All message history will be permanently deleted.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Delete conversation
              Navigator.pop(context);
              context.pop(); // Go back to conversations list
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.isDestructive = false});

  final String title;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      title.toUpperCase(),
      style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: isDestructive ? Colors.red : null),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : colors.primary),
      title: Text(title, style: textTheme.bodyLarge?.copyWith(color: isDestructive ? Colors.red : null)),
      subtitle: subtitle != null ? Text(subtitle!, style: textTheme.bodySmall) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SwitchListTile(
      secondary: Icon(icon, color: isDestructive && value ? Colors.red : colors.primary),
      title: Text(title, style: textTheme.bodyLarge?.copyWith(color: isDestructive && value ? Colors.red : null)),
      subtitle: subtitle != null ? Text(subtitle!, style: textTheme.bodySmall) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
