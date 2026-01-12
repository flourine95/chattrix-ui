import 'package:flutter/material.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/entities/birthday_user_entity.dart';

class BirthdayListSheet extends StatelessWidget {
  final List<BirthdayUserEntity> users;
  final Function(BirthdayUserEntity) onSendWishes;

  const BirthdayListSheet({super.key, required this.users, required this.onSendWishes});

  @override
  Widget build(BuildContext context) {
    final todayBirthdays = users.where((u) => u.isBirthdayToday).toList();

    if (todayBirthdays.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎂', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text('No birthdays today', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
      );
    }

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
                const Text('🎂 Birthdays Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(),

          // Birthday list
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: todayBirthdays.length,
              itemBuilder: (context, index) {
                final user = todayBirthdays[index];
                return _BirthdayListItem(user: user, onSendWishes: () => onSendWishes(user));
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              UserAvatar(avatarUrl: user.avatarUrl, displayName: user.fullName, radius: 30),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Text('🎂', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (user.age != null)
                  Text('Turning ${user.age}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                Text(
                  user.birthdayMessage,
                  style: const TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: ElevatedButton.icon(
              onPressed: onSendWishes,
              icon: const Icon(Icons.send, size: 16),
              label: const Text('Send'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
