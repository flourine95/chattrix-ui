import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/group_avatar.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/add_members_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/all_members_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/community_calendar_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/files_links_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/group_permissions_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/invite_links_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/polls_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/scheduled_messages_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/search_messages_page.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/conversation_settings_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/poll_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/social_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info_bottom_sheets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInfoPage extends HookConsumerWidget {
  const ChatInfoPage({super.key, required this.conversation});

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(conversation.id.toString()));

    final isGroup = conversation.type == ConversationType.group;
    final displayName = isGroup
        ? (conversation.name ?? 'Group ${conversation.id}')
        : ConversationUtils.getConversationTitle(conversation, me);

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(isGroup ? 'Group Info' : 'Contact Info'),
            centerTitle: false,
            pinned: true,
            floating: false,
            elevation: 0,
            scrolledUnderElevation: 4,
            shadowColor: colors.shadow.withValues(alpha: 0.3),
            backgroundColor: colors.surface,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Avatar Section
                _buildAvatarSection(context, displayName, isGroup, colors),

                const SizedBox(height: 16),

                // Name Section
                _buildNameSection(context, displayName, isGroup, colors, textTheme),

                const SizedBox(height: 24),

                // Quick Actions Row (4 buttons)
                _buildQuickActionsRow(context, ref, isGroup, colors, textTheme),

                const SizedBox(height: 24),

                // Different layouts for 1-1 vs Group
                if (isGroup)
                  _buildGroupLayout(context, ref, messagesAsync, colors, textTheme)
                else
                  _buildOneToOneLayout(context, ref, messagesAsync, colors, textTheme),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // LAYOUT BUILDERS
  // ============================================================================

  /// Build layout for 1-1 chat
  Widget _buildOneToOneLayout(
    BuildContext context,
    WidgetRef ref,
    AsyncValue messagesAsync,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        // Nickname
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.edit,
            title: 'Change Nickname',
            colors: colors,
            textTheme: textTheme,
            onTap: () => showChangeNicknameBottomSheet(context, ref, conversation.id.toString(), colors, textTheme),
          ),
        ),

        const SizedBox(height: 8),

        // Media, Files, Links
        _buildMediaPreviewSection(context, ref, messagesAsync, colors, textTheme),

        const SizedBox(height: 8),

        // Mutual Groups
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.groups,
            title: 'Mutual Groups',
            subtitle: 'Groups in common',
            colors: colors,
            textTheme: textTheme,
            onTap: () => _showMutualGroupsBottomSheet(context, ref, colors, textTheme),
          ),
        ),

        const SizedBox(height: 8),

        // Pin Conversation
        _buildRoundedSection(context, colors, child: _buildPinConversationTile(context, ref, colors, textTheme)),

        const SizedBox(height: 8),

        // Schedule Message
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.schedule_send,
            title: 'Schedule Message',
            colors: colors,
            textTheme: textTheme,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduledMessagesPage()));
            },
          ),
        ),

        const SizedBox(height: 8),

        // Block
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.block,
            title: 'Block',
            colors: colors,
            textTheme: textTheme,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () => showBlockUserBottomSheet(context, ref, conversation.id.toString(), colors, textTheme),
          ),
        ),

        const SizedBox(height: 8),

        // Hide Conversation
        _buildRoundedSection(context, colors, child: _buildHideConversationTile(context, ref, colors, textTheme)),
      ],
    );
  }

  /// Build layout for Group chat
  Widget _buildGroupLayout(
    BuildContext context,
    WidgetRef ref,
    AsyncValue messagesAsync,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        // Description
        _buildDescriptionSection(context, ref, colors, textTheme),

        const SizedBox(height: 8),

        // Media, Files, Links
        _buildMediaPreviewSection(context, ref, messagesAsync, colors, textTheme),

        const SizedBox(height: 8),

        // Members
        _buildViewMembersSection(context, colors, textTheme),

        const SizedBox(height: 8),

        // Community Calendar
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.calendar_today,
            title: 'Community Calendar',
            subtitle: '3 upcoming events',
            colors: colors,
            textTheme: textTheme,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CommunityCalendarPage(conversationId: conversation.id.toString())),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Polls
        _buildPollsSection(context, ref, colors, textTheme),

        const SizedBox(height: 8),

        // Birthdays
        _buildBirthdaysSection(context, ref, colors, textTheme),

        const SizedBox(height: 8),

        // Community Link
        _buildCommunityLinkSection(context, colors, textTheme),

        const SizedBox(height: 8),

        // Admin Permissions (only if user is admin)
        if (_isUserAdmin()) _buildAdminPermissionsSection(context, colors, textTheme),

        if (_isUserAdmin()) const SizedBox(height: 8),

        // Pin Conversation
        _buildRoundedSection(context, colors, child: _buildPinConversationTile(context, ref, colors, textTheme)),

        const SizedBox(height: 8),

        // Schedule Message
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.schedule_send,
            title: 'Schedule Message',
            colors: colors,
            textTheme: textTheme,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduledMessagesPage()));
            },
          ),
        ),

        const SizedBox(height: 8),

        // Leave Group
        _buildRoundedSection(
          context,
          colors,
          child: _buildActionTile(
            icon: Icons.exit_to_app,
            title: 'Leave Group',
            subtitle: 'You will no longer receive messages',
            colors: colors,
            textTheme: textTheme,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () => _showLeaveGroupBottomSheet(context, ref, colors, textTheme),
          ),
        ),

        const SizedBox(height: 8),

        // Hide Conversation
        _buildRoundedSection(context, colors, child: _buildHideConversationTile(context, ref, colors, textTheme)),
      ],
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  bool _isUserAdmin() {
    // Demo: Check if current user is admin
    // TODO: Implement real admin check
    return true; // For demo purposes
  }

  /// Build a rounded section container (Messenger style)
  Widget _buildRoundedSection(BuildContext context, ColorScheme colors, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }

  /// Build an action tile (Messenger style)
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required ColorScheme colors,
    required TextTheme textTheme,
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: (iconColor ?? colors.primary).withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(icon, color: iconColor ?? colors.primary, size: 22),
      ),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: textColor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)))
          : null,
      trailing: trailing ?? Icon(Icons.chevron_right, color: colors.onSurface.withValues(alpha: 0.4)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  /// Build Pin Conversation tile
  Widget _buildPinConversationTile(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final settingsAsync = ref.watch(conversationSettingsProvider(conversation.id.toString()));
    final isPinned = settingsAsync.value?.pinned ?? false;

    return _buildActionTile(
      icon: Icons.push_pin,
      title: 'Pin Conversation',
      subtitle: 'Keep this chat at the top',
      colors: colors,
      textTheme: textTheme,
      trailing: Switch(
        value: isPinned,
        onChanged: (value) async {
          await ref.read(conversationSettingsProvider(conversation.id.toString()).notifier).togglePin();
        },
      ),
    );
  }

  /// Build Hide Conversation tile
  Widget _buildHideConversationTile(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final settingsAsync = ref.watch(conversationSettingsProvider(conversation.id.toString()));
    final isHidden = settingsAsync.value?.hidden ?? false;

    return _buildActionTile(
      icon: Icons.visibility_off,
      title: 'Hide Conversation',
      subtitle: 'Hide from chat list',
      colors: colors,
      textTheme: textTheme,
      trailing: Switch(
        value: isHidden,
        onChanged: (value) async {
          await ref.read(conversationSettingsProvider(conversation.id.toString()).notifier).toggleHide();
        },
      ),
    );
  }

  // ============================================================================
  // SECTION BUILDERS
  // ============================================================================

  // Avatar Section
  Widget _buildAvatarSection(BuildContext context, String displayName, bool isGroup, ColorScheme colors) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar
        isGroup
            ? GroupAvatar(participants: conversation.participants, radius: 60)
            : UserAvatar(
                displayName: displayName,
                avatarUrl: conversation.participants.firstOrNull?.avatarUrl,
                radius: 60,
              ),
        // Edit Photo Icon (only for groups)
        if (isGroup)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => _showChangePhotoBottomSheet(context, colors, Theme.of(context).textTheme),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.surface, width: 3),
                ),
                child: Icon(Icons.camera_alt, color: colors.onPrimary, size: 20),
              ),
            ),
          ),
      ],
    );
  }

  // Name Section
  Widget _buildNameSection(
    BuildContext context,
    String displayName,
    bool isGroup,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(displayName, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        // Edit icon only for groups
        if (isGroup) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.edit, size: 20, color: colors.primary),
            onPressed: () => _showRenameBottomSheet(context, colors, textTheme),
          ),
        ],
      ],
    );
  }

  // Quick Actions Row
  Widget _buildQuickActionsRow(
    BuildContext context,
    WidgetRef ref,
    bool isGroup,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _QuickActionButton(
            icon: Icons.search,
            label: 'Search',
            color: Colors.blue,
            onTap: () => _showSearchDialog(context, colors, textTheme),
          ),
          if (isGroup)
            _QuickActionButton(
              icon: Icons.person_add,
              label: 'Add',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMembersPage(conversationId: conversation.id.toString())),
                );
              },
            )
          else
            _QuickActionButton(
              icon: Icons.person,
              label: 'Profile',
              color: Colors.green,
              onTap: () {
                final otherUser = conversation.participants.firstWhere(
                  (p) => p.userId != ref.read(currentUserProvider)?.id,
                  orElse: () => conversation.participants.first,
                );
                // TODO: Navigate to user profile page
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('View profile: ${otherUser.fullName}')));
              },
            ),
          _QuickActionButton(
            icon: Icons.wallpaper,
            label: 'Wallpaper',
            color: Colors.purple,
            onTap: () => _showWallpaperBottomSheet(context, colors, textTheme),
          ),
          _QuickActionButton(
            icon: Icons.notifications,
            label: 'Notifications',
            color: Colors.orange,
            onTap: () => _showNotificationsBottomSheet(context, ref, colors, textTheme),
          ),
        ],
      ),
    );
  }

  // Description Section
  Widget _buildDescriptionSection(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              IconButton(
                icon: Icon(Icons.edit, size: 18, color: colors.primary),
                onPressed: () => _showDescriptionBottomSheet(context, ref, colors, textTheme),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This is a demo group description. Click edit to change it.',
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  // Media Preview Section
  Widget _buildMediaPreviewSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue messagesAsync,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    // Always show the section with demo data
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Media, Files & Links', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilesLinksPage(conversationId: conversation.id.toString())),
                  );
                },
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Demo media grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(color: colors.surfaceContainerHigh, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.image, color: colors.onSurface.withValues(alpha: 0.3), size: 40),
              );
            },
          ),
        ],
      ),
    );
  }

  // View Members Section
  Widget _buildViewMembersSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return _buildListTile(
      icon: Icons.people,
      title: 'View Members',
      subtitle: '${conversation.participants.length} members',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllMembersPage(conversationId: conversation.id.toString(), members: []),
          ),
        );
      },
      colors: colors,
      textTheme: textTheme,
    );
  }

  // Community Link Section
  Widget _buildCommunityLinkSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return _buildListTile(
      icon: Icons.link,
      title: 'Invite Links',
      subtitle: 'Manage group invite links',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InviteLinksPage(conversationId: conversation.id)),
        );
      },
      colors: colors,
      textTheme: textTheme,
    );
  }

  // Admin Permissions Section
  Widget _buildAdminPermissionsSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return _buildListTile(
      icon: Icons.admin_panel_settings,
      title: 'Group Permissions',
      subtitle: 'Manage who can perform actions',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupPermissionsPage(conversationId: conversation.id.toString())),
        );
      },
      colors: colors,
      textTheme: textTheme,
    );
  }

  void _showLeaveGroupBottomSheet(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Warning icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.exit_to_app, color: Colors.red, size: 32),
            ),

            const SizedBox(height: 20),

            // Title
            Text('Leave Group?', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            // Description
            Text(
              'Are you sure you want to leave this group? You will no longer receive messages from this conversation.',
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      try {
                        await ref.read(conversationSettingsProvider(conversation.id.toString()).notifier).leaveGroup();
                        if (context.mounted) {
                          Navigator.pop(context); // Go back to chat list
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(const SnackBar(content: Text('Left group successfully')));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Failed to leave group: $e')));
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Leave'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // BOTTOM SHEETS
  // ============================================================================

  void _showChangePhotoBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement camera
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement gallery
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove Photo', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement remove photo
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final controller = TextEditingController(text: conversation.name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text('Rename Group', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Group Name', border: OutlineInputBorder()),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Implement rename
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDescriptionBottomSheet(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final controller = TextEditingController(text: 'This is a demo group description. Click edit to change it.');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text('Group Description', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 4,
                maxLength: 200,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    try {
                      await ref
                          .read(conversationSettingsProvider(conversation.id.toString()).notifier)
                          .updateDescription(controller.text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Description updated successfully')));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Failed to update description: $e')));
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // QUICK ACTION DIALOGS
  // ============================================================================

  void _showSearchDialog(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchMessagesPage(conversationId: conversation.id.toString())),
    );
  }

  void _showWallpaperBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text('Chat Wallpaper', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement gallery picker
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gallery picker coming soon')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Solid Color'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement color picker
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Color picker coming soon')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallpaper),
              title: const Text('Default Wallpapers'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show default wallpapers
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Default wallpapers coming soon')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Remove Wallpaper', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Remove wallpaper
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wallpaper removed')));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsBottomSheet(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final settingsAsync = ref.watch(conversationSettingsProvider(conversation.id.toString()));
    final isMuted = settingsAsync.value?.muted ?? false;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text('Notification Settings', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Mute Notifications'),
              subtitle: const Text('Stop receiving notifications from this chat'),
              value: isMuted,
              onChanged: (value) async {
                await ref.read(conversationSettingsProvider(conversation.id.toString()).notifier).toggleMute();
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text('Custom Notification Sound'),
              subtitle: const Text('Default'),
              onTap: () {
                // TODO: Show sound picker
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sound picker coming soon')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.priority_high),
              title: const Text('Priority Notifications'),
              subtitle: const Text('Show as priority'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // TODO: Update priority setting
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build birthdays section for group chats
  Widget _buildBirthdaysSection(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final birthdaysAsync = ref.watch(birthdaysTodayProvider);

    return switch (birthdaysAsync) {
      AsyncData(:final value) when value.isNotEmpty => _buildRoundedSection(
        context,
        colors,
        child: Column(
          children: [
            _buildActionTile(
              icon: Icons.cake,
              title: 'Birthdays Today',
              subtitle: '${value.length} ${value.length == 1 ? 'birthday' : 'birthdays'}',
              colors: colors,
              textTheme: textTheme,
              onTap: () => _showBirthdaysBottomSheet(context, ref, value, colors, textTheme),
            ),
          ],
        ),
      ),
      _ => const SizedBox.shrink(), // Hide if no birthdays or loading/error
    };
  }

  /// Build polls section for group chats
  Widget _buildPollsSection(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    final convId = conversation.id;
    final pollsAsync = ref.watch(pollsListProvider(convId));

    return switch (pollsAsync) {
      AsyncData(:final value) => _buildRoundedSection(
        context,
        colors,
        child: _buildActionTile(
          icon: Icons.poll,
          title: 'Polls',
          subtitle: value.isEmpty
              ? 'No polls yet'
              : '${value.where((p) => p.active).length} active, ${value.length} total',
          colors: colors,
          textTheme: textTheme,
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => PollsPage(conversationId: convId.toString()))),
        ),
      ),
      AsyncLoading() => _buildRoundedSection(
        context,
        colors,
        child: _buildActionTile(
          icon: Icons.poll,
          title: 'Polls',
          subtitle: 'Loading...',
          colors: colors,
          textTheme: textTheme,
          onTap: null,
        ),
      ),
      AsyncError(:final error) => _buildRoundedSection(
        context,
        colors,
        child: _buildActionTile(
          icon: Icons.poll,
          title: 'Polls',
          subtitle: 'Error: ${error.toString()}',
          colors: colors,
          textTheme: textTheme,
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => PollsPage(conversationId: convId.toString()))),
        ),
      ),
    };
  }

  // ============================================================================
  // BOTTOM SHEETS
  // ============================================================================

  void _showMutualGroupsBottomSheet(BuildContext context, WidgetRef ref, ColorScheme colors, TextTheme textTheme) {
    // Get the other user's ID (for 1-1 chats)
    final otherUser = conversation.participants.firstWhere(
      (p) => p.userId != ref.read(currentUserProvider)?.id,
      orElse: () => conversation.participants.first,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final mutualGroupsAsync = ref.watch(mutualGroupsProvider(otherUser.userId));

          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: colors.onSurface.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text('Mutual Groups', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: switch (mutualGroupsAsync) {
                      AsyncData(:final value) =>
                        value.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.groups_outlined,
                                      size: 64,
                                      color: colors.onSurface.withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No mutual groups',
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: colors.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  final group = value[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: colors.primaryContainer,
                                      child: Icon(Icons.group, color: colors.onPrimaryContainer),
                                    ),
                                    title: Text(group.type),
                                    subtitle: Text('${group.participants.length} members'),
                                    trailing: Icon(Icons.chevron_right, color: colors.onSurface.withValues(alpha: 0.5)),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Navigate to group conversation
                                      // context.push('/chat/${group.id}');
                                    },
                                  );
                                },
                              ),
                      AsyncError(:final error) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 64, color: Colors.red.withValues(alpha: 0.7)),
                            const SizedBox(height: 16),
                            Text('Failed to load mutual groups', style: textTheme.bodyLarge),
                            const SizedBox(height: 8),
                            Text(
                              error.toString(),
                              style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      _ => const Center(child: CircularProgressIndicator()),
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBirthdaysBottomSheet(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> birthdays,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text('Birthdays Today 🎉', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: birthdays.length,
                  itemBuilder: (context, index) {
                    final birthday = birthdays[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: birthday.avatarUrl != null
                                      ? NetworkImage(birthday.avatarUrl!)
                                      : null,
                                  child: birthday.avatarUrl == null
                                      ? Text(birthday.fullName[0].toUpperCase(), style: textTheme.titleLarge)
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        birthday.fullName,
                                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '@${birthday.username}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colors.onSurface.withValues(alpha: 0.6),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Turning ${birthday.age} today! 🎂',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () async {
                                  final notifier = ref.read(sendBirthdayWishesProvider.notifier);
                                  // Send wishes to the current conversation
                                  await notifier.sendWishes(birthday.userId, [
                                    conversation.id,
                                  ], customMessage: birthday.birthdayMessage);

                                  if (!context.mounted) return;

                                  final state = ref.read(sendBirthdayWishesProvider);
                                  if (state.hasError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to send wishes: ${state.error}'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Birthday wishes sent to ${birthday.fullName}! 🎉'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.card_giftcard),
                                label: const Text('Send Birthday Wishes'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // HELPER WIDGETS
  // ============================================================================

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ColorScheme colors,
    required TextTheme textTheme,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? Colors.red : colors.primary),
        title: Text(title, style: textTheme.bodyLarge?.copyWith(color: isDestructive ? Colors.red : null)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right, color: colors.onSurface.withValues(alpha: 0.5)),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================================
// QUICK ACTION BUTTON WIDGET
// ============================================================================

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(label, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
