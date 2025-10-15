import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: textTheme.titleLarge)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colors.primary,
                  child: Text(
                    user?.username.substring(0, 1).toUpperCase() ?? 'U',
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? 'User Name',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'online • @${user?.username ?? 'userid'}',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userPen),
            title: const Text('Chỉnh sửa Hồ sơ'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.bell),
            title: const Text('Cài đặt Thông báo'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.lock),
            title: const Text('Riêng tư & Bảo mật'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: colors.error,
            ),
            title: Text(
              'Đăng xuất',
              style: textTheme.bodyLarge?.copyWith(color: colors.error),
            ),
            onTap: () async {
              // Show confirmation dialog
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Đăng xuất'),
                  content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        'Đăng xuất',
                        style: TextStyle(color: colors.error),
                      ),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true && context.mounted) {
                // Perform logout
                await ref.read(authNotifierProvider.notifier).logout();
                // Navigate to login screen
                if (context.mounted) {
                  context.go('/login');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
