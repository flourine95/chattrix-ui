import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/group_avatar.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/add_members_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/all_members_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/files_links_page.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/conversation_members_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/media_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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

    final isOnline = !isGroup && ConversationUtils.isUserOnline(conversation, me);
    final lastSeen = !isGroup ? ConversationUtils.getLastSeen(conversation, me) : null;
    final statusText = !isGroup ? ConversationUtils.formatLastSeen(isOnline, lastSeen) : null;

    return Scaffold(
      backgroundColor: colors.surface,
      body: CustomScrollView(
        slivers: [
          // App Bar with shadow when scrolled
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: colors.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.black.withValues(alpha: 0.1),
            scrolledUnderElevation: 4,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.onSurface),
              onPressed: () => context.pop(),
            ),
            actions: [
              if (isGroup)
                IconButton(
                  icon: Icon(Icons.more_vert, color: colors.onSurface),
                  onPressed: () => _showGroupOptionsBottomSheet(context, colors, textTheme),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: AnimatedOpacity(
                opacity: 1.0, // Will be controlled by scroll in future
                duration: const Duration(milliseconds: 200),
                child: Text(
                  displayName,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: _buildHeader(context, displayName, isGroup, isOnline, statusText, colors, textTheme),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(child: _buildQuickActions(context, isGroup, colors, textTheme)),

          // Customize Section
          SliverToBoxAdapter(child: _buildCustomizeSection(context, colors, textTheme)),

          // Media Section
          SliverToBoxAdapter(
            child: _buildMediaSection(context, ref, messagesAsync, colors, textTheme),
          ),

          // Files & Links Section (for groups)
          if (isGroup)
            SliverToBoxAdapter(
              child: _buildFilesAndLinksSection(context, colors, textTheme),
            ),

          // Members Section (for groups)
          if (isGroup) SliverToBoxAdapter(child: _buildMembersSection(context, colors, textTheme)),

          // Privacy & Support Section
          SliverToBoxAdapter(child: _buildPrivacySection(context, isGroup, colors, textTheme)),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  // Header with avatar and name
  Widget _buildHeader(
    BuildContext context,
    String displayName,
    bool isGroup,
    bool isOnline,
    String? statusText,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 80, bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Avatar with edit button
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Group or user avatar
              if (isGroup)
                GroupAvatar(
                  participants: conversation.participants,
                  radius: 60,
                  showBorder: true,
                  borderColor: colors.surface,
                )
              else
                UserAvatar(
                  displayName: displayName,
                  avatarUrl: null,
                  radius: 60,
                  backgroundColor: colors.primary,
                ),

              // Online indicator for direct chat
              if (!isGroup && isOnline)
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 3),
                    ),
                  ),
                ),

              // Edit button for group
              if (isGroup)
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: Material(
                    color: colors.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => _showChangeGroupPhotoBottomSheet(context, colors, textTheme),
                      customBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(Icons.camera_alt, size: 20, color: colors.onPrimary),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Name with edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  displayName,
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isGroup) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _showRenameGroupBottomSheet(context, colors, textTheme),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.edit, size: 18, color: colors.primary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),

          // Status or member count
          if (isGroup)
            Text(
              '${conversation.participants.length} members',
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            )
          else if (statusText != null)
            Text(
              statusText,
              style: textTheme.bodyMedium?.copyWith(
                color: isOnline ? Colors.green : colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
        ],
      ),
    );
  }

  // Quick Actions Section
  Widget _buildQuickActions(BuildContext context, bool isGroup, ColorScheme colors, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isGroup) ...[
            _QuickActionButton(
              icon: Icons.person_add_outlined,
              label: 'Add',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMembersPage(conversationId: conversation.id.toString()),
                  ),
                );
              },
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.search,
              label: 'Search',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.notifications_outlined,
              label: 'Mute',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: () => _shareGroupLink(context),
              colors: colors,
              textTheme: textTheme,
            ),
          ] else ...[
            _QuickActionButton(
              icon: Icons.search,
              label: 'Search',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.notifications_outlined,
              label: 'Mute',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.videocam_outlined,
              label: 'Video',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
            _QuickActionButton(
              icon: Icons.call_outlined,
              label: 'Call',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
          ],
        ],
      ),
    );
  }

  // Customize Section
  Widget _buildCustomizeSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final isGroup = conversation.type == ConversationType.group;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              isGroup ? 'Group Settings' : 'Customize',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          if (isGroup) ...[
            _SettingsTile(
              icon: Icons.description_outlined,
              title: 'Group Description',
              subtitle: 'Add a description for this group',
              onTap: () => _showGroupDescriptionBottomSheet(context, colors, textTheme),
              colors: colors,
              textTheme: textTheme,
            ),
            _SettingsTile(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Group Permissions',
              subtitle: 'Manage who can send messages, add members',
              onTap: () => _showGroupPermissionsBottomSheet(context, colors, textTheme),
              colors: colors,
              textTheme: textTheme,
            ),
            _SettingsTile(
              icon: Icons.push_pin_outlined,
              title: 'Pinned Messages',
              subtitle: 'View pinned messages',
              onTap: () => _showPinnedMessagesBottomSheet(context, colors, textTheme),
              colors: colors,
              textTheme: textTheme,
            ),
          ],
          _SettingsTile(
            icon: Icons.color_lens_outlined,
            title: 'Theme & Colors',
            subtitle: 'Change chat colors',
            onTap: () => _showThemeColorsBottomSheet(context, colors, textTheme),
            colors: colors,
            textTheme: textTheme,
          ),
          _SettingsTile(
            icon: Icons.emoji_emotions_outlined,
            title: 'Emoji',
            subtitle: 'Choose a quick reaction',
            onTap: () => _showQuickReactionBottomSheet(context, colors, textTheme),
            colors: colors,
            textTheme: textTheme,
          ),
          if (!isGroup)
            _SettingsTile(
              icon: Icons.edit_outlined,
              title: 'Nickname',
              subtitle: 'Set a nickname',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
            ),
        ],
      ),
    );
  }

  // Media Section
  Widget _buildMediaSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue messagesAsync,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    return messagesAsync.when(
      data: (messages) {
        final mediaMessages = messages.where((m) => m.mediaUrl != null).take(6).toList();

        if (mediaMessages.isEmpty) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Media, Files & Links',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('See All', style: TextStyle(color: colors.primary)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: mediaMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 100,
                          child: MediaGridItem(message: mediaMessages[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }


  // Members Section (for groups)
  Widget _buildMembersSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return Consumer(
      builder: (context, ref, child) {
        final membersAsync = ref.watch(conversationMembersProvider(conversation.id.toString()));

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Members',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    membersAsync.when(
                      data: (members) => TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllMembersPage(
                                conversationId: conversation.id.toString(),
                                members: members,
                              ),
                            ),
                          );
                        },
                        child: Text('See All (${members.length})', style: TextStyle(color: colors.primary)),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (e, s) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              // Add member button
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add, color: colors.primary, size: 20),
                ),
                title: Text('Add Members', style: textTheme.bodyMedium?.copyWith(color: colors.primary)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMembersPage(conversationId: conversation.id.toString()),
                    ),
                  );
                },
              ),
              // Show first 5 members
              membersAsync.when(
                data: (members) => Column(
                  children: members.take(5).map((member) {
                    // TODO: Add admin badge when backend supports role field
                    return ListTile(
                      leading: UserAvatar(
                        displayName: member.fullName,
                        avatarUrl: member.avatarUrl,
                        radius: 20,
                        backgroundColor: colors.primary,
                      ),
                      title: Text(member.fullName, style: textTheme.bodyMedium),
                      subtitle: Text('@${member.username}', style: textTheme.bodySmall),
                      trailing: member.isOnline
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            )
                          : null,
                    );
                  }).toList(),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Failed to load members', style: textTheme.bodySmall),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Privacy & Support Section
  Widget _buildPrivacySection(BuildContext context, bool isGroup, ColorScheme colors, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Privacy & Support',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          _SettingsTile(
            icon: Icons.notifications_off_outlined,
            title: 'Notifications',
            subtitle: 'Manage notification settings',
            onTap: () {},
            colors: colors,
            textTheme: textTheme,
          ),
          if (isGroup)
            _SettingsTile(
              icon: Icons.link,
              title: 'Invite Links',
              subtitle: 'Manage group invite links',
              onTap: () {
                context.push(
                  '/invite-links',
                  extra: {'conversationId': conversation.id, 'conversationName': conversation.name ?? 'Group'},
                );
              },
              colors: colors,
              textTheme: textTheme,
            ),
          if (!isGroup)
            _SettingsTile(
              icon: Icons.block_outlined,
              title: 'Block',
              subtitle: 'Block this user',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
              isDestructive: true,
            ),
          _SettingsTile(
            icon: Icons.report_outlined,
            title: 'Report',
            subtitle: isGroup ? 'Report this group' : 'Report this user',
            onTap: () {},
            colors: colors,
            textTheme: textTheme,
            isDestructive: true,
          ),
          if (isGroup)
            _SettingsTile(
              icon: Icons.exit_to_app,
              title: 'Leave Group',
              subtitle: 'Leave this group',
              onTap: () {},
              colors: colors,
              textTheme: textTheme,
              isDestructive: true,
            ),
        ],
      ),
    );
  }

  // Files and Links Section
  Widget _buildFilesAndLinksSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.05), width: 8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Files & Links',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          _SettingsTile(
            icon: Icons.insert_drive_file_outlined,
            title: 'Files',
            subtitle: 'View all shared files',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilesLinksPage(conversationId: conversation.id.toString()),
                ),
              );
            },
            colors: colors,
            textTheme: textTheme,
          ),
          _SettingsTile(
            icon: Icons.link,
            title: 'Links',
            subtitle: 'View all shared links',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilesLinksPage(conversationId: conversation.id.toString()),
                ),
              );
            },
            colors: colors,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  // Bottom Sheet Methods

  // Group Options Menu
  void _showGroupOptionsBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
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
              leading: Icon(Icons.push_pin_outlined, color: colors.onSurface),
              title: Text('Pin Group', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement pin group
              },
            ),
            ListTile(
              leading: Icon(Icons.volume_off_outlined, color: colors.onSurface),
              title: Text('Mute Notifications', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement mute
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: colors.onSurface),
              title: Text('Search in Conversation', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement search
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.report_outlined, color: Colors.red),
              title: Text('Report Group', style: textTheme.bodyLarge?.copyWith(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Change Group Photo
  void _showChangeGroupPhotoBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Change Group Photo',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.camera_alt, color: colors.primary),
              title: Text('Take Photo', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement camera
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: colors.primary),
              title: Text('Choose from Gallery', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement gallery picker
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions_outlined, color: colors.primary),
              title: Text('Choose Emoji', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement emoji picker
              },
            ),
            if (conversation.avatarUrl != null)
              ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.red),
                title: Text('Remove Photo', style: textTheme.bodyLarge?.copyWith(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement remove photo
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Rename Group
  void _showRenameGroupBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final controller = TextEditingController(text: conversation.name);
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Rename Group',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    hintText: 'Enter group name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: colors.surfaceContainerHighest,
                  ),
                  autofocus: true,
                  maxLength: 50,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          // TODO: Implement rename group API call
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Group Description
  void _showGroupDescriptionBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final controller = TextEditingController(text: 'Welcome to our group! Feel free to share and discuss.');
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Group Description',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter group description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: colors.surfaceContainerHighest,
                  ),
                  maxLines: 4,
                  maxLength: 200,
                  autofocus: true,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          // TODO: Implement update group description API call
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Group Permissions
  void _showGroupPermissionsBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Group Permissions',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: Text('All members can send messages', style: textTheme.bodyLarge),
              subtitle: Text('When off, only admins can send messages', style: textTheme.bodySmall),
              value: true,
              onChanged: (value) {
                // TODO: Implement permission change
              },
            ),
            SwitchListTile(
              title: Text('All members can add others', style: textTheme.bodyLarge),
              subtitle: Text('When off, only admins can add members', style: textTheme.bodySmall),
              value: true,
              onChanged: (value) {
                // TODO: Implement permission change
              },
            ),
            SwitchListTile(
              title: Text('All members can edit group info', style: textTheme.bodyLarge),
              subtitle: Text('When off, only admins can edit', style: textTheme.bodySmall),
              value: false,
              onChanged: (value) {
                // TODO: Implement permission change
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Pinned Messages
  void _showPinnedMessagesBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    // Hardcoded pinned messages for demo
    final pinnedMessages = [
      {'sender': 'John Doe', 'message': 'Meeting at 3 PM tomorrow', 'time': '2 days ago'},
      {'sender': 'Jane Smith', 'message': 'Don\'t forget to submit the report', 'time': '5 days ago'},
    ];

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.push_pin, color: colors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Pinned Messages',
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (pinnedMessages.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.push_pin_outlined, size: 48, color: colors.onSurface.withValues(alpha: 0.3)),
                    const SizedBox(height: 16),
                    Text(
                      'No pinned messages',
                      style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              )
            else
              ...pinnedMessages.map((msg) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors.primaryContainer,
                      child: Text(msg['sender']![0], style: TextStyle(color: colors.onPrimaryContainer)),
                    ),
                    title: Text(msg['sender']!, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(msg['message']!, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Text(msg['time']!, style: textTheme.bodySmall),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Navigate to message
                    },
                  )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Theme & Colors
  void _showThemeColorsBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final themeColors = [
      {'name': 'Blue', 'color': const Color(0xFF0084FF)},
      {'name': 'Purple', 'color': const Color(0xFF9C27B0)},
      {'name': 'Pink', 'color': const Color(0xFFE91E63)},
      {'name': 'Red', 'color': const Color(0xFFF44336)},
      {'name': 'Orange', 'color': const Color(0xFFFF9800)},
      {'name': 'Green', 'color': const Color(0xFF4CAF50)},
      {'name': 'Teal', 'color': const Color(0xFF009688)},
      {'name': 'Indigo', 'color': const Color(0xFF3F51B5)},
    ];

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Choose Theme Color',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: themeColors.length,
                itemBuilder: (context, index) {
                  final theme = themeColors[index];
                  final isSelected = index == 0; // First one selected by default
                  return GestureDetector(
                    onTap: () {
                      // TODO: Implement theme change
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: theme['color'] as Color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: colors.onSurface, width: 3)
                                : null,
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: Colors.white, size: 28)
                              : null,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          theme['name'] as String,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Quick Reaction Emoji
  void _showQuickReactionBottomSheet(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    final emojis = ['❤️', '😂', '😮', '😢', '😡', '👍', '👎', '🎉', '🔥', '💯', '✨', '💪'];

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Choose Quick Reaction',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: emojis.length,
                itemBuilder: (context, index) {
                  final emoji = emojis[index];
                  final isSelected = index == 0; // First one selected by default
                  return GestureDetector(
                    onTap: () {
                      // TODO: Implement emoji selection
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.primaryContainer
                            : colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: colors.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Share Group Link
  void _shareGroupLink(BuildContext context) {
    final groupLink = 'https://chattrix.app/group/${conversation.id}';
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Share Group Link',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Share this link with others to invite them to the group:',
                style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        groupLink,
                        style: textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                          color: colors.primary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.copy, color: colors.primary),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: groupLink));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Link copied to clipboard'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement QR code generation
                      },
                      icon: const Icon(Icons.qr_code),
                      label: const Text('QR Code'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        // TODO: Implement share functionality
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}


// Quick Action Button Widget
class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.colors,
    required this.textTheme,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colors.onSurface, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Tile Widget
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.colors,
    required this.textTheme,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final ColorScheme colors;
  final TextTheme textTheme;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final iconColor = isDestructive ? Colors.red : colors.onSurface.withValues(alpha: 0.7);
    final titleColor = isDestructive ? Colors.red : colors.onSurface;

    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(
          color: titleColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodySmall?.copyWith(
          color: colors.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: colors.onSurface.withValues(alpha: 0.3),
        size: 20,
      ),
      onTap: onTap,
    );
  }
}

