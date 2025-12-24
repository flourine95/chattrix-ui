import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMembersPage extends StatefulWidget {
  const AddMembersPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<AddMembersPage> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedUsers = {};

  // Hardcoded contacts for demo
  final List<Map<String, dynamic>> _allContacts = [
    {'id': '1', 'name': 'Alice Johnson', 'username': '@alice', 'isOnline': true},
    {'id': '2', 'name': 'Bob Smith', 'username': '@bob', 'isOnline': false},
    {'id': '3', 'name': 'Charlie Brown', 'username': '@charlie', 'isOnline': true},
    {'id': '4', 'name': 'Diana Prince', 'username': '@diana', 'isOnline': true},
    {'id': '5', 'name': 'Ethan Hunt', 'username': '@ethan', 'isOnline': false},
    {'id': '6', 'name': 'Fiona Green', 'username': '@fiona', 'isOnline': true},
    {'id': '7', 'name': 'George Wilson', 'username': '@george', 'isOnline': false},
    {'id': '8', 'name': 'Hannah Lee', 'username': '@hannah', 'isOnline': true},
  ];

  List<Map<String, dynamic>> get _filteredContacts {
    if (_searchController.text.isEmpty) return _allContacts;
    return _allContacts.where((contact) {
      final name = contact['name'].toString().toLowerCase();
      final username = contact['username'].toString().toLowerCase();
      final query = _searchController.text.toLowerCase();
      return name.contains(query) || username.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Add Members',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_selectedUsers.isNotEmpty)
            TextButton(
              onPressed: () {
                // TODO: Implement add members API call
                context.pop();
              },
              child: Text('Add (${_selectedUsers.length})'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),

          // Selected users chips
          if (_selectedUsers.isNotEmpty)
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedUsers.length,
                itemBuilder: (context, index) {
                  final userId = _selectedUsers.elementAt(index);
                  final user = _allContacts.firstWhere((c) => c['id'] == userId);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      avatar: UserAvatar(
                        displayName: user['name'],
                        avatarUrl: null,
                        radius: 16,
                      ),
                      label: Text(user['name']),
                      onDeleted: () {
                        setState(() => _selectedUsers.remove(userId));
                      },
                    ),
                  );
                },
              ),
            ),

          // Contacts list
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                final isSelected = _selectedUsers.contains(contact['id']);
                final isOnline = contact['isOnline'] as bool;

                return ListTile(
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserAvatar(
                        displayName: contact['name'],
                        avatarUrl: null,
                        radius: 24,
                      ),
                      if (isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.surface, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    contact['name'],
                    style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    contact['username'],
                    style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedUsers.add(contact['id']);
                        } else {
                          _selectedUsers.remove(contact['id']);
                        }
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedUsers.remove(contact['id']);
                      } else {
                        _selectedUsers.add(contact['id']);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

