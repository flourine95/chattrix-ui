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
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: textTheme.titleLarge),
        actions: [
          // Add refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : () => ref.read(authNotifierProvider.notifier).loadCurrentUser(),
            tooltip: 'Refresh information',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(authNotifierProvider.notifier).loadCurrentUser();
        },
        child: isLoading && user == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // User Info Header
                  Center(
                    child: Column(
                      children: [
                        // Avatar
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: colors.primary,
                              backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
                              child: user?.avatarUrl == null
                                  ? Text(
                                      user?.username.substring(0, 1).toUpperCase() ?? 'U',
                                      style: textTheme.headlineLarge?.copyWith(
                                        color: colors.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            ),
                            // Online status indicator
                            if (user?.isOnline ?? false)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: colors.surface, width: 3),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Full Name
                        Text(
                          user?.fullName ?? 'Loading...',
                          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),

                        // Username
                        Text(
                          '@${user?.username ?? 'username'}',
                          style: textTheme.titleMedium?.copyWith(color: colors.primary, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),

                        // Email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
                            const SizedBox(width: 4),
                            Text(
                              user?.email ?? 'email@example.com',
                              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Online status
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: (user?.isOnline ?? false)
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: (user?.isOnline ?? false) ? Colors.green : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                (user?.isOnline ?? false) ? 'Online' : 'Offline',
                                style: textTheme.bodySmall?.copyWith(
                                  color: (user?.isOnline ?? false) ? Colors.green : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // User ID (for debugging)
                  if (user != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colors.outline.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.fingerprint, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User ID',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colors.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    user.id.toString(),
                                    style: textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),
                  const Divider(),

                  // Menu Items
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.userPen),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.bell),
                    title: const Text('Notification Settings'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.lock),
                    title: const Text('Privacy & Security'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(),

                  // Debug Token Screen (for testing)
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.bug, color: colors.secondary),
                    title: Text('Debug Token', style: textTheme.bodyLarge),
                    trailing: Icon(Icons.chevron_right, color: colors.secondary),
                    onTap: () {
                      context.push('/debug-token');
                    },
                  ),
                  const Divider(),

                  // Logout
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.rightFromBracket, color: colors.error),
                    title: Text('Logout', style: textTheme.bodyLarge?.copyWith(color: colors.error)),
                    onTap: () async {
                      // Show confirmation dialog
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Logout', style: TextStyle(color: colors.error)),
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
      ),
    );
  }
}
