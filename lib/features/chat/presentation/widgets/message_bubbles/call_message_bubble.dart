import 'dart:convert';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Call message bubble - displays call information like Messenger/Zalo
class CallMessageBubble extends StatelessWidget {
  const CallMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onPin,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
    this.onForward,
    this.onScrollToMessage,
    this.isGroup = false,
    this.isLastMessage = false,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onPin;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final ReplyToMessage? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onForward;
  final Function(int messageId)? onScrollToMessage;
  final bool isGroup;
  final bool isLastMessage;

  @override
  Widget build(BuildContext context) {
    final metadata = message.metadata;
    final callType = metadata?['callType']?.toString().toUpperCase() ?? 'VOICE';
    final callStatus = metadata?['callStatus']?.toString().toUpperCase() ?? 'ENDED';
    final durationSeconds = metadata?['durationSeconds'] as int?;

    // Icons and colors based on call type and status
    final isVideo = callType == 'VIDEO';
    final isMissed = callStatus == 'MISSED';
    
    IconData icon;
    Color iconColor;
    String statusText;

    if (isMissed) {
      icon = isVideo ? Icons.videocam_off : Icons.phone_missed;
      iconColor = Colors.red;
      statusText = 'Missed call';
    } else {
      icon = isVideo ? Icons.videocam : Icons.phone;
      iconColor = isMe ? Colors.green : Colors.blue;
      
      if (durationSeconds != null && durationSeconds > 0) {
        final minutes = durationSeconds ~/ 60;
        final seconds = durationSeconds % 60;
        statusText = minutes > 0 ? '${minutes}m ${seconds}s' : '${seconds}s';
      } else {
        statusText = 'Call ended';
      }
    }

    return BaseBubbleContainer(
      isMe: isMe,
      message: message,
      onReply: onReply,
      onPin: onPin,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      onEdit: onEdit,
      onDelete: onDelete,
      onForward: onForward,
      onScrollToMessage: onScrollToMessage,
      isGroup: isGroup,
      isLastMessage: isLastMessage,
      maxWidth: 280,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Call icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Call info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isVideo ? 'Video call' : 'Voice call',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isMe ? Colors.black87 : Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusText,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: isMe 
                        ? Colors.black54 
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
