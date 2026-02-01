import 'package:flutter/material.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';


class BirthdayListSheet extends StatelessWidget {
  final List<BirthdayUserEntity> users;
  final Function(BirthdayUserEntity) onSendWishes;

  const BirthdayListSheet({super.key, required this.users, required this.onSendWishes});

  @override
  Widget build(BuildContext context) {
    final todayBirthdays = users.where((u) => u.isBirthdayToday).toList();
    final colors = Theme.of(context).colorScheme;

    if (todayBirthdays.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cake_outlined, size: 64, color: Colors.grey[400]), // Empty state icon
            const SizedBox(height: 16),
            Text(
              'No birthdays today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back tomorrow!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header - Heading Small (18px)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('🎂', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Birthdays Today',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Divider - Separated List style
          Divider(
            height: 1,
            thickness: 0.5,
            color: colors.onSurface.withValues(alpha: 0.2),
          ),

          // Birthday list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: todayBirthdays.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 76, // Align with text after avatar
                color: colors.onSurface.withValues(alpha: 0.2),
              ),
              itemBuilder: (context, index) {
                final user = todayBirthdays[index];
                return _BirthdayListItem(
                  user: user,
                  onSendWishes: () => onSendWishes(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BirthdayListItem extends StatelessWidget {
  final BirthdayUserEntity user;
  final VoidCallback onSendWishes;

  const _BirthdayListItem({required this.user, required this.onSendWishes});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar with birthday badge
          Stack(
            children: [
              UserAvatar(
                avatarUrl: user.avatarUrl,
                displayName: user.fullName,
                radius: 24, // Standard avatar size
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.surface, width: 2),
                  ),
                  child: const Text('🎂', style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12), // Standard spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name - Body Large (16px) bold
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                // Age - Body Medium (14px)
                if (user.age != null)
                  Text(
                    'Turning ${user.age}',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                // Only show birthday message if NOT today (e.g., "Tomorrow", "In 3 days")
                if (!user.isBirthdayToday)
                  Text(
                    user.birthdayMessage,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFFCA28), // Warning color from glossary
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Primary Button (Rounded) - border radius 24
          SizedBox(
            width: 100, // Fixed width to prevent infinite constraints
            child: ElevatedButton.icon(
              onPressed: onSendWishes,
              icon: const Icon(Icons.send, size: 18),
              label: const Text('Send'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24), // Very rounded
                ),
                elevation: 0, // Flat design
              ),
            ),
          ),
        ],
      ),
    );
  }
}
