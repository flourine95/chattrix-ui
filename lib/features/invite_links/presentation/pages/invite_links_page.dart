import 'package:chattrix_ui/features/chat/presentation/widgets/filter_chip_widget.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_links_history_provider.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/invite_links_providers.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.watch(inviteLinksWebSocketListenerProvider);

    final historyAsync = ref.watch(inviteLinksHistoryProvider(conversationId));
    final currentFilter = ref.watch(inviteLinksFilterProvider);
    debugPrint('🔵 [InviteLinksPage] historyAsync state: ${historyAsync.runtimeType}');

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('Invite Links', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_link, color: colors.primary),
            onPressed: () => _showCreateLinkBottomSheet(context, ref),
            tooltip: 'Create Link',
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
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                FilterChipWidget(
                  label: 'All',
                  isSelected: currentFilter == null,
                  onTap: () {
                    ref.read(inviteLinksFilterProvider.notifier).setFilter(null);
                    ref.read(inviteLinksHistoryProvider(conversationId).notifier).filterByStatus(null);
                  },
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Active',
                  isSelected: currentFilter == 'active',
                  onTap: () {
                    ref.read(inviteLinksFilterProvider.notifier).setFilter('active');
                    ref.read(inviteLinksHistoryProvider(conversationId).notifier).filterByStatus('active');
                  },
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Expired',
                  isSelected: currentFilter == 'expired',
                  onTap: () {
                    ref.read(inviteLinksFilterProvider.notifier).setFilter('expired');
                    ref.read(inviteLinksHistoryProvider(conversationId).notifier).filterByStatus('expired');
                  },
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Revoked',
                  isSelected: currentFilter == 'revoked',
                  onTap: () {
                    ref.read(inviteLinksFilterProvider.notifier).setFilter('revoked');
                    ref.read(inviteLinksHistoryProvider(conversationId).notifier).filterByStatus('revoked');
                  },
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Max Uses',
                  isSelected: currentFilter == 'max_uses_reached',
                  onTap: () {
                    ref.read(inviteLinksFilterProvider.notifier).setFilter('max_uses_reached');
                    ref.read(inviteLinksHistoryProvider(conversationId).notifier).filterByStatus('max_uses_reached');
                  },
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: historyAsync.when(
              data: (history) {
                if (history.items.isEmpty) {
                  return _buildEmptyState(context, ref);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: history.items.length + (history.meta.hasNextPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == history.items.length) {
                        // Load more button
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ref.read(inviteLinksHistoryProvider(conversationId).notifier).loadMore();
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(Icons.refresh, size: 20),
                              label: const Text('Load More'),
                            ),
                          ),
                        );
                      }

                      final link = history.items[index];
                      return InviteLinkHistoryCard(
                        link: link,
                        conversationId: conversationId,
                        onRevoked: () {
                          ref.read(inviteLinksHistoryProvider(conversationId).notifier).refresh();
                        },
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
          ),
        ],
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
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    const Text('Invite link created successfully', style: TextStyle(color: Colors.white)),
                  ],
                ),
                backgroundColor: Colors.grey.shade900,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }
}
