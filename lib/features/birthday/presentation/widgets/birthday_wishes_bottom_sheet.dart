import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../../core/domain/enums/enums.dart';
import '../../../chat/data/models/chat_message_request.dart';
import '../../../chat/presentation/state/conversations_notifier.dart';
import '../../../chat/domain/entities/conversation.dart';
import '../../../chat/presentation/providers/chat_usecase_provider.dart';
import '../../domain/entities/birthday_user_entity.dart';

/// Bottom sheet for sending birthday wishes directly to user
class BirthdayWishesBottomSheet extends HookConsumerWidget {
  final BirthdayUserEntity user;

  const BirthdayWishesBottomSheet({super.key, required this.user});

  static const List<String> _templates = [
    '🎂 Happy Birthday! 🎉',
    '🎈 Happy Birthday! Wishing you a wonderful year ahead! 🎊',
    '🎁 Happy Birthday! May all your wishes come true! 💝',
    '🎉 Happy Birthday! Have an amazing day! 🎂',
    '🌟 Wishing you a fantastic birthday filled with joy! 🎈',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    void sendDirectMessage() async {
      final message = messageController.text.trim();
      if (message.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.warning_amber, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Please enter a message'),
              ],
            ),
            backgroundColor: Colors.orange.shade900,
          ),
        );
        return;
      }

      // Find 1-1 conversation with this user
      final conversationsAsync = ref.read(conversationsProvider);
      final conversations = conversationsAsync.value ?? [];

      // Find direct conversation with this user
      final directConversation = conversations.firstWhere(
        (c) => c.type == ConversationType.direct && c.participants.any((p) => p.userId == user.userId),
        orElse: () => Conversation(
          id: 0,
          type: ConversationType.direct,
          participants: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      if (directConversation.id == 0) {
        // No conversation found
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('No conversation found with ${user.fullName}. Please start a chat first.')),
              ],
            ),
            backgroundColor: Colors.orange.shade900,
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }

      // Close bottom sheet first
      if (!context.mounted) return;
      Navigator.pop(context);

      // Send message directly
      try {
        final usecase = ref.read(sendMessageUsecaseProvider);
        final request = ChatMessageRequest(content: message, type: 'TEXT');

        await usecase(conversationId: directConversation.id.toString(), request: request);

        // Navigate to conversation
        if (!context.mounted) return;
        context.push('/chat/${directConversation.id}');

        // Show success message
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                const Text('Birthday wishes sent!', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to send: $e', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('🎂', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Send Birthday Wishes', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(
                        'Send a direct message to ${user.fullName}',
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        UserAvatar(avatarUrl: user.avatarUrl, displayName: user.fullName, radius: 30),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.fullName, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                '@${user.username}',
                                style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                              ),
                              if (user.age != null) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Turning ${user.age}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Message templates
                  Text('Quick Templates', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _templates.map((template) {
                      return ActionChip(
                        label: Text(template),
                        onPressed: () {
                          messageController.text = template;
                        },
                        backgroundColor: colors.surface,
                        side: BorderSide(color: colors.primary.withValues(alpha: 0.3)),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Custom message
                  Text('Your Message', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your birthday wishes...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: colors.surface,
                    ),
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: sendDirectMessage,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.send, size: 20),
                    label: const Text('Send Message'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
