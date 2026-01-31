import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_links_history_provider.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_links_websocket_provider.dart';
import 'package:chattrix_ui/features/invite_links/presentation/widgets/create_invite_link_bottom_sheet.dart';
import 'package:chattrix_ui/features/invite_links/presentation/widgets/invite_link_history_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InviteLinksPage extends HookConsumerWidget {
  const InviteLinksPage({super.key, required this.conversationId, required this.conversationName});

  final int conversationId;
  final String conversationName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('🔵 [InviteLinksPage] Building page for conversation $conversationId');
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    ref.watch(inviteLinksWebSocketListenerProvider);

    final historyAsync = ref.watch(inviteLinksHistoryProvider(conversationId));
    debugPrint('🔵 [InviteLinksPage] historyAsync state: ${historyAsync.runtimeType}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invite Links', style: textTheme.titleMedium),
            Text(
              conversationName,
              style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
      body: historyAsync.when(
        data: (history) {
          if (history.items.isEmpty) {
            return _buildEmptyState(context, ref);
          }

          final hasActiveLink = history.items.any((link) => link.isActive);

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.items.length + (history.meta.hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == history.items.length) {
                  // Load more indicator
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: FilledButton.icon(
                        onPressed: () {
                          ref.read(inviteLinksHistoryProvider(conversationId).notifier).loadMore();
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Load More'),
                      ),
                    ),
                  );
                }

                final link = history.items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InviteLinkHistoryCard(
                    link: link,
                    conversationId: conversationId,
                    onRevoked: () {
                      ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh();
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(
          context,
          error.toString(),
          () => ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh(),
        ),
      ),
      floatingActionButton: historyAsync.maybeWhen(
        data: (history) {
          final hasActiveLink = history.items.any((link) => link.isActive);
          // Only show create button if no active link exists
          return !hasActiveLink
              ? FloatingActionButton.extended(
                  onPressed: () => _showCreateLinkBottomSheet(context, ref),
                  icon: const Icon(Icons.add_link),
                  label: const Text('Create Link'),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                )
              : null;
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.link_off, size: 80, color: colors.onSurface.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            'No invite links',
            style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 8),
          Text(
            'Create an invite link to share with others',
            style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showCreateLinkBottomSheet(context, ref),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.add_link),
            label: const Text('Create Link'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error, VoidCallback onRetry) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: colors.error),
          const SizedBox(height: 16),
          Text('Something went wrong', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            error,
            style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showCreateLinkBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CreateInviteLinkBottomSheet(
        conversationId: conversationId,
        onCreated: (link) {
          // Refresh the history list to show the new link
          ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Invite link created successfully'),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }
}
