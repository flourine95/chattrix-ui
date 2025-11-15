import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MembersListWidget extends HookConsumerWidget {
  const MembersListWidget({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final me = ref.watch(currentUserProvider);

    // Check if current user is admin
    final myParticipant = conversation.participants.firstWhere(
      (p) => p.userId == me?.id,
      orElse: () => conversation.participants.first,
    );
    final isAdmin = myParticipant.role.toUpperCase() == 'ADMIN';

    return Column(
      children: [
        // Search bar and add member button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.1))),
          ),
          child: Column(
            children: [
              // Search input
              TextField(
                controller: searchController,
                onChanged: (value) => searchQuery.value = value,
                decoration: InputDecoration(
                  hintText: 'Search members...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            searchQuery.value = '';
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colors.surface.withValues(alpha: 0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
                  ),
                ),
              ),
              if (isAdmin) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement add member
                      _showAddMemberDialog(context);
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add Member'),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Members list
        Expanded(
          child: Builder(
            builder: (context) {
              // Filter members by search query
              final filteredMembers = conversation.participants.where((p) {
                if (searchQuery.value.isEmpty) return true;
                final query = searchQuery.value.toLowerCase();
                return p.fullName.toLowerCase().contains(query) || p.username.toLowerCase().contains(query);
              }).toList();

              // Sort: Admins first, then by name
              filteredMembers.sort((a, b) {
                if (a.role.toUpperCase() == 'ADMIN' && b.role.toUpperCase() != 'ADMIN') {
                  return -1;
                }
                if (a.role.toUpperCase() != 'ADMIN' && b.role.toUpperCase() == 'ADMIN') {
                  return 1;
                }
                return a.fullName.compareTo(b.fullName);
              });

              if (filteredMembers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        'No members found',
                        style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  final isMe = member.userId == me?.id;
                  final isMemberAdmin = member.role.toUpperCase() == 'ADMIN';

                  return _MemberListItem(
                    member: member,
                    isMe: isMe,
                    isAdmin: isMemberAdmin,
                    canManage: isAdmin && !isMe,
                    onTap: () {
                      // TODO: Show member profile
                    },
                    onManage: isAdmin && !isMe
                        ? () {
                            _showMemberManagementDialog(context, member, isMemberAdmin);
                          }
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    // TODO: Implement add member dialog with user search
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Member'),
        content: const Text('Feature in development'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  void _showMemberManagementDialog(BuildContext context, Participant member, bool isAdmin) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(member.fullName.isNotEmpty ? member.fullName.substring(0, 1).toUpperCase() : '?'),
              ),
              title: Text(member.fullName),
              subtitle: Text('@${member.username}'),
            ),
            const Divider(),
            if (!isAdmin)
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Make Admin'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmPromoteToAdmin(context, member);
                },
              ),
            if (isAdmin)
              ListTile(
                leading: const Icon(Icons.remove_moderator),
                title: const Text('Remove Admin'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDemoteFromAdmin(context, member);
                },
              ),
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.red),
              title: const Text('Remove from group', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmRemoveMember(context, member);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmPromoteToAdmin(BuildContext context, Participant member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Make Admin'),
        content: Text('Are you sure you want to make ${member.fullName} an admin?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Promote to admin
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _confirmDemoteFromAdmin(BuildContext context, Participant member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Admin'),
        content: Text('Are you sure you want to remove admin privileges from ${member.fullName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Demote from admin
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _confirmRemoveMember(BuildContext context, Participant member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Member'),
        content: Text('Are you sure you want to remove ${member.fullName} from the group?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              // TODO: Remove member
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _MemberListItem extends StatelessWidget {
  const _MemberListItem({
    required this.member,
    required this.isMe,
    required this.isAdmin,
    required this.canManage,
    required this.onTap,
    this.onManage,
  });

  final Participant member;
  final bool isMe;
  final bool isAdmin;
  final bool canManage;
  final VoidCallback onTap;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.onSurface.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: colors.primary,
              child: Text(
                member.fullName.isNotEmpty ? member.fullName.substring(0, 1).toUpperCase() : '?',
                style: TextStyle(color: colors.onPrimary),
              ),
            ),
            if (member.isOnline ?? false)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.surface, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(child: Text(member.fullName, style: textTheme.bodyLarge)),
            if (isAdmin)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Admin',
                  style: textTheme.labelSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            if (isMe)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'You',
                  style: textTheme.labelSmall?.copyWith(color: colors.secondary, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('@${member.username}'),
            if (member.isOnline ?? false)
              Text('Active now', style: textTheme.labelSmall?.copyWith(color: Colors.green))
            else if (member.lastSeen != null)
              Text(
                'Active ${FormatUtils.formatTimeAgo(member.lastSeen!)}',
                style: textTheme.labelSmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
              ),
          ],
        ),
        trailing: canManage ? IconButton(icon: const Icon(Icons.more_vert), onPressed: onManage) : null,
        onTap: onTap,
      ),
    );
  }
}
