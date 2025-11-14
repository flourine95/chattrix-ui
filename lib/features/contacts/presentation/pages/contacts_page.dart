import 'package:chattrix_ui/features/contacts/presentation/pages/friend_requests_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/send_friend_request_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  @override
  void initState() {
    super.initState();
    // Load contacts when page is initialized
    Future.microtask(() {
      ref.read(contactProvider.notifier).loadContacts();
      ref.read(contactProvider.notifier).loadReceivedFriendRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(contactProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: textTheme.titleLarge),
        actions: [
          // Show badge if there are pending friend requests
          if (state.receivedRequests.isNotEmpty)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FriendRequestsPage(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${state.receivedRequests.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FriendRequestsPage(),
                  ),
                );
              },
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.errorMessage}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(contactProvider.notifier).loadContacts();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : state.contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No contacts yet',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add friends to start chatting',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(contactProvider.notifier).loadContacts();
              },
              child: ListView.separated(
                itemCount: state.contacts.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: contact.avatarUrl != null
                          ? NetworkImage(contact.avatarUrl!)
                          : null,
                      child: contact.avatarUrl == null
                          ? Text(contact.fullName.substring(0, 1))
                          : null,
                    ),
                    title: Text(
                      contact.nickname ?? contact.fullName,
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@${contact.username}',
                          style: textTheme.bodySmall,
                        ),
                        if (contact.isOnline)
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Online',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () {
                        // TODO: Navigate to chat page
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SendFriendRequestPage(),
            ),
          );
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
