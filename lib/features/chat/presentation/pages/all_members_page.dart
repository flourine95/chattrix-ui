import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllMembersPage extends ConsumerStatefulWidget {
  const AllMembersPage({super.key, required this.conversationId, required this.members});

  final String conversationId;
  final List<SearchUser> members;

  @override
  ConsumerState<AllMembersPage> createState() => _AllMembersPageState();
}

class _AllMembersPageState extends ConsumerState<AllMembersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  List<SearchUser> get _filteredMembers {
    var filtered = widget.members;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((member) {
        final name = member.fullName.toLowerCase();
        final query = _searchController.text.toLowerCase();
        return name.contains(query);
      }).toList();
    }

    // Apply role filter
    if (_selectedFilter == 'Admins') {
      // TODO: Filter by admin role when backend supports it
      filtered = filtered.take(2).toList(); // Demo: show first 2 as admins
    }

    return filtered;
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
          'Members (${widget.members.length})',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: colors.primary),
            onPressed: () {
              // TODO: Navigate to add members page
            },
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
                hintText: 'Search members...',
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

          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: _selectedFilter == 'All',
                  onTap: () => setState(() => _selectedFilter = 'All'),
                  colors: colors,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Admins',
                  isSelected: _selectedFilter == 'Admins',
                  onTap: () => setState(() => _selectedFilter = 'Admins'),
                  colors: colors,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Members list
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMembers.length,
              itemBuilder: (context, index) {
                final member = _filteredMembers[index];
                final isAdmin = index < 2; // Demo: first 2 are admins
                final isOnline = member.isOnline;

                return ListTile(
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserAvatar(
                        displayName: member.fullName,
                        avatarUrl: member.avatarUrl,
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
                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          member.fullName,
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isAdmin) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Admin',
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  subtitle: Text(
                    isOnline ? 'Online' : 'Offline',
                    style: textTheme.bodySmall?.copyWith(
                      color: isOnline ? Colors.green : colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert, color: colors.onSurface),
                    onPressed: () => _showMemberOptions(context, member, isAdmin, colors, textTheme),
                  ),
                  onTap: () {
                    // TODO: Navigate to member profile
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMemberOptions(
    BuildContext context,
    SearchUser member,
    bool isAdmin,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: colors.onSurface),
              title: Text('View Profile', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to profile
              },
            ),
            ListTile(
              leading: Icon(Icons.message_outlined, color: colors.onSurface),
              title: Text('Send Message', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to chat
              },
            ),
            if (isAdmin)
              ListTile(
                leading: Icon(Icons.remove_moderator_outlined, color: colors.onSurface),
                title: Text('Remove Admin', style: textTheme.bodyLarge),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement remove admin
                },
              )
            else
              ListTile(
                leading: Icon(Icons.admin_panel_settings_outlined, color: colors.onSurface),
                title: Text('Make Admin', style: textTheme.bodyLarge),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement make admin
                },
              ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.person_remove_outlined, color: Colors.red),
              title: Text('Remove from Group', style: textTheme.bodyLarge?.copyWith(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement remove member
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryContainer : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? colors.onPrimaryContainer : colors.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

