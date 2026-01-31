import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/state/permissions_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupPermissionsPage extends HookConsumerWidget {
  const GroupPermissionsPage({super.key, required this.conversationId});

  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final me = ref.watch(currentUserProvider);
    final conversationsState = ref.watch(conversationsProvider);
    final conversation = conversationsState.value?.firstWhere(
      (c) => c.id == conversationId,
      orElse: () => throw Exception('Conversation not found'),
    );

    final isAdmin = conversation?.participants.any(
          (p) => p.userId == me?.id && p.role.toUpperCase() == 'ADMIN',
        ) ??
        false;

    final permissionsAsync = ref.watch(permissionsProvider(conversationId));

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Group Permissions'),
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: colors.surface,
        actions: [
          if (permissionsAsync.hasValue)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(permissionsProvider(conversationId).notifier).refresh();
              },
              tooltip: 'Refresh',
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          ),
        ),
      ),
      body: permissionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorView(context, ref, error, colors, textTheme),
        data: (permissions) {
          if (permissions == null) {
            return _buildEmptyView(context, colors, textTheme);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              // Permissions list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _PermissionTile(
                      title: 'Send Messages',
                      subtitle: 'Who can send messages',
                      icon: Icons.chat_bubble_outline,
                      value: permissions.sendMessages,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'sendMessages', v),
                      options: const ['ALL', 'ADMIN_ONLY'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Add Members',
                      subtitle: 'Who can add new members',
                      icon: Icons.person_add_outlined,
                      value: permissions.addMembers,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'addMembers', v),
                      options: const ['ALL', 'ADMIN_ONLY'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Edit Group Info',
                      subtitle: 'Who can edit name and avatar',
                      icon: Icons.edit_outlined,
                      value: permissions.editGroupInfo,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'editGroupInfo', v),
                      options: const ['ALL', 'ADMIN_ONLY'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Pin Messages',
                      subtitle: 'Who can pin messages',
                      icon: Icons.push_pin_outlined,
                      value: permissions.pinMessages,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'pinMessages', v),
                      options: const ['ALL', 'ADMIN_ONLY'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Delete Messages',
                      subtitle: 'Who can delete messages',
                      icon: Icons.delete_outline,
                      value: permissions.deleteMessages,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'deleteMessages', v),
                      options: const ['OWNER', 'ADMIN_ONLY', 'ALL'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Create Polls',
                      subtitle: 'Who can create polls',
                      icon: Icons.poll_outlined,
                      value: permissions.createPolls,
                      isAdmin: isAdmin,
                      onChanged: (v) => _updatePermission(context, ref, conversationId, 'createPolls', v),
                      options: const ['ALL', 'ADMIN_ONLY'],
                    ),
                    const SizedBox(height: 8),
                    _PermissionTile(
                      title: 'Remove Members',
                      subtitle: 'Only admins',
                      icon: Icons.person_remove_outlined,
                      value: 'ADMIN_ONLY',
                      isAdmin: false, // Always disabled
                      onChanged: null,
                      options: const ['ADMIN_ONLY'],
                      isFixed: true,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error, ColorScheme colors, TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text('Failed to load permissions', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(permissionsProvider(conversationId).notifier).refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_outlined, size: 64, color: colors.primary),
          const SizedBox(height: 16),
          Text('No permissions data available', style: textTheme.titleMedium),
        ],
      ),
    );
  }

  Future<void> _updatePermission(BuildContext context, WidgetRef ref, int conversationId, String key, String value) async {
    final notifier = ref.read(permissionsProvider(conversationId).notifier);
    final success = await notifier.updatePermissions(
      sendMessages: key == 'sendMessages' ? value : null,
      addMembers: key == 'addMembers' ? value : null,
      editGroupInfo: key == 'editGroupInfo' ? value : null,
      pinMessages: key == 'pinMessages' ? value : null,
      deleteMessages: key == 'deleteMessages' ? value : null,
      createPolls: key == 'createPolls' ? value : null,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                success ? 'Permission updated' : 'Failed to update. Admin only.',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: success ? Colors.green.shade700 : Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.isAdmin,
    required this.onChanged,
    required this.options,
    this.isFixed = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final bool isAdmin;
  final Function(String)? onChanged;
  final List<String> options;
  final bool isFixed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colors.primary, size: 22),
        ),
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodySmall?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: isFixed
            ? Text(
                _formatLevel(value),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface.withValues(alpha: 0.5),
                ),
              )
            : PopupMenuButton<String>(
                initialValue: value,
                enabled: isAdmin,
                onSelected: (v) {
                  if (onChanged != null) onChanged!(v);
                },
                offset: const Offset(0, 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatLevel(value),
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isAdmin ? colors.onSurface : colors.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: isAdmin ? colors.onSurface : colors.onSurface.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => options.map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(_formatLevel(option)),
                  );
                }).toList(),
              ),
      ),
    );
  }

  String _formatLevel(String level) {
    switch (level) {
      case 'ALL':
        return 'All Members';
      case 'ADMIN_ONLY':
        return 'Admins Only';
      case 'OWNER':
        return 'Owner';
      default:
        return level;
    }
  }
}
