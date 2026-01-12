import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../chat/domain/entities/conversation.dart';
import '../../domain/entities/birthday_user_entity.dart';
import '../providers/birthday_providers.dart';

class BirthdayWishesDialog extends HookConsumerWidget {
  final BirthdayUserEntity user;
  final List<Conversation> conversations;
  final VoidCallback? onSendDirect;

  const BirthdayWishesDialog({super.key, required this.user, required this.conversations, this.onSendDirect});

  static const List<String> _templates = [
    '🎂 Chúc mừng sinh nhật! 🎉',
    '🎈 Happy Birthday! Chúc bạn tuổi mới vui vẻ! 🎊',
    '🎁 Sinh nhật vui vẻ! Chúc bạn luôn hạnh phúc! 💝',
    '🎉 Chúc mừng sinh nhật! Tuổi mới nhiều niềm vui! 🎂',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedConversations = useState<Set<int>>({});
    final messageController = useTextEditingController();
    final isLoading = useState(false);

    Future<void> sendWishes() async {
      if (selectedConversations.value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ít nhất một nhóm chat hoặc bấm "Gửi trực tiếp"'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      isLoading.value = true;

      try {
        debugPrint('🎂 Sending birthday wishes...');
        debugPrint('   User ID: ${user.userId}');
        debugPrint('   Conversations: ${selectedConversations.value.toList()}');
        debugPrint('   Message: ${messageController.text.isEmpty ? "null" : messageController.text}');

        final useCase = ref.read(sendBirthdayWishesUseCaseProvider);
        final result = await useCase(
          userId: user.userId,
          conversationIds: selectedConversations.value.toList(),
          customMessage: messageController.text.isEmpty ? null : messageController.text,
        );

        debugPrint('🎂 Result received: ${result.isRight() ? "Success" : "Failure"}');

        result.fold(
          (failure) {
            debugPrint('❌ Birthday wishes failed: ${failure.message}');
            debugPrint('   Code: ${failure.code}');
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ Lỗi: ${failure.message}\nCode: ${failure.code}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          },
          (_) {
            debugPrint('✅ Birthday wishes sent successfully');
            if (!context.mounted) return;
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Đã gửi lời chúc thành công!'), backgroundColor: Colors.green),
            );
          },
        );
      } catch (e, stackTrace) {
        debugPrint('💥 Exception in sendWishes: $e');
        debugPrint('Stack trace: $stackTrace');
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('💥 Lỗi không mong đợi: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }

    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text('🎂', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Gửi lời chúc cho ${user.fullName}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          UserAvatar(avatarUrl: user.avatarUrl, displayName: user.fullName, radius: 25),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                if (user.age != null)
                                  Text('${user.age} tuổi', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Select conversations
                    const Text('Chọn nhóm chat (tùy chọn):', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      'Hoặc bấm "Gửi trực tiếp" để nhắn riêng',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    if (conversations.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                        child: const Text('Không có nhóm chat nào', style: TextStyle(color: Colors.grey)),
                      )
                    else
                      ...conversations.map((conv) {
                        final isSelected = selectedConversations.value.contains(conv.id);
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (value) {
                            final newSet = Set<int>.from(selectedConversations.value);
                            if (value == true) {
                              newSet.add(conv.id);
                            } else {
                              newSet.remove(conv.id);
                            }
                            selectedConversations.value = newSet;
                          },
                          title: Text(conv.name ?? 'Conversation'),
                          secondary: UserAvatar(avatarUrl: conv.avatarUrl, displayName: conv.name ?? 'C', radius: 20),
                        );
                      }),
                    const SizedBox(height: 16),

                    // Message templates
                    const Text('Chọn mẫu tin nhắn:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _templates.map((template) {
                        return ActionChip(
                          label: Text(template),
                          onPressed: () {
                            messageController.text = template;
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Custom message
                    TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        labelText: 'Hoặc nhập lời chúc của bạn',
                        hintText: 'Nhập lời chúc...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),

            // Actions
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: isLoading.value ? null : () => Navigator.pop(context),
                    child: const Text('Hủy'),
                  ),
                  const SizedBox(width: 8),
                  if (onSendDirect != null) ...[
                    SizedBox(
                      width: 120,
                      child: OutlinedButton(
                        onPressed: isLoading.value
                            ? null
                            : () {
                                Navigator.pop(context);
                                onSendDirect!();
                              },
                        child: const Text('Gửi trực tiếp'),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: isLoading.value || selectedConversations.value.isEmpty ? null : sendWishes,
                      child: isLoading.value
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Gửi vào nhóm'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
