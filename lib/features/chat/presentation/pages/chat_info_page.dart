import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/chat_info_header.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/media_grid_widget.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/members_list_widget.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/message_search_widget.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/settings_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInfoPage extends HookConsumerWidget {
  const ChatInfoPage({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Thông tin hội thoại',
          style: textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          // Header with avatar, name, and basic info
          ChatInfoHeader(conversation: conversation),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colors.onSurface.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                _TabButton(
                  label: 'Tổng quan',
                  icon: Icons.info_outline,
                  isSelected: selectedTab.value == 0,
                  onTap: () => selectedTab.value = 0,
                ),
                _TabButton(
                  label: 'Media',
                  icon: Icons.photo_library_outlined,
                  isSelected: selectedTab.value == 1,
                  onTap: () => selectedTab.value = 1,
                ),
                _TabButton(
                  label: 'Tìm kiếm',
                  icon: Icons.search,
                  isSelected: selectedTab.value == 2,
                  onTap: () => selectedTab.value = 2,
                ),
                if (conversation.type.toUpperCase() == 'GROUP')
                  _TabButton(
                    label: 'Members',
                    icon: Icons.people_outline,
                    isSelected: selectedTab.value == 3,
                    onTap: () => selectedTab.value = 3,
                  ),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: IndexedStack(
              index: selectedTab.value,
              children: [
                // Overview tab
                SettingsSectionWidget(conversation: conversation),

                // Media tab
                MediaGridWidget(conversationId: conversation.id.toString()),

                // Search tab
                MessageSearchWidget(conversationId: conversation.id.toString()),

                // Members tab (only for groups)
                if (conversation.type.toUpperCase() == 'GROUP')
                  MembersListWidget(conversation: conversation),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? colors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.6),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

