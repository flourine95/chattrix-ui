import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/invite_link_providers.dart';
import '../../domain/entities/invite_link.dart';

/// Page for managing invite links for a group conversation
class InviteLinksPage extends HookConsumerWidget {
  final int conversationId;

  const InviteLinksPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Invite Links', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _showCreateLinkBottomSheet(context, ref),
          ),
        ],
      ),
      body: _InviteLinksListView(conversationId: conversationId),
    );
  }

  void _showCreateLinkBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _CreateInviteLinkBottomSheet(conversationId: conversationId),
    );
  }
}

/// List view for displaying invite links
class _InviteLinksListView extends HookConsumerWidget {
  final int conversationId;

  const _InviteLinksListView({required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Create provider for this conversation's invite links
    final inviteLinksProvider = useMemoized(
      () => FutureProvider<List<InviteLink>>((ref) async {
        final useCase = ref.read(getInviteLinksUseCaseProvider);
        final result = await useCase(conversationId: conversationId);
        return result.fold((failure) => throw Exception(failure.message), (links) => links);
      }),
      [conversationId],
    );

    final linksAsync = ref.watch(inviteLinksProvider);

    return linksAsync.when(
      data: (links) {
        if (links.isEmpty) {
          return _buildEmptyState(context, theme);
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(inviteLinksProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: links.length,
            itemBuilder: (context, index) {
              final link = links[index];
              return _InviteLinkCard(
                link: link,
                conversationId: conversationId,
                onRevoked: () => ref.invalidate(inviteLinksProvider),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(context, error, theme),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.link_rounded, size: 64, color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 24),
          const Text('No invite links yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Create a link to invite people to this group',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.error_outline_rounded, size: 64, color: Colors.red),
          ),
          const SizedBox(height: 24),
          const Text('Error loading invite links', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card displaying a single invite link
class _InviteLinkCard extends HookConsumerWidget {
  final InviteLink link;
  final int conversationId;
  final VoidCallback onRevoked;

  const _InviteLinkCard({required this.link, required this.conversationId, required this.onRevoked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    var inviteBaseUrl = dotenv.env['INVITE_BASE_URL'] ?? 'https://chattrix.app';
    // Remove trailing slash if present
    if (inviteBaseUrl.endsWith('/')) {
      inviteBaseUrl = inviteBaseUrl.substring(0, inviteBaseUrl.length - 1);
    }
    final fullLink = '$inviteBaseUrl/join/${link.token}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: link.revoked ? Border.all(color: Colors.red.withValues(alpha: 0.3), width: 2) : null,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: link.revoked
                        ? Colors.red.withValues(alpha: 0.1)
                        : theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    link.revoked ? Icons.link_off : Icons.link,
                    color: link.revoked ? Colors.red : theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        link.revoked ? 'Revoked Link' : 'Active Link',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Created by ${link.createdByUsername}',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (!link.revoked)
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                    onPressed: () => _showLinkOptionsBottomSheet(context, ref),
                  ),
              ],
            ),
          ),

          // Link
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fullLink,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      decoration: link.revoked ? TextDecoration.lineThrough : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!link.revoked)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: fullLink));
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Link copied to clipboard')));
                    },
                  ),
              ],
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildStatChip(
                  icon: Icons.people_outline,
                  label: '${link.currentUses}${link.maxUses != null ? '/${link.maxUses}' : ''} uses',
                  color: theme.colorScheme.primary,
                ),
                _buildStatChip(
                  icon: Icons.access_time,
                  label: _formatDate(link.createdAt),
                  color: theme.colorScheme.primary,
                ),
                if (link.revoked && link.revokedAt != null)
                  _buildStatChip(
                    icon: Icons.block,
                    label: 'Revoked ${_formatDate(link.revokedAt!)}',
                    color: Colors.red,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}d ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inMinutes}m ago';
    }
  }

  void _showLinkOptionsBottomSheet(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // QR Code option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.qr_code, color: colors.primary),
              ),
              title: const Text('Show QR Code'),
              onTap: () {
                Navigator.pop(context);
                _showQrCodeBottomSheet(context, ref);
              },
            ),

            // Revoke option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.block, color: Colors.red),
              ),
              title: const Text('Revoke Link', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showRevokeConfirmationBottomSheet(context, ref);
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showQrCodeBottomSheet(BuildContext context, WidgetRef ref) {
    // Get invite base URL from env
    var inviteBaseUrl = dotenv.env['INVITE_BASE_URL'] ?? 'https://chattrix.app';
    if (inviteBaseUrl.endsWith('/')) {
      inviteBaseUrl = inviteBaseUrl.substring(0, inviteBaseUrl.length - 1);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) =>
          _QrCodeBottomSheet(conversationId: conversationId, linkId: link.id, token: link.token, apiUrl: inviteBaseUrl),
    );
  }

  void _showRevokeConfirmationBottomSheet(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.block, size: 48, color: Colors.red),
            ),

            const SizedBox(height: 20),

            // Title
            Text('Revoke Link?', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            // Description
            Text(
              'This link will no longer work. Anyone with this link will not be able to join the group.',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _revokeLink(context, ref);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Revoke'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _revokeLink(BuildContext context, WidgetRef ref) async {
    final useCase = ref.read(revokeInviteLinkUseCaseProvider);
    final result = await useCase(conversationId: conversationId, linkId: link.id);

    if (!context.mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to revoke link: ${failure.message}')));
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link revoked successfully')));
        onRevoked();
      },
    );
  }
}

