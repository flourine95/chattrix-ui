
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class OnlineUserItem extends StatelessWidget {
  final User user;
  final String? note;
  final VoidCallback onTap;

  const OnlineUserItem({
    super.key,
    required this.user,
    this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasNote = note != null && note!.isNotEmpty;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      label: hasNote
          ? '${user.username}\'s story: $note. Double tap to view.'
          : '${user.username} is online. Double tap to chat.',
      button: true,
      enabled: true,
      child: GestureDetector(
        onTap: onTap,
        // Sử dụng SizedBox(width: 64) để khớp với _MyStoryItem
        child: SizedBox(
          width: 64,
          // Column này phải có tổng chiều cao <= 88px
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Note bubble (ĐÃ SỬA: Giới hạn 1 dòng và giảm padding/khoảng cách)
              if (hasNote) ...[
                Container(
                  constraints: const BoxConstraints(maxWidth: 64),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Giữ padding nhỏ
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary, // Dùng màu primary
                    borderRadius: BorderRadius.circular(8),
                    // Có thể dùng border màu khác tùy theme
                    border: Border.all(
                      color: isDark ? Colors.transparent : Colors.white.withValues(alpha: 0.8),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    note!,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onPrimary,
                      height: 1.1,
                    ),
                    maxLines: 1, // *QUAN TRỌNG: Giới hạn 1 dòng để tránh Overflow (tổng 88px)*
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 2), // *QUAN TRỌNG: Khoảng cách 2px*
              ] else ...[
                // Nếu không có note, thêm khoảng trống để căn chỉnh avatar tương đương MyStoryItem
                const SizedBox(height: 20),
              ],

              // Avatar with Online Status Indicator
              SizedBox(
                height: 52, // Kích thước avatar 52x52
                width: 52,
                child: Stack(
                  children: [
                    UserAvatar(
                      avatarUrl: user.avatarUrl,
                      displayName: user.username,
                      radius: 26, // Radius 26 -> 52x52
                    ),

                    // Vòng tròn trạng thái online (nếu cần)
                    // Nếu UserAvatar đã có logic hiển thị trạng thái online, có thể bỏ qua phần này.
                    // Nếu cần thêm vòng border cho Story
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.primary, // Màu border Story
                          width: 2.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2), // *QUAN TRỌNG: Khoảng cách 2px*

              // Name below avatar
              Text(
                user.username,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}