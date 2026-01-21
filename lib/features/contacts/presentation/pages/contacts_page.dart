import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_item.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_history_provider.dart';
import 'package:chattrix_ui/core/domain/enums/conversation_type.dart';
import 'package:chattrix_ui/core/extensions/user_online_extension.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/search_users_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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

    final tabController = useTabController(initialLength: 4);

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
      body: TabBarView(
        controller: tabController,
        children: [
          _ContactsTab(contactState: contactState),
          _SentRequestsTab(contactState: contactState),
          _ReceivedRequestsTab(contactState: contactState),
          _CallHistoryTab(),
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
        preferredSize: const Size.fromHeight(109), // Increased for search bar + tabs
        child: Column(
          children: [
            // Search Bar - Above tabs
            _HeaderSearch(
              isDark: isDark,
              onSearchChanged: (_) {},
            ),
            // Tabs
            TabBar(
              controller: tabController,
              labelColor: colors.primary,
              unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
              indicatorColor: colors.primary,
              labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
              isScrollable: false, // Changed to false for equal width
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Flexible(child: Text('Friends', overflow: TextOverflow.ellipsis)),
                      if (contactState.contacts.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.contacts.length}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
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
                      const Flexible(child: Text('Sent', overflow: TextOverflow.ellipsis)),
                      if (contactState.sentRequests.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.outline.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.sentRequests.length}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
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
                      const Flexible(child: Text('Received', overflow: TextOverflow.ellipsis)),
                      if (contactState.receivedRequests.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contactState.receivedRequests.length}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Tab(child: Text('History', overflow: TextOverflow.ellipsis)),
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
  final Contact contact;
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
                // Online status indicator
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: contact.isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                  ),
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
                    contact.nickname != null ? contact.fullName : '@${contact.username}',
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
                  onPressed: () async {
                    // Start audio call
                    debugPrint('📞 Starting audio call to ${contact.fullName}');
                    
                    // Get or create conversation
                    final conversationId = await _getOrCreateConversation(ref, contact.contactUserId);
                    if (conversationId != null && context.mounted) {
                      // Initiate audio call
                      ref.read(callProvider.notifier).initiateCall(
                        conversationId,
                        CallType.audio,
                        conversationName: contact.nickname ?? contact.fullName,
                        conversationAvatar: contact.avatarUrl,
                      );
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to start call')),
                      );
                    }
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
                  onPressed: () async {
                    // Start video call
                    debugPrint('📹 Starting video call to ${contact.fullName}');
                    
                    // Get or create conversation
                    final conversationId = await _getOrCreateConversation(ref, contact.contactUserId);
                    if (conversationId != null && context.mounted) {
                      // Initiate video call
                      ref.read(callProvider.notifier).initiateCall(
                        conversationId,
                        CallType.video,
                        conversationName: contact.nickname ?? contact.fullName,
                        conversationAvatar: contact.avatarUrl,
                      );
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to start call')),
                      );
                    }
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
                  onPressed: () async {
                    // Navigate to chat
                    debugPrint('💬 Opening chat with ${contact.fullName}');
                    
                    // Get or create conversation
                    final conversationId = await _getOrCreateConversation(ref, contact.contactUserId);
                    if (conversationId != null && context.mounted) {
                      // Navigate to chat view
                      context.push('/chat/$conversationId');
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to open chat')),
                      );
                    }
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
    return Container(
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
          UserAvatar(
            displayName: request.receiverFullName,
            avatarUrl: request.receiverAvatarUrl,
            radius: 28,
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
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '@${request.receiverUsername}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pending • ${timeago.format(request.createdAt)}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
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
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@${request.senderUsername}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeago.format(request.createdAt),
                      style: GoogleFonts.inter(
                        fontSize: 12,
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
    );
  }
}

// Helper function to get or create conversation with a contact
Future<int?> _getOrCreateConversation(WidgetRef ref, int userId) async {
  try {
    // Get all conversations
    final conversationsAsync = ref.read(conversationsProvider);
    
    if (conversationsAsync.hasValue) {
      final conversations = conversationsAsync.value!;
      
      // Find existing 1-1 conversation with this user
      try {
        final existingConversation = conversations.firstWhere(
          (conv) => conv.type == ConversationType.direct && 
                    conv.participants.any((p) => p.userId == userId),
        );
        
        debugPrint('✅ Found existing conversation: ${existingConversation.id}');
        return existingConversation.id;
      } catch (e) {
        // No existing conversation found, will create new one
        debugPrint('📝 No existing conversation found');
      }
    }
    
    // If no existing conversation, create new one
    debugPrint('📝 Creating new conversation with user $userId');
    final result = await ref.read(createConversationUsecaseProvider).call(
      type: 'DIRECT',
      participantIds: [userId],
    );
    
    return result.fold(
      (failure) {
        debugPrint('❌ Failed to create conversation: ${failure.message}');
        return null;
      },
      (conversation) {
        debugPrint('✅ Created new conversation: ${conversation.id}');
        // Optimistically add conversation to list immediately
        ref.read(conversationsProvider.notifier).addConversation(conversation);
        return conversation.id;
      },
    );
  } catch (e) {
    debugPrint('❌ Error getting/creating conversation: $e');
    return null;
  }
}


// ============================================================================
// TAB 4: CALL HISTORY
// ============================================================================

enum CallHistoryFilter { all, missed, incoming, outgoing }

class _CallHistoryTab extends HookConsumerWidget {
  const _CallHistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final selectedFilter = useState(CallHistoryFilter.all);

    // Load call history on mount
    useEffect(() {
      Future.microtask(() {
        ref.read(callHistoryProvider.notifier).refresh();
      });
      return null;
    }, []);

    // Watch call history state
    final callHistoryAsync = ref.watch(callHistoryProvider);

    // Filter logic
    List<CallHistoryItem> getFilteredHistory(List<CallHistoryItem> history) {
      return history.where((call) {
        switch (selectedFilter.value) {
          case CallHistoryFilter.missed:
            return call.isMissed;
          case CallHistoryFilter.incoming:
            return call.type == CallHistoryType.incoming && !call.isMissed;
          case CallHistoryFilter.outgoing:
            return call.type == CallHistoryType.outgoing;
          case CallHistoryFilter.all:
            return true;
        }
      }).toList();
    }

    return Column(
      children: [
        // Filter chips
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: selectedFilter.value == CallHistoryFilter.all,
                  onTap: () => selectedFilter.value = CallHistoryFilter.all,
                  isDark: isDark,
                  colors: colors,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Missed',
                  isSelected: selectedFilter.value == CallHistoryFilter.missed,
                  onTap: () => selectedFilter.value = CallHistoryFilter.missed,
                  isDark: isDark,
                  colors: colors,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Incoming',
                  isSelected: selectedFilter.value == CallHistoryFilter.incoming,
                  onTap: () => selectedFilter.value = CallHistoryFilter.incoming,
                  isDark: isDark,
                  colors: colors,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Outgoing',
                  isSelected: selectedFilter.value == CallHistoryFilter.outgoing,
                  onTap: () => selectedFilter.value = CallHistoryFilter.outgoing,
                  isDark: isDark,
                  colors: colors,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
        ),
        // Call history list
        Expanded(
          child: switch (callHistoryAsync) {
            AsyncData(:final value) => () {
                final filteredHistory = getFilteredHistory(value);
                if (filteredHistory.isEmpty) {
                  return _buildEmptyState(isDark, selectedFilter.value);
                }
                return RefreshIndicator(
                  onRefresh: () => ref.read(callHistoryProvider.notifier).refresh(),
                  child: ListView.builder(
                    itemCount: filteredHistory.length,
                    itemBuilder: (context, index) {
                      final call = filteredHistory[index];
                      return _CallHistoryListItem(call: call, isDark: isDark, colors: colors);
                    },
                  ),
                );
              }(),
            AsyncError(:final error) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: isDark ? Colors.red[300] : Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load call history',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => ref.read(callHistoryProvider.notifier).refresh(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState(bool isDark, CallHistoryFilter filter) {
    String message;
    switch (filter) {
      case CallHistoryFilter.missed:
        message = 'No missed calls';
        break;
      case CallHistoryFilter.incoming:
        message = 'No incoming calls';
        break;
      case CallHistoryFilter.outgoing:
        message = 'No outgoing calls';
        break;
      case CallHistoryFilter.all:
        message = 'No call history';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_disabled,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your call history will appear here',
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

// Filter chip widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final ColorScheme colors;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    required this.colors,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? colors.primary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? chipColor.withValues(alpha: 0.2)
              : (isDark ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: chipColor, width: 1.5)
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? chipColor
                : (isDark ? Colors.grey[400] : Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}

// Call history item widget
class _CallHistoryListItem extends StatelessWidget {
  final CallHistoryItem call;
  final bool isDark;
  final ColorScheme colors;

  const _CallHistoryListItem({
    required this.call,
    required this.isDark,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = call.isMissed ? Colors.red : colors.primary;
    
    return InkWell(
      onTap: () {
        // TODO: Show call details or initiate new call
        debugPrint('Tapped on call history: ${call.participantName}');
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
            UserAvatar(
              displayName: call.participantName,
              avatarUrl: call.participantAvatar,
              radius: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.participantName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        call.type == CallHistoryType.incoming
                            ? Icons.call_received
                            : Icons.call_made,
                        size: 14,
                        color: iconColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        call.isMissed
                            ? 'Missed'
                            : (call.type == CallHistoryType.incoming ? 'Incoming' : 'Outgoing'),
                        style: TextStyle(
                          fontSize: 13,
                          color: call.isMissed ? Colors.red : (isDark ? Colors.grey[400] : Colors.grey[600]),
                        ),
                      ),
                      const Text(' • ', style: TextStyle(fontSize: 13)),
                      Text(
                        timeago.format(call.timestamp),
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  if (call.duration != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Duration: ${_formatDuration(call.duration!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              call.callType == CallType.video ? Icons.videocam : Icons.phone,
              color: iconColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
