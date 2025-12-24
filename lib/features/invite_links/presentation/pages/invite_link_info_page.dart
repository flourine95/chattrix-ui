import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/invite_link_entity.dart';
import '../providers/invite_link_info_provider.dart';
import '../providers/join_group_provider.dart';

/// Public page for viewing invite link info (no auth required)
/// Shows group info and allows joining via the link
class InviteLinkInfoPage extends HookConsumerWidget {
  final String token;

  const InviteLinkInfoPage({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkInfoAsync = ref.watch(inviteLinkInfoProvider(token));
    final joinGroupAsync = ref.watch(joinGroupProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lời mời tham gia nhóm')),
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
          // Group Avatar
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

          // Group Name
          Text(
            linkInfo.groupName,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Member Count
          Text(
            '${linkInfo.memberCount} thành viên',
            style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Invite Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thông tin lời mời', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Creator
                  _buildInfoRow(context, icon: Icons.person_outline, label: 'Người tạo', value: linkInfo.creatorName),
                  const SizedBox(height: 12),

                  // Created At
                  _buildInfoRow(
                    context,
                    icon: Icons.access_time,
                    label: 'Ngày tạo',
                    value: _formatDateTime(linkInfo.createdAt),
                  ),

                  // Expiry
                  if (linkInfo.expiresAt != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      icon: Icons.event,
                      label: 'Hết hạn',
                      value: _formatDateTime(linkInfo.expiresAt!),
                    ),
                  ],

                  // Max Uses
                  if (linkInfo.maxUses != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      icon: Icons.people_outline,
                      label: 'Số lượt sử dụng',
                      value: '${linkInfo.usesCount}/${linkInfo.maxUses}',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Join Button
          FilledButton.icon(
            onPressed: linkInfo.isValid && !joinGroupAsync.isLoading ? () => _handleJoinGroup(context, ref) : null,
            icon: joinGroupAsync.isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.group_add),
            label: Text(joinGroupAsync.isLoading ? 'Đang tham gia...' : 'Tham gia nhóm'),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
          ),

          // Invalid Link Warning
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
                            ? 'Liên kết này đã hết hạn'
                            : linkInfo.isMaxUsesReached
                            ? 'Liên kết này đã đạt giới hạn sử dụng'
                            : linkInfo.revoked
                            ? 'Liên kết này đã bị thu hồi'
                            : 'Liên kết không hợp lệ',
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
            Icon(Icons.link_off, size: 80, color: colorScheme.onSurfaceVariant.withOpacity(0.5)),
            const SizedBox(height: 24),
            Text('Không tìm thấy lời mời', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Liên kết này không tồn tại hoặc đã bị xóa',
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
            Text('Không thể tải thông tin', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
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
              label: const Text('Thử lại'),
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
          // Success - navigate to the group chat
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Đã tham gia nhóm "${result.groupName}"'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );

          // Navigate to chat view
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
          return 'Vừa xong';
        }
        return '${difference.inMinutes} phút trước';
      }
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
