import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_link_info_provider.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/join_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InviteLinkInfoPage extends HookConsumerWidget {
  final String token;

  const InviteLinkInfoPage({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkInfoAsync = ref.watch(inviteLinkInfoProvider(token));
    final joinGroupAsync = ref.watch(joinGroupProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Group Invite')),
      body: linkInfoAsync.when(
        data: (linkInfo) {
          if (linkInfo == null) {
            return _buildNotFound(context);
          }

          return _buildLinkInfo(context, ref, linkInfo, joinGroupAsync);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, ref, error),
      ),
    );
  }

  Widget _buildLinkInfo(
    BuildContext context,
    WidgetRef ref,
    InviteLinkInfoEntity linkInfo,
    AsyncValue<JoinGroupResultEntity?> joinGroupAsync,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: colorScheme.primaryContainer,
              child: linkInfo.groupAvatar != null
                  ? ClipOval(
                      child: Image.network(
                        linkInfo.groupAvatar!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.group, size: 60, color: colorScheme.onPrimaryContainer),
                      ),
                    )
                  : Icon(Icons.group, size: 60, color: colorScheme.onPrimaryContainer),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            linkInfo.groupName,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${linkInfo.memberCount} members',
            style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invitation Info', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildInfoRow(context, icon: Icons.person_outline, label: 'Created by', value: linkInfo.creatorName),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    context,
                    icon: Icons.access_time,
                    label: 'Created at',
                    value: _formatDateTime(linkInfo.createdAt),
                  ),
                  if (linkInfo.expiresAt != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      icon: Icons.event,
                      label: 'Expires at',
                      value: _formatDateTime(linkInfo.expiresAt!),
                    ),
                  ],
                  if (linkInfo.maxUses != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      icon: Icons.people_outline,
                      label: 'Usage',
                      value: '${linkInfo.usesCount}/${linkInfo.maxUses}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: linkInfo.isValid && !joinGroupAsync.isLoading ? () => _handleJoinGroup(context, ref) : null,
            icon: joinGroupAsync.isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.group_add),
            label: Text(joinGroupAsync.isLoading ? 'Joining...' : 'Join Group'),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
          ),
          if (!linkInfo.isValid) ...[
            const SizedBox(height: 16),
            Card(
              color: colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: colorScheme.onErrorContainer),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        linkInfo.isExpired
                            ? 'This link has expired'
                            : linkInfo.isMaxUsesReached
                            ? 'This link has reached its usage limit'
                            : linkInfo.revoked
                            ? 'This link has been revoked'
                            : 'Invalid link',
                        style: TextStyle(color: colorScheme.onErrorContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String label, required String value}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 2),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotFound(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.link_off, size: 80, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 24),
            Text('Invite Not Found', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'This link does not exist or has been deleted',
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: colorScheme.error),
            const SizedBox(height: 24),
            Text('Failed to load info', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ref.invalidate(inviteLinkInfoProvider(token));
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleJoinGroup(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(joinGroupProvider.notifier);

    await notifier.join(token);

    if (!context.mounted) return;

    final joinResult = ref.read(joinGroupProvider);

    joinResult.when(
      data: (result) {
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Joined group "${result.groupName}"'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );

          context.go('/chat/${result.conversationId}');
        }
      },
      error: (error, stack) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString()), backgroundColor: Theme.of(context).colorScheme.error));
      },
      loading: () {},
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
