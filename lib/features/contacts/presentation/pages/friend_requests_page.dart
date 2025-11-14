import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FriendRequestsPage extends ConsumerStatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  ConsumerState<FriendRequestsPage> createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends ConsumerState<FriendRequestsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(contactProvider.notifier).loadReceivedFriendRequests();
      ref.read(contactProvider.notifier).loadSentFriendRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(contactProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Friend Requests'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Received'),
              Tab(text: 'Sent'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Received requests tab
            _buildReceivedRequestsList(state, colorScheme),
            // Sent requests tab
            _buildSentRequestsList(state, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildReceivedRequestsList(ContactState state, ColorScheme colorScheme) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.receivedRequests.isEmpty) {
      return const Center(
        child: Text('No received friend requests'),
      );
    }

    return ListView.builder(
      itemCount: state.receivedRequests.length,
      itemBuilder: (context, index) {
        final request = state.receivedRequests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: request.senderAvatarUrl != null
                  ? NetworkImage(request.senderAvatarUrl!)
                  : null,
              child: request.senderAvatarUrl == null
                  ? Text(request.senderUsername[0].toUpperCase())
                  : null,
            ),
            title: Text(request.senderFullName),
            subtitle: Text('@${request.senderUsername}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () async {
                    final success = await ref
                        .read(contactProvider.notifier)
                        .acceptFriendRequest(request.id);
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Friend request accepted'),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () async {
                    final success = await ref
                        .read(contactProvider.notifier)
                        .rejectFriendRequest(request.id);
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Friend request rejected'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSentRequestsList(ContactState state, ColorScheme colorScheme) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.sentRequests.isEmpty) {
      return const Center(
        child: Text('No sent friend requests'),
      );
    }

    return ListView.builder(
      itemCount: state.sentRequests.length,
      itemBuilder: (context, index) {
        final request = state.sentRequests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: request.receiverAvatarUrl != null
                  ? NetworkImage(request.receiverAvatarUrl!)
                  : null,
              child: request.receiverAvatarUrl == null
                  ? Text(request.receiverUsername[0].toUpperCase())
                  : null,
            ),
            title: Text(request.receiverFullName),
            subtitle: Text('@${request.receiverUsername}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  label: Text(
                    request.status.name.toUpperCase(),
                    style: TextStyle(
                      color: colorScheme.onSecondaryContainer,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: colorScheme.secondaryContainer,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () async {
                    final success = await ref
                        .read(contactProvider.notifier)
                        .cancelFriendRequest(request.id);
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Friend request cancelled'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

