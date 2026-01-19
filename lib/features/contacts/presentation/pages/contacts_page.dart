import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/search_users_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactsPage extends HookConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactState = ref.watch(contactProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    final tabController = useTabController(initialLength: 3);

    // Load data when page opens
    useEffect(() {
      Future.microtask(() {
        ref.read(contactProvider.notifier).loadContacts();
        ref.read(contactProvider.notifier).loadReceivedFriendRequests();
        ref.read(contactProvider.notifier).loadSentFriendRequests();
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context, ref, contactState, isDark, colors, tabController),
      body: Column(
        children: [
          // Search Bar
          _HeaderSearch(
            isDark: isDark,
            onSearchChanged: (_) {},
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _ContactsTab(contactState: contactState),
                _SentRequestsTab(contactState: contactState),
                _ReceivedRequestsTab(contactState: contactState),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    ContactState contactState,
    bool isDark,
    ColorScheme colors,
    TabController tabController,
  ) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 60,
      title: Text(
        'Contacts',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(49),
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              labelColor: colors.primary,
              unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
              indicatorColor: colors.primary,
              labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Friends'),
                      if (contactState.contacts.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.contacts.length}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
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
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.outline.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.sentRequests.length}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.grey[300] : Colors.grey[700],
                            ),
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
                      const Text('Received'),
                      if (contactState.receivedRequests.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.receivedRequests.length}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 0.5,
              color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HEADER SEARCH
// ============================================================================

class _HeaderSearch extends StatelessWidget {
  final bool isDark;
  final Function(String) onSearchChanged;

  const _HeaderSearch({
    required this.isDark,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);
    final iconColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchUsersPage(),
            ),
          );
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 10),
                child: Icon(Icons.search, color: iconColor, size: 20),
              ),
              Expanded(
                child: Text(
                  'Search users to add',
                  style: TextStyle(fontSize: 15, color: iconColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// TAB 1: CONTACTS (FRIENDS)
// ============================================================================

class _ContactsTab extends ConsumerWidget {
  final ContactState contactState;

  const _ContactsTab({required this.contactState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (contactState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (contactState.errorMessage != null) {
      return _buildErrorState(ref, contactState, isDark);
    }

    if (contactState.contacts.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contactProvider.notifier).loadContacts(),
      child: ListView.builder(
        itemCount: contactState.contacts.length,
        itemBuilder: (context, index) {
          final contact = contactState.contacts[index];
          return _ContactListItem(contact: contact, isDark: isDark);
        },
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, ContactState state, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: isDark ? Colors.red[300] : Colors.red),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.read(contactProvider.notifier).loadContacts(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No contacts yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Search and add friends to start chatting',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactListItem extends ConsumerWidget {
  final dynamic contact;
  final bool isDark;

  const _ContactListItem({required this.contact, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: () {
        // TODO: Navigate to chat with this contact
        debugPrint('Tapped on contact: ${contact.fullName}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                UserAvatar(
                  displayName: contact.fullName,
                  avatarUrl: contact.avatarUrl,
                  radius: 28,
                ),
                if (contact.favorite)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: const Icon(Icons.star, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.nickname ?? contact.fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.nickname != null ? contact.fullName : '@${contact.username ?? ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Start audio call
                    debugPrint('Audio call to ${contact.fullName}');
                  },
                  icon: Icon(
                    Icons.phone,
                    color: colors.primary,
                    size: 22,
                  ),
                  tooltip: 'Audio call',
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    // TODO: Start video call
                    debugPrint('Video call to ${contact.fullName}');
                  },
                  icon: Icon(
                    Icons.videocam,
                    color: colors.primary,
                    size: 22,
                  ),
                  tooltip: 'Video call',
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {
                    // TODO: Navigate to chat
                    debugPrint('Message to ${contact.fullName}');
                  },
                  icon: Icon(
                    Icons.message,
                    color: colors.primary,
                    size: 22,
                  ),
                  tooltip: 'Message',
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// TAB 2: SENT REQUESTS
// ============================================================================

class _SentRequestsTab extends ConsumerWidget {
  final ContactState contactState;

  const _SentRequestsTab({required this.contactState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    if (contactState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (contactState.sentRequests.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contactProvider.notifier).loadSentFriendRequests(),
      child: ListView.builder(
        itemCount: contactState.sentRequests.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final request = contactState.sentRequests[index];
          return _SentRequestItem(request: request, isDark: isDark, colors: colors);
        },
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.send_outlined,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No sent requests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You haven\'t sent any requests',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SentRequestItem extends ConsumerWidget {
  final dynamic request;
  final bool isDark;
  final ColorScheme colors;

  const _SentRequestItem({
    required this.request,
    required this.isDark,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            UserAvatar(
              displayName: request.receiverFullName,
              avatarUrl: request.receiverAvatarUrl,
              radius: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.receiverFullName,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${request.receiverUsername}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pending • ${timeago.format(request.createdAt)}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: isDark ? Colors.grey[500] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final success = await ref.read(contactProvider.notifier).cancelFriendRequest(request.id);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request cancelled')),
                    );
                  } else if (context.mounted) {
                    final error = ref.read(contactProvider).errorMessage;
                    if (error != null && error.contains('not found')) {
                      // Request already processed, refresh list
                      await ref.read(contactProvider.notifier).loadSentFriendRequests();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request already processed')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error ?? 'Failed to cancel request')),
                      );
                    }
                  }
                } catch (e) {
                  debugPrint('Error cancelling request: $e');
                  if (context.mounted) {
                    // Refresh list in case of error
                    await ref.read(contactProvider.notifier).loadSentFriendRequests();
                  }
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: colors.error,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// TAB 3: RECEIVED REQUESTS
// ============================================================================

class _ReceivedRequestsTab extends ConsumerWidget {
  final ContactState contactState;

  const _ReceivedRequestsTab({required this.contactState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

    if (contactState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (contactState.receivedRequests.isEmpty) {
      return _buildEmptyState(isDark);
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(contactProvider.notifier).loadReceivedFriendRequests(),
      child: ListView.builder(
        itemCount: contactState.receivedRequests.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final request = contactState.receivedRequests[index];
          return _ReceivedRequestItem(request: request, isDark: isDark, colors: colors);
        },
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No friend requests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You have no pending requests',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceivedRequestItem extends ConsumerWidget {
  final dynamic request;
  final bool isDark;
  final ColorScheme colors;

  const _ReceivedRequestItem({
    required this.request,
    required this.isDark,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                UserAvatar(
                  displayName: request.senderFullName,
                  avatarUrl: request.senderAvatarUrl,
                  radius: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.senderFullName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${request.senderUsername}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeago.format(request.createdAt),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final success = await ref.read(contactProvider.notifier).acceptFriendRequest(request.id);
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Accepted ${request.senderFullName}\'s request'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (context.mounted) {
                          final error = ref.read(contactProvider).errorMessage;
                          if (error != null && error.contains('not found')) {
                            await ref.read(contactProvider.notifier).loadReceivedFriendRequests();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request already processed')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error ?? 'Failed to accept request')),
                            );
                          }
                        }
                      } catch (e) {
                        debugPrint('Error accepting request: $e');
                        if (context.mounted) {
                          await ref.read(contactProvider.notifier).loadReceivedFriendRequests();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      try {
                        final success = await ref.read(contactProvider.notifier).rejectFriendRequest(request.id);
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Request rejected')),
                          );
                        } else if (context.mounted) {
                          final error = ref.read(contactProvider).errorMessage;
                          if (error != null && error.contains('not found')) {
                            await ref.read(contactProvider.notifier).loadReceivedFriendRequests();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request already processed')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error ?? 'Failed to reject request')),
                            );
                          }
                        }
                      } catch (e) {
                        debugPrint('Error rejecting request: $e');
                        if (context.mounted) {
                          await ref.read(contactProvider.notifier).loadReceivedFriendRequests();
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.error,
                      side: BorderSide(color: colors.error),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
