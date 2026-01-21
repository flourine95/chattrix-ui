import 'package:flutter/material.dart';
import 'package:chattrix_ui/features/birthday/domain/entities/birthday_user_entity.dart';

class BirthdayBanner extends StatelessWidget {
  final List<BirthdayUserEntity> users;
  final VoidCallback onTap;

  const BirthdayBanner({super.key, required this.users, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Filter only today's birthdays
    final todayBirthdays = users.where((u) => u.isBirthdayToday).toList();

    if (todayBirthdays.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2416) : const Color(0xFFFFF9E6);
    final borderColor = isDark ? const Color(0xFF3D3020) : const Color(0xFFFFE066);
    final textColor = isDark ? const Color(0xFFFFE066) : const Color(0xFF8B6914);

    return Material(
      color: bgColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: borderColor.withValues(alpha: 0.2),
                width: 0.5, // Separated List style
              ),
            ),
          ),
          child: Row(
            children: [
              // Cake icon in circular container
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF3D3020) : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Text('🎂', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12), // Standard spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title - Body Large (14px) bold
                    Text(
                      todayBirthdays.length == 1
                          ? 'It\'s ${todayBirthdays[0].fullName}\'s birthday today!'
                          : '${todayBirthdays.length} birthdays today!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Subtitle - Body Small (12px)
                    Text(
                      'Tap to send wishes',
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: textColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
