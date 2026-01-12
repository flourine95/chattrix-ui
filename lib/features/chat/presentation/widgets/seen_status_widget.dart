import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:flutter/material.dart';

/// Widget to display seen status with avatars (Messenger style)
class SeenStatusWidget extends StatelessWidget {
  const SeenStatusWidget({super.key, required this.message, required this.isGroup, this.compact = false});

  final Message message;
  final bool isGroup;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Not read yet - show nothing (Messenger style)
    if (message.readCount == 0) {
      return const SizedBox.shrink();
    }

    // Read - show avatars
    if (compact) {
      return _buildCompactSeenStatus(context, isDark);
    } else {
      return _buildFullSeenStatus(context, isDark);
    }
  }

  /// Compact mode for chat list - show all avatars for groups
  Widget _buildCompactSeenStatus(BuildContext context, bool isDark) {
    if (message.readBy.isEmpty) {
      return const SizedBox.shrink();
    }

    // For groups, show all avatars stacked
    if (isGroup && message.readCount > 1) {
      return _buildStackedAvatars(context, isDark);
    }

    // For direct chat or single reader, show single avatar
    final firstReader = message.readBy.first;
    return _buildSmallAvatar(avatarUrl: firstReader.avatarUrl, displayName: firstReader.fullName, size: 14);
  }

  /// Build stacked avatars for group chats
  Widget _buildStackedAvatars(BuildContext context, bool isDark) {
    // Show all avatars (no limit for compact mode in chat list)
    final displayReaders = message.readBy.toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _calculateStackedWidthCompact(displayReaders.length),
          height: 14,
          child: Stack(
            children: [
              for (int i = 0; i < displayReaders.length; i++)
                Positioned(
                  left: i * 10.0, // Offset each avatar by 10px for compact mode
                  child: _buildSmallAvatar(
                    avatarUrl: displayReaders[i].avatarUrl,
                    displayName: displayReaders[i].fullName,
                    size: 14,
                    hasBorder: true,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Calculate width for stacked avatars (compact mode)
  double _calculateStackedWidthCompact(int count) {
    if (count == 1) return 14;
    return 14 + ((count - 1) * 10);
  }

  /// Full mode for chat view - stacked avatars with tap interaction
  Widget _buildFullSeenStatus(BuildContext context, bool isDark) {
    if (message.readBy.isEmpty) {
      return const SizedBox.shrink();
    }

    // Show up to 3 avatars
    final displayReaders = message.readBy.take(3).toList();
    final remainingCount = message.readCount - displayReaders.length;

    return GestureDetector(
      onTap: isGroup && message.readCount > 1 ? () => _showSeenByBottomSheet(context) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stacked avatars
          SizedBox(
            width: _calculateStackedWidth(displayReaders.length),
            height: 18,
            child: Stack(
              children: [
                for (int i = 0; i < displayReaders.length; i++)
                  Positioned(
                    left: i * 12.0, // Offset each avatar by 12px
                    child: _buildSmallAvatar(
                      avatarUrl: displayReaders[i].avatarUrl,
                      displayName: displayReaders[i].fullName,
                      size: 18,
                      hasBorder: true,
                    ),
                  ),
              ],
            ),
          ),
          // "+X" indicator if more than 3 readers
          if (remainingCount > 0) ...[
            const SizedBox(width: 4),
            Text(
              '+$remainingCount',
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Calculate width for stacked avatars
  double _calculateStackedWidth(int count) {
    if (count == 1) return 18;
    return 18 + ((count - 1) * 12);
  }

  /// Build small circular avatar with optional border
  Widget _buildSmallAvatar({
    required String? avatarUrl,
    required String displayName,
    required double size,
    bool hasBorder = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: hasBorder
          ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            )
          : null,
      child: UserAvatar(avatarUrl: avatarUrl, displayName: displayName, radius: size / 2),
    );
  }

  /// Show bottom sheet with full list of readers
  void _showSeenByBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => _SeenByBottomSheet(message: message),
    );
  }
}

/// Bottom sheet showing full list of people who read the message
class _SeenByBottomSheet extends StatelessWidget {
  const _SeenByBottomSheet({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Seen by ${message.readCount}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const Divider(),
          // List of readers
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: message.readBy.length,
              itemBuilder: (context, index) {
                final reader = message.readBy[index];
                return ListTile(
                  leading: UserAvatar(avatarUrl: reader.avatarUrl, displayName: reader.fullName, radius: 20),
                  title: Text(
                    reader.fullName,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    _formatReadTime(reader.readAt),
                    style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatReadTime(DateTime readAt) {
    final now = DateTime.now();
    final difference = now.difference(readAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
