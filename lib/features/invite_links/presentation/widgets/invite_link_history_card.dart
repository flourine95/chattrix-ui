import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/presentation/widgets/qr_code_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class InviteLinkHistoryCard extends StatelessWidget {
  const InviteLinkHistoryCard({
    super.key,
    required this.link,
    required this.conversationId,
    this.onRevoked,
  });

  final InviteLinkHistoryItemEntity link;
  final int conversationId;
  final VoidCallback? onRevoked;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Standard card radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), // Standard card padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status badge
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      UserAvatar(
                        avatarUrl: link.createdBy.avatarUrl,
                        displayName: link.createdBy.fullName,
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              link.createdBy.fullName,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '@${link.createdBy.username}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colors.onSurface.withValues(alpha: 0.6),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatusBadge(context),
              ],
            ),
            const SizedBox(height: 12),

            // Link info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 16,
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          link.inviteUrl,
                          style: textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    context,
                    Icons.calendar_today,
                    'Created',
                    _formatDate(link.createdAt),
                  ),
                  const SizedBox(height: 4),
                  _buildInfoRow(
                    context,
                    Icons.people,
                    'Uses',
                    link.maxUses == 0
                        ? '${link.currentUses} (unlimited)'
                        : '${link.currentUses}/${link.maxUses}',
                  ),
                ],
              ),
            ),

            // Actions (only for active links)
            if (link.isActive) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _copyLink(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copy'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _shareLink(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text('Share'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showQRCode(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.qr_code, size: 18),
                      label: const Text('QR'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color badgeColor;
    String badgeText;
    IconData badgeIcon;

    if (link.isActive) {
      badgeColor = Colors.green;
      badgeText = 'Active';
      badgeIcon = Icons.check_circle;
    } else if (link.isRevoked) {
      badgeColor = Colors.red;
      badgeText = 'Revoked';
      badgeIcon = Icons.block;
    } else if (link.isExpired) {
      badgeColor = Colors.orange;
      badgeText = 'Expired';
      badgeIcon = Icons.event_busy;
    } else if (link.status == 'max_uses_reached') {
      badgeColor = Colors.blue;
      badgeText = 'Max Uses';
      badgeIcon = Icons.people;
    } else {
      badgeColor = colors.onSurface.withValues(alpha: 0.6);
      badgeText = link.status.replaceAll('_', ' ').toUpperCase();
      badgeIcon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 14, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            badgeText,
            style: textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: colors.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: textTheme.bodySmall?.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today at ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE, HH:mm').format(date);
    } else {
      return DateFormat('MMM dd, yyyy HH:mm').format(date);
    }
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: link.inviteUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Link copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareLink(BuildContext context) {
    Share.share(
      'Join our group on Chattrix: ${link.inviteUrl}',
      subject: 'Chattrix Group Invite',
    );
  }

  void _showQRCode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QRCodeBottomSheet(
        token: link.token,
        inviteUrl: link.inviteUrl,
      ),
    );
  }
}
