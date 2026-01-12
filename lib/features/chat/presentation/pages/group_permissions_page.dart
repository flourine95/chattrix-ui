import 'package:flutter/material.dart';

class GroupPermissionsPage extends StatefulWidget {
  const GroupPermissionsPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<GroupPermissionsPage> createState() => _GroupPermissionsPageState();
}

class _GroupPermissionsPageState extends State<GroupPermissionsPage> {
  // Demo permission states (ALL = true, ADMIN_ONLY = false)
  final Map<String, bool> _permissions = {
    'send_messages': true,
    'add_members': false,
    'edit_group_info': false,
    'delete_messages': false,
    'pin_messages': false,
    'remove_members': false,
    'create_polls': false,
  };

  final Map<String, Map<String, String>> _permissionDetails = {
    'send_messages': {
      'title': 'Send Messages',
      'subtitle': 'Allow all members to send messages',
      'icon': 'chat',
    },
    'add_members': {
      'title': 'Add Members',
      'subtitle': 'Allow all members to add new people',
      'icon': 'person_add',
    },
    'edit_group_info': {
      'title': 'Edit Group Info',
      'subtitle': 'Allow all members to edit name, photo, description',
      'icon': 'edit',
    },
    'delete_messages': {
      'title': 'Delete Messages',
      'subtitle': 'Allow all members to delete any message',
      'icon': 'delete',
    },
    'pin_messages': {
      'title': 'Pin Messages',
      'subtitle': 'Allow all members to pin messages',
      'icon': 'push_pin',
    },
    'remove_members': {
      'title': 'Remove Members',
      'subtitle': 'Allow all members to remove others',
      'icon': 'person_remove',
    },
    'create_polls': {
      'title': 'Create Polls',
      'subtitle': 'Allow all members to create polls',
      'icon': 'poll',
    },
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Permissions'),
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: colors.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.admin_panel_settings, color: colors.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Control Group Actions',
                            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose who can perform each action in this group',
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Permissions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _permissions.length,
              itemBuilder: (context, index) {
                final key = _permissions.keys.elementAt(index);
                final details = _permissionDetails[key]!;
                final value = _permissions[key]!;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SwitchListTile(
                    secondary: Icon(
                      _getIconData(details['icon']!),
                      color: colors.primary,
                    ),
                    title: Text(
                      details['title']!,
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(details['subtitle']!),
                    value: value,
                    onChanged: (newValue) {
                      setState(() {
                        _permissions[key] = newValue;
                      });
                      _updatePermission(key, newValue);
                    },
                  ),
                );
              },
            ),
          ),

          // Footer Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: 0.3),
              border: Border(top: BorderSide(color: colors.outline.withValues(alpha: 0.2))),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: colors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'ON = All members can perform this action\nOFF = Only admins can perform this action',
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'chat': return Icons.chat;
      case 'person_add': return Icons.person_add;
      case 'edit': return Icons.edit;
      case 'delete': return Icons.delete;
      case 'push_pin': return Icons.push_pin;
      case 'person_remove': return Icons.person_remove;
      case 'poll': return Icons.poll;
      default: return Icons.settings;
    }
  }

  void _updatePermission(String permission, bool value) {
    // TODO: Call API to update permission
    // POST /api/conversations/{conversationId}/permissions
    // Body: { "permission": "send_messages", "value": "ALL" | "ADMIN_ONLY" }
    final apiValue = value ? "ALL" : "ADMIN_ONLY";
    print('Update $permission to $apiValue');
    
    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_permissionDetails[permission]!['title']} updated to $apiValue'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

