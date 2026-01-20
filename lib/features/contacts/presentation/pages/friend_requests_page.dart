import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendRequestsPage extends HookConsumerWidget {
  const FriendRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final contactState = ref.watch(contactProvider);

    final tabController = useTabController(initialLength: 2);

    // Load data
    useEffect(() {
      Future.microtask(() {
        ref.read(contactProvider.notifier).loadReceivedFriendRequests();
        ref.read(contactProvider.notifier).loadSentFriendRequests();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text('Friend Requests', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: colors.surface,
        elevation: 0,
        bottom: TabBar(
          controller: tabController,
          labelColor: colors.primary,
          unselectedLabelColor: colors.onSurfaceVariant,
          indicatorColor: colors.primary,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Received'),
                  if (contactState.receivedRequests.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        '${contactState.receivedRequests.length}',
                        style: GoogleFonts.inter(color: colors.onPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sent'),
                  if (contactState.sentRequests.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: colors.outline, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        '${contactState.sentRequests.length}',
                        style: GoogleFonts.inter(color: colors.onPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildReceivedTab(ref, contactState, colors, context),
          _buildSentTab(ref, contactState, colors, context),
        ],
      ),
    );
  }

  Widget _buildReceivedTab(WidgetRef ref, ContactState state, ColorScheme colors, BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.receivedRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.primaryContainer.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.inbox_outlined, size: 64, color: colors.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'No friend requests',
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: colors.onSurface),
              ),
              const SizedBox(height: 8),
              Text('You have no pending requests', style: GoogleFonts.inter(color: colors.onSurfaceVariant)),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contactProvider.notifier).loadReceivedFriendRequests(),
      child: ListView.builder(
        itemCount: state.receivedRequests.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final request = state.receivedRequests[index];

          // For received requests, show sender info
          final displayName = request.senderFullName;
          final displayUsername = request.senderUsername;
          final displayAvatar = request.senderAvatarUrl;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            color: colors.surfaceContainerLow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      UserAvatar(displayName: displayName, avatarUrl: displayAvatar, radius: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(displayName, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 2),
                            Text('@$displayUsername', style: GoogleFonts.inter(color: colors.primary, fontSize: 13)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: colors.outline),
                                const SizedBox(width: 4),
                                Text(
                                  timeago.format(request.createdAt),
                                  style: GoogleFonts.inter(color: colors.outline, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            final success = await ref.read(contactProvider.notifier).acceptFriendRequest(request.id);
                            if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Accepted $displayName\'s request'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Accept'),
                          style: FilledButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: colors.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final success = await ref.read(contactProvider.notifier).rejectFriendRequest(request.id);
                            if (success && context.mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(const SnackBar(content: Text('Request rejected')));
                            }
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('Reject'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colors.error,
                            side: BorderSide(color: colors.error),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSentTab(WidgetRef ref, ContactState state, ColorScheme colors, BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.sentRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.primaryContainer.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send_outlined, size: 64, color: colors.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'No sent requests',
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: colors.onSurface),
              ),
              const SizedBox(height: 8),
              Text('You haven\'t sent any requests', style: GoogleFonts.inter(color: colors.onSurfaceVariant)),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contactProvider.notifier).loadSentFriendRequests(),
      child: ListView.builder(
        itemCount: state.sentRequests.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final request = state.sentRequests[index];

          // For sent requests, show receiver info
          final displayName = request.receiverFullName;
          final displayUsername = request.receiverUsername;
          final displayAvatar = request.receiverAvatarUrl;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            color: colors.surfaceContainerLow,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  UserAvatar(displayName: displayName, avatarUrl: displayAvatar, radius: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 2),
                        Text('@$displayUsername', style: GoogleFonts.inter(color: colors.primary, fontSize: 13)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.schedule, size: 12, color: colors.onSecondaryContainer),
                              const SizedBox(width: 4),
                              Text(
                                'Pending • ${timeago.format(request.createdAt)}',
                                style: GoogleFonts.inter(
                                  color: colors.onSecondaryContainer,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () async {
                      final success = await ref.read(contactProvider.notifier).cancelFriendRequest(request.id);
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request cancelled')));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.error,
                      side: BorderSide(color: colors.error),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
