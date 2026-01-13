import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// AppBar for chat view
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic conversation;
  final dynamic me;
  final bool isDark;
  final VoidCallback onAudioCall;
  final VoidCallback onVideoCall;
  final VoidCallback onInfo;

  const ChatAppBar({
    super.key,
    required this.conversation,
    required this.me,
    required this.isDark,
    required this.onAudioCall,
    required this.onVideoCall,
    required this.onInfo,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    if (conversation == null) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        surfaceTintColor: Colors.transparent,
      );
    }

    final title = ConversationUtils.getConversationTitle(conversation, me);
    final bool isGroup = conversation.type == ConversationType.group;

    String? avatarUrl;
    if (isGroup) {
      avatarUrl = conversation.avatarUrl;
    } else {
      avatarUrl = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);
    }

    final bool isOnline = isGroup ? false : ConversationUtils.isUserOnline(conversation, me);

    return AppBar(
      backgroundColor: appBarColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      scrolledUnderElevation: 2,
      leadingWidth: 40,
      leading: BackButton(
        color: color,
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
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (!isGroup) ...[
                  const SizedBox(height: 2),
                  Text(
                    ConversationUtils.formatLastSeen(
                      isOnline,
                      ConversationUtils.getLastSeen(conversation, me),
                    ),
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
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
          icon: Icon(Icons.call_outlined, color: color, size: 24),
          onPressed: onAudioCall,
          tooltip: 'Audio call',
        ),
        IconButton(
          icon: Icon(Icons.videocam_outlined, color: color, size: 26),
          onPressed: onVideoCall,
          tooltip: 'Video call',
        ),
        IconButton(
          icon: Icon(Icons.info_outline, color: color, size: 24),
          onPressed: onInfo,
          tooltip: 'Thông tin',
        ),
      ],
    );
  }
}
