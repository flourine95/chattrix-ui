import 'package:flutter/material.dart';
import '../../domain/entities/birthday_user_entity.dart';

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
            border: Border(bottom: BorderSide(color: borderColor, width: 1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF3D3020) : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Text('🎂', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todayBirthdays.length == 1
                          ? 'Hôm nay là sinh nhật của ${todayBirthdays[0].fullName}!'
                          : 'Hôm nay có ${todayBirthdays.length} người sinh nhật!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Nhấn để gửi lời chúc',
                      style: TextStyle(fontSize: 12, color: textColor.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: textColor),
            ],
          ),
        ),
      ),
    );
  }
}
