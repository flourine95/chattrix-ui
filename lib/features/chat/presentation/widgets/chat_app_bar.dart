import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Conversation? conversation;
  final User? me;
  final VoidCallback onAudioCall;
  final VoidCallback onVideoCall;
  final VoidCallback onInfo;

  const ChatAppBar({
    super.key,
    required this.conversation,
    required this.me,
    required this.onAudioCall,
    required this.onVideoCall,
    required this.onInfo,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (conversation == null) {
      return AppBar(elevation: 0, backgroundColor: theme.scaffoldBackgroundColor, surfaceTintColor: Colors.transparent);
    }

    final safeConversation = conversation!;

    final title = ConversationUtils.getConversationTitle(safeConversation, me);
    final bool isGroup = safeConversation.type == ConversationType.group;

    final String? avatarUrl = isGroup
        ? safeConversation.avatarUrl
        : ConversationUtils.getOtherParticipantAvatarUrl(safeConversation, me);

    final bool isOnline = isGroup ? false : ConversationUtils.isUserOnline(safeConversation, me);

    final contentColor = colorScheme.onSurface;

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      scrolledUnderElevation: 1,
      leadingWidth: 40,
      leading: BackButton(
        color: contentColor,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
      ),
      title: Row(
        children: [
          UserAvatar(avatarUrl: avatarUrl, displayName: title, radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: contentColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (!isGroup) ...[
                  const SizedBox(height: 2),
                  Text(
                    ConversationUtils.formatLastSeen(isOnline, ConversationUtils.getLastSeen(safeConversation, me)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined),
          color: contentColor,
          iconSize: 24,
          onPressed: onAudioCall,
          tooltip: 'Audio Call',
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined),
          color: contentColor,
          iconSize: 26,
          onPressed: onVideoCall,
          tooltip: 'Video Call',
        ),
        IconButton(
          icon: const Icon(Icons.info_outline),
          color: contentColor,
          iconSize: 24,
          onPressed: onInfo,
          tooltip: 'Conversation Info',
        ),
      ],
    );
  }
}
