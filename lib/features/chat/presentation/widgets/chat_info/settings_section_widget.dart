import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsSectionWidget extends HookConsumerWidget {
  const SettingsSectionWidget({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMuted = useState(false);
    final isBlocked = useState(false);
    final notificationsEnabled = useState(true);
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final isGroup = conversation.type.toUpperCase() == 'GROUP';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Customization section
        _SectionHeader(title: 'Tùy chỉnh'),
        const SizedBox(height: 8),
        _SettingsTile(
          icon: Icons.color_lens_outlined,
          title: 'Chủ đề & màu sắc',
          subtitle: 'Thay đổi giao diện cuộc trò chuyện',
          onTap: () {
            // TODO: Implement theme customization
            _showThemeCustomization(context);
          },
        ),
        if (!isGroup)
          _SettingsTile(
            icon: Icons.edit_outlined,
            title: 'Biệt danh',
            subtitle: 'Đặt biệt danh cho người này',
            onTap: () {
              // TODO: Implement nickname
              _showNicknameDialog(context);
            },
          ),
        if (isGroup)
          _SettingsTile(
            icon: Icons.image_outlined,
            title: 'Đổi ảnh nhóm',
            subtitle: 'Thay đổi ảnh đại diện nhóm',
            onTap: () {
              // TODO: Implement change group avatar
            },
          ),
        if (isGroup)
          _SettingsTile(
            icon: Icons.edit_outlined,
            title: 'Đổi tên nhóm',
            subtitle: 'Thay đổi tên nhóm',
            onTap: () {
              // TODO: Implement change group name
              _showRenameGroupDialog(context);
            },
          ),

        const SizedBox(height: 24),

        // Notifications section
        _SectionHeader(title: 'Thông báo'),
        const SizedBox(height: 8),
        _SettingsSwitchTile(
          icon: Icons.notifications_outlined,
          title: 'Thông báo',
          subtitle: notificationsEnabled.value
              ? 'Nhận thông báo từ cuộc trò chuyện này'
              : 'Đã tắt thông báo',
          value: notificationsEnabled.value,
          onChanged: (value) {
            notificationsEnabled.value = value;
            // TODO: Update notification settings
          },
        ),
        _SettingsSwitchTile(
          icon: Icons.volume_off_outlined,
          title: 'Tắt tiếng',
          subtitle: isMuted.value
              ? 'Đã tắt tiếng cuộc trò chuyện'
              : 'Tắt âm thanh thông báo',
          value: isMuted.value,
          onChanged: (value) {
            isMuted.value = value;
            // TODO: Implement mute/unmute
          },
        ),

        const SizedBox(height: 24),

        // Privacy & Support section
        _SectionHeader(title: 'Quyền riêng tư & Hỗ trợ'),
        const SizedBox(height: 8),
        if (!isGroup)
          _SettingsSwitchTile(
            icon: Icons.block_outlined,
            title: 'Chặn',
            subtitle: isBlocked.value
                ? 'Đã chặn người dùng này'
                : 'Chặn tin nhắn và cuộc gọi',
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
          title: 'Báo cáo',
          subtitle: 'Báo cáo spam hoặc lạm dụng',
          onTap: () {
            // TODO: Implement report
            _showReportDialog(context);
          },
        ),

        const SizedBox(height: 24),

        // Danger zone
        _SectionHeader(title: 'Vùng nguy hiểm', isDestructive: true),
        const SizedBox(height: 8),
        if (isGroup)
          _SettingsTile(
            icon: Icons.exit_to_app_outlined,
            title: 'Rời khỏi nhóm',
            subtitle: 'Bạn sẽ không còn là thành viên',
            onTap: () {
              // TODO: Implement leave group
              _confirmLeaveGroup(context);
            },
            isDestructive: true,
          ),
        _SettingsTile(
          icon: Icons.delete_outline,
          title: 'Xóa cuộc trò chuyện',
          subtitle: 'Xóa toàn bộ lịch sử tin nhắn',
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
            const Text('Chọn màu chủ đề'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                Colors.blue,
                Colors.green,
                Colors.red,
                Colors.purple,
                Colors.orange,
              ].map((color) {
                return InkWell(
                  onTap: () {
                    // TODO: Update theme color
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
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
        title: const Text('Đặt biệt danh'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Nhập biệt danh...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Update nickname
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
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
        title: const Text('Đổi tên nhóm'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Nhập tên nhóm...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Update group name
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
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
        title: const Text('Chặn người dùng'),
        content: const Text(
          'Bạn sẽ không nhận được tin nhắn và cuộc gọi từ người này. '
          'Họ sẽ không biết bạn đã chặn họ.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Block user
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Chặn'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Báo cáo'),
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
              title: const Text('Lạm dụng'),
              onTap: () {
                // TODO: Report as abuse
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Nội dung không phù hợp'),
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
        title: const Text('Rời khỏi nhóm'),
        content: const Text(
          'Bạn có chắc chắn muốn rời khỏi nhóm này? '
          'Bạn sẽ không thể xem tin nhắn mới.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Leave group
              Navigator.pop(context);
              context.pop(); // Go back to conversations list
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Rời nhóm'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteConversation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa cuộc trò chuyện'),
        content: const Text(
          'Bạn có chắc chắn muốn xóa cuộc trò chuyện này? '
          'Toàn bộ lịch sử tin nhắn sẽ bị xóa vĩnh viễn.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Delete conversation
              Navigator.pop(context);
              context.pop(); // Go back to conversations list
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.isDestructive = false,
  });

  final String title;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      title.toUpperCase(),
      style: textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: isDestructive ? Colors.red : null,
      ),
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
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : colors.primary,
      ),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: textTheme.bodySmall,
            )
          : null,
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
      secondary: Icon(
        icon,
        color: isDestructive && value ? Colors.red : colors.primary,
      ),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: isDestructive && value ? Colors.red : null,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: textTheme.bodySmall,
            )
          : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
