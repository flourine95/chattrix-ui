import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/invite_links_list_provider.dart';
import '../providers/invite_links_websocket_provider.dart';
import '../widgets/invite_link_card.dart';
import '../widgets/create_invite_link_bottom_sheet.dart';

/// Page for managing group invite links
class InviteLinksPage extends HookConsumerWidget {
  const InviteLinksPage({super.key, required this.conversationId, required this.conversationName});

  final int conversationId;
  final String conversationName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final scrollController = useScrollController();

    // Initialize WebSocket listener
    ref.watch(inviteLinksWebSocketListenerProvider);

    // Watch providers
    final linksAsync = ref.watch(inviteLinksListProvider(conversationId));
    final linksNotifier = ref.read(inviteLinksListProvider(conversationId).notifier);

    // Listen to scroll for pagination
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
          if (linksNotifier.hasNextPage && !linksAsync.isLoading) {
            linksNotifier.loadMore(conversationId);
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Link mời', style: textTheme.titleMedium),
            Text(
              conversationName,
              style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            ),
          ],
        ),
        actions: [
          // Toggle include revoked
          IconButton(
            icon: Icon(
              linksNotifier.includeRevoked ? Icons.visibility : Icons.visibility_off,
              color: linksNotifier.includeRevoked ? colors.primary : null,
            ),
            tooltip: linksNotifier.includeRevoked ? 'Ẩn link đã thu hồi' : 'Hiện link đã thu hồi',
            onPressed: () => linksNotifier.toggleIncludeRevoked(conversationId),
          ),
        ],
      ),
      body: linksAsync.when(
        data: (links) {
          if (links.isEmpty) {
            return _buildEmptyState(context);
          }

          return RefreshIndicator(
            onRefresh: () => linksNotifier.refresh(conversationId),
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: links.length + (linksNotifier.hasNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == links.length) {
                  return const Center(
                    child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
                  );
                }

                final link = links[index];
                return InviteLinkCard(
                  link: link,
                  conversationId: conversationId,
                  onRevoked: () {
                    // Refresh list after revoke
                    linksNotifier.refresh(conversationId);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error.toString(), () {
          linksNotifier.refresh(conversationId);
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateLinkBottomSheet(context, ref),
        icon: const Icon(Icons.add_link),
        label: const Text('Tạo link mới'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.link_off, size: 80, color: colors.onSurface.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            'Chưa có link mời nào',
            style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 8),
          Text(
            'Tạo link mời để chia sẻ với người khác',
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
          Text('Có lỗi xảy ra', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            error,
            style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Thử lại')),
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
          // Add to list
          ref.read(inviteLinksListProvider(conversationId).notifier).addLink(link);

          // Show success message
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tạo link mời thành công')));
          }
        },
      ),
    );
  }
}
