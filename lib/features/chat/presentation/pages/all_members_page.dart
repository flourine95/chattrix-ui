import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/core/widgets/bottom_sheets.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/add_members_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllMembersPage extends ConsumerStatefulWidget {
  const AllMembersPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  ConsumerState<AllMembersPage> createState() => _AllMembersPageState();
}

class _AllMembersPageState extends ConsumerState<AllMembersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  late Conversation _currentConversation;

  @override
  void initState() {
    super.initState();
    _currentConversation = widget.conversation;
  }

  List<dynamic> get _filteredMembers {
    var filtered = _currentConversation.participants;

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
      filtered = filtered.where((member) => member.role == 'ADMIN').toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final me = ref.watch(currentUserProvider);
    final isAdmin =
        _currentConversation.participants
            .firstWhere((p) => p.userId == me?.id, orElse: () => _currentConversation.participants.first)
            .role ==
        'ADMIN';

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
          'Members (${_currentConversation.participants.length})',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          if (isAdmin)
            IconButton(
              icon: Icon(Icons.person_add, color: colors.primary),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMembersPage(conversationId: _currentConversation.id.toString()),
                  ),
                );
                // Refresh conversation data after adding members
                if (result == true && mounted) {
                  _refreshConversation();
                }
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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
                final isMemberAdmin = member.role == 'ADMIN';
                final isOnline = member.online ?? false;
                final isMe = member.userId == me?.id;

                return ListTile(
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserAvatar(displayName: member.fullName ?? 'User', avatarUrl: member.avatarUrl, radius: 24),
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
                          member.fullName ?? 'User',
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 8),
                        Text(
                          '(You)',
                          style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                        ),
                      ],
                      if (isMemberAdmin) ...[
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
                  trailing: isAdmin && !isMe
                      ? IconButton(
                          icon: Icon(Icons.more_vert, color: colors.onSurface),
                          onPressed: () => _showMemberOptions(context, member, isMemberAdmin, colors, textTheme),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshConversation() async {
    try {
      debugPrint('🔄 Refreshing conversation data...');
      final dio = ref.read(dioProvider);
      final response = await dio.get('${ApiConstants.conversations}/${_currentConversation.id}');

      if (response.data['success'] == true && response.data['data'] != null) {
        final conversationData = response.data['data'];

        // Parse using ConversationModel.fromApi (handles nullable fields properly)
        final conversationModel = ConversationModel.fromApi(conversationData);
        setState(() {
          _currentConversation = conversationModel.toEntity();
        });
        debugPrint('✅ Conversation refreshed: ${_currentConversation.participants.length} members');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error refreshing conversation: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  void _showMemberOptions(
    BuildContext context,
    dynamic member,
    bool isMemberAdmin,
    ColorScheme colors,
    TextTheme textTheme,
  ) async {
    final action = await showOptionsBottomSheet<String>(
      context: context,
      title: 'Member Options',
      subtitle: member.fullName ?? 'User',
      options: [
        if (isMemberAdmin)
          BottomSheetOption(label: 'Remove Admin', icon: Icons.remove_moderator_outlined, value: 'remove_admin')
        else
          BottomSheetOption(label: 'Make Admin', icon: Icons.admin_panel_settings_outlined, value: 'make_admin'),
        BottomSheetOption(
          label: 'Remove from Group',
          icon: Icons.person_remove_outlined,
          iconColor: Colors.red,
          value: 'remove',
          isDangerous: true,
        ),
      ],
    );

    if (action == null) return;

    switch (action) {
      case 'make_admin':
        _handleUpdateRole(member.userId, 'ADMIN');
        break;
      case 'remove_admin':
        _handleUpdateRole(member.userId, 'MEMBER');
        break;
      case 'remove':
        _handleRemoveMember(member.userId, member.fullName ?? 'User');
        break;
    }
  }

  Future<void> _handleUpdateRole(int userId, String newRole) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      debugPrint('🔄 Updating role for user $userId to $newRole in conversation ${_currentConversation.id}...');
      final dio = ref.read(dioProvider);
      final response = await dio.put(
        '${ApiConstants.conversationMembers(_currentConversation.id)}/$userId/role',
        data: {'role': newRole},
      );
      debugPrint('✅ Update role response: ${response.statusCode} - ${response.data}');

      if (!mounted) return;

      // Refresh conversation data to update UI
      await _refreshConversation();

      // Close loading dialog AFTER refresh
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  newRole == 'ADMIN' ? 'Member promoted to admin' : 'Admin role removed',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error updating role: $e');
      if (!mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Failed to update role', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          backgroundColor: Colors.grey.shade900,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  Future<void> _handleRemoveMember(int userId, String userName) async {
    // Show confirmation bottom sheet
    final confirmed = await showConfirmationBottomSheet(
      context: context,
      title: 'Remove Member',
      message: 'Are you sure you want to remove $userName from this group?',
      confirmText: 'Remove',
      cancelText: 'Cancel',
      icon: Icons.person_remove_outlined,
      isDangerous: true,
    );

    if (confirmed != true || !mounted) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      debugPrint('🔄 Removing member $userId from conversation ${_currentConversation.id}...');
      final dio = ref.read(dioProvider);
      final response = await dio.delete('${ApiConstants.conversationMembers(_currentConversation.id)}/$userId');
      debugPrint('✅ Remove member response: ${response.statusCode} - ${response.data}');

      if (!mounted) return;

      // Refresh conversation data to update UI
      await _refreshConversation();

      // Close loading dialog AFTER refresh
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('$userName removed from group', style: const TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error removing member: $e');
      if (!mounted) return;

      // Close loading dialog using rootNavigator
      Navigator.of(context, rootNavigator: true).pop();

      // Show error snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Failed to remove member', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.isSelected, required this.onTap, required this.colors});

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
