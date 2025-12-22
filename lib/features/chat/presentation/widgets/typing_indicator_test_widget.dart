import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/typing_indicator_widget.dart';

class TypingIndicatorTestWidget extends ConsumerWidget {
  final String conversationId;
  final int? currentUserId;

  const TypingIndicatorTestWidget({super.key, required this.conversationId, this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.2),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🧪 TYPING INDICATOR TEST', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Nhấn các nút bên dưới để test typing indicator:'),
          const SizedBox(height: 12),

          // Test với 1 user
          ElevatedButton(
            onPressed: () {
              _showTestTyping(context, 1);
            },
            child: const Text('Test: 1 người đang gõ'),
          ),
          const SizedBox(height: 8),

          // Test với 2 users
          ElevatedButton(
            onPressed: () {
              _showTestTyping(context, 2);
            },
            child: const Text('Test: 2 người đang gõ'),
          ),
          const SizedBox(height: 8),

          // Test với nhiều users
          ElevatedButton(
            onPressed: () {
              _showTestTyping(context, 5);
            },
            child: const Text('Test: 5 người đang gõ'),
          ),
          const SizedBox(height: 8),

          // Clear typing
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              _showTestTyping(context, 0);
            },
            child: const Text('Clear typing indicator'),
          ),
        ],
      ),
    );
  }

  void _showTestTyping(BuildContext context, int userCount) {
    final List<TypingUser> typingUsers = [];

    for (int i = 0; i < userCount; i++) {
      typingUsers.add(TypingUser(id: '${100 + i}', username: 'testuser$i', fullName: 'Test User ${i + 1}'));
    }

    final testIndicator = TypingIndicator(conversationId: conversationId, typingUsers: typingUsers);

    // Show dialog với typing indicator
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Typing Indicator Preview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Số người đang gõ: $userCount'),
            const SizedBox(height: 16),
            TypingIndicatorWidget(typingIndicator: testIndicator, currentUserId: currentUserId),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng'))],
      ),
    );
  }
}
