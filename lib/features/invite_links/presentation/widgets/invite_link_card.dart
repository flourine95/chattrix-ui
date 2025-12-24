import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/invite_link_entity.dart';
import '../providers/revoke_invite_link_provider.dart';
import 'qr_code_dialog.dart';

class InviteLinkCard extends ConsumerWidget {
  const InviteLinkCard({super.key, required this.link, required this.conversationId, this.onRevoked});

  final InviteLinkEntity link;
  final int conversationId;
  final VoidCallback? onRevoked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final isExpired = link.isExpired;
    final isMaxUsesReached = link.isMaxUsesReached;
    final isInvalid = link.revoked || isExpired || isMaxUsesReached;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              children: [
                Icon(
                  isInvalid ? Icons.link_off : Icons.link,
                  color: isInvalid ? colors.error : colors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    link.token,
                    style: textTheme.titleSmall?.copyWith(
                      fontFamily: 'monospace',
                      color: isInvalid ? colors.onSurface.withValues(alpha: 0.5) : null,
                    ),
                  ),
                ),
                _buildStatusChip(context, link),
              ],
            ),

            const SizedBox(height: 12),

            // Info
            _buildInfoRow(context, Icons.person_outline, 'Tạo bởi', link.createdByUsername),
            _buildInfoRow(context, Icons.access_time, 'Tạo lúc', _formatDateTime(link.createdAt)),
            if (link.expiresAt != null)
              _buildInfoRow(
                context,
                Icons.event_outlined,
                'Hết hạn',
                _formatDateTime(link.expiresAt!),
                isWarning: isExpired,
              ),
            if (link.maxUses != null)
              _buildInfoRow(
                context,
                Icons.people_outline,
                'Số lần sử dụng',
                '${link.currentUses}/${link.maxUses}',
                isWarning: isMaxUsesReached,
              ),

            if (link.revoked) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: colors.errorContainer, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Icon(Icons.block, size: 16, color: colors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Link đã bị thu hồi', style: textTheme.bodySmall?.copyWith(color: colors.error)),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Actions
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!isInvalid) ...[
                  _ActionButton(icon: Icons.copy, label: 'Sao chép', onPressed: () => _copyLink(context)),
                  _ActionButton(icon: Icons.share, label: 'Chia sẻ', onPressed: () => _shareLink(context)),
                  _ActionButton(icon: Icons.qr_code, label: 'QR Code', onPressed: () => _showQRCode(context)),
                ],
                if (!link.revoked)
                  _ActionButton(
                    icon: Icons.block,
                    label: 'Thu hồi',
                    onPressed: () => _confirmRevoke(context, ref),
                    isDestructive: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, InviteLinkEntity link) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String label;
    Color backgroundColor;
    Color textColor;

    if (link.revoked) {
      label = 'Đã thu hồi';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else if (link.isExpired) {
      label = 'Hết hạn';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else if (link.isMaxUsesReached) {
      label = 'Đã đủ';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else {
      label = 'Hoạt động';
      backgroundColor = colors.primaryContainer;
      textColor = colors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, {bool isWarning = false}) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isWarning ? colors.error : colors.onSurface.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Text('$label: ', style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500, color: isWarning ? colors.error : null),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays < 7) {
      return DateFormat('E, HH:mm').format(dateTime);
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: link.inviteUrl));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã sao chép link')));
  }

  void _shareLink(BuildContext context) {
    Share.share('Tham gia nhóm qua link: ${link.inviteUrl}', subject: 'Link mời vào nhóm');
  }

  void _showQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => QRCodeDialog(conversationId: conversationId, linkId: link.id, token: link.token),
    );
  }

  void _confirmRevoke(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thu hồi link mời'),
        content: const Text(
          'Bạn có chắc muốn thu hồi link này? '
          'Sau khi thu hồi, link sẽ không thể sử dụng được nữa.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _revokeLink(context, ref);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Thu hồi'),
          ),
        ],
      ),
    );
  }

  Future<void> _revokeLink(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(revokeInviteLinkProvider.notifier);

    await notifier.revoke(conversationId: conversationId, linkId: link.id);

    final state = ref.read(revokeInviteLinkProvider);

    if (!context.mounted) return;

    state.when(
      data: (revokedLink) {
        if (revokedLink != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thu hồi link thành công')));
          onRevoked?.call();
        }
      },
      loading: () {},
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $error')));
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onPressed, this.isDestructive = false});

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: isDestructive ? colors.error : colors.primary),
      label: Text(label, style: textTheme.labelSmall?.copyWith(color: isDestructive ? colors.error : colors.primary)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: BorderSide(color: isDestructive ? colors.error : colors.primary),
      ),
    );
  }
}