/// Bottom sheet for creating a new invite link
class _CreateInviteLinkBottomSheet extends HookConsumerWidget {
  final int conversationId;

  const _CreateInviteLinkBottomSheet({required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final expiresInDaysController = useTextEditingController();
    final maxUsesController = useTextEditingController();
    final isCreating = useState(false);

    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text('Create Invite Link', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

          const SizedBox(height: 20),

          // Expires in days
          TextField(
            controller: expiresInDaysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Expires in days (optional)',
              hintText: 'e.g., 7',
              filled: true,
              fillColor: colors.surfaceContainerHighest,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),

          const SizedBox(height: 16),

          // Max uses
          TextField(
            controller: maxUsesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Max uses (optional)',
              hintText: 'e.g., 100',
              filled: true,
              fillColor: colors.surfaceContainerHighest,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isCreating.value ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: isCreating.value
                      ? null
                      : () async {
                          isCreating.value = true;
                          final expiresInDays = int.tryParse(expiresInDaysController.text);
                          final maxUses = int.tryParse(maxUsesController.text);
                          await _createLink(context, ref, expiresInDays, maxUses);
                          isCreating.value = false;
                        },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isCreating.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Create'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _createLink(BuildContext context, WidgetRef ref, int? expiresInDays, int? maxUses) async {
    final useCase = ref.read(createInviteLinkUseCaseProvider);
    final result = await useCase(conversationId: conversationId, expiresInDays: expiresInDays, maxUses: maxUses);

    if (!context.mounted) return;

    result.fold(
      (failure) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create link: ${failure.message}')));
      },
      (link) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link created successfully')));
        // Refresh the list
        ref.invalidate(getInviteLinksUseCaseProvider);
      },
    );
  }
}

/// Bottom sheet for displaying QR code
class _QrCodeBottomSheet extends HookConsumerWidget {
  final int conversationId;
  final int linkId;
  final String token;
  final String apiUrl;

  const _QrCodeBottomSheet({
    required this.conversationId,
    required this.linkId,
    required this.token,
    required this.apiUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Create provider for QR code with apiUrl parameter
    final qrCodeProvider = useMemoized(
      () => FutureProvider<Uint8List>((ref) async {
        final useCase = ref.read(getQrCodeUseCaseProvider);
        // Pass apiUrl to backend so it generates correct URL
        final result = await useCase(conversationId: conversationId, linkId: linkId, apiUrl: apiUrl);
        return result.fold((failure) => throw Exception(failure.message), (bytes) => Uint8List.fromList(bytes));
      }),
      [conversationId, linkId, apiUrl],
    );

    final qrAsync = ref.watch(qrCodeProvider);

    // Generate the expected invite URL for display
    final inviteUrl = '$apiUrl/join/$token';

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text('Scan QR Code', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

          const SizedBox(height: 24),

          // QR Code
          qrAsync.when(
            data: (qrBytes) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Image.memory(qrBytes, width: 250, height: 250),
                ),
                const SizedBox(height: 16),
                // URL display
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    inviteUrl,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: colors.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            loading: () => const SizedBox(width: 250, height: 250, child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 8),
                    Text('Failed to load QR code', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      error.toString(),
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Close button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
