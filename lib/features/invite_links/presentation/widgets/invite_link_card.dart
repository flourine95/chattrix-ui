import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/revoke_invite_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

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

            _buildInfoRow(context, Icons.person_outline, 'Created by', link.createdByUsername),
            _buildInfoRow(context, Icons.access_time, 'Created at', _formatDateTime(link.createdAt)),
            if (link.expiresAt != null)
              _buildInfoRow(
                context,
                Icons.event_outlined,
                'Expires',
                _formatDateTime(link.expiresAt!),
                isWarning: isExpired,
              ),
            if (link.maxUses != null)
              _buildInfoRow(
                context,
                Icons.people_outline,
                'Usage',
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
                      child: Text(
                        'This link has been revoked',
                        style: textTheme.bodySmall?.copyWith(color: colors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!isInvalid) ...[
                  _ActionButton(icon: Icons.copy, label: 'Copy', onPressed: () => _copyLink(context)),
                  _ActionButton(icon: Icons.share, label: 'Share', onPressed: () => _shareLink(context)),
                  _ActionButton(icon: Icons.qr_code, label: 'QR Code', onPressed: () => _showQRCode(context)),
                ],
                if (!link.revoked)
                  _ActionButton(
                    icon: Icons.block,
                    label: 'Revoke',
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
      label = 'Revoked';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else if (link.isExpired) {
      label = 'Expired';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else if (link.isMaxUsesReached) {
      label = 'Full';
      backgroundColor = colors.errorContainer;
      textColor = colors.error;
    } else {
      label = 'Active';
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied to clipboard')));
  }

  void _shareLink(BuildContext context) {
    Share.share('Join group via link: ${link.inviteUrl}', subject: 'Group Invitation Link');
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
        title: const Text('Revoke Invite Link'),
        content: const Text(
          'Are you sure you want to revoke this link? '
          'Once revoked, this link can no longer be used.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _revokeLink(context, ref);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invite link revoked successfully')));
          onRevoked?.call();
        }
      },
      loading: () {},
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
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
