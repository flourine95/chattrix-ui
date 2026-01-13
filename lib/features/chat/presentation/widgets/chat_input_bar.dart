import 'package:chattrix_ui/features/chat/presentation/widgets/mention_text_field.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/input_bar_config.dart';
import 'package:flutter/material.dart';

/// Simplified InputBar using config objects to reduce parameter explosion
class ChatInputBar extends StatelessWidget {
  final InputBarConfig config;
  final InputBarState state;
  final InputBarCallbacks callbacks;

  const ChatInputBar({
    super.key,
    required this.config,
    required this.state,
    required this.callbacks,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    // Show recording overlay when recording
    if (state.isRecording) {
      return _buildRecordingOverlay(isDark, primaryColor);
    }

    return _buildNormalInputBar(isDark, primaryColor);
  }

  Widget _buildRecordingOverlay(bool isDark, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDuration(state.recordingDuration),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Recording...',
                    style: TextStyle(
                      color: (isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: callbacks.onCancelRecording,
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: callbacks.onVoiceRecord,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(70, 40),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.send, size: 18),
                  SizedBox(width: 6),
                  Text('Send'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalInputBar(bool isDark, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // + button
            Container(
              decoration: BoxDecoration(
                color: state.showAttachmentPicker
                    ? primaryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add_circle_outline, color: primaryColor, size: 28),
                onPressed: callbacks.onToggleAttachmentPicker,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Gallery button
            Container(
              decoration: BoxDecoration(
                color: state.showGallery
                    ? primaryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.image_outlined, color: primaryColor, size: 26),
                onPressed: callbacks.onToggleGallery,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Mic button (when no text)
            if (!state.canSendMessage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: callbacks.onVoiceRecord,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.mic_none, color: primaryColor, size: 26),
                  ),
                ),
              ),
            // Text input
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 40, maxHeight: 120),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF303030)
                      : const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MentionTextField(
                  controller: config.controller,
                  focusNode: config.focusNode,
                  maxLines: null,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                  users: config.conversation?.participants
                          .map<MentionableUser>(
                            (p) => MentionableUser(
                              id: p.userId,
                              name: p.fullName ?? p.username,
                              avatarUrl: p.avatarUrl,
                            ),
                          )
                          .toList() ??
                      [],
                  onMentionAdded: (user) {
                    debugPrint('Mentioned user: ${user.name}');
                  },
                  decoration: InputDecoration(
                    hintText: 'Aa',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ),
            // Like button (when no text)
            if (!state.canSendMessage)
              IconButton(
                icon: Icon(Icons.thumb_up_outlined, color: primaryColor, size: 24),
                onPressed: callbacks.onSend,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            // Send button (when has text)
            if (state.canSendMessage)
              IconButton(
                icon: Icon(Icons.send, color: primaryColor),
                onPressed: callbacks.onSend,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
          ],
        ),
      ),
    );
  }
}
