import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/scheduled_message.dart';
import '../state/scheduled_messages_notifier.dart';
import 'schedule_message_dialog.dart';

/// Dialog để sửa tin nhắn hẹn giờ
class EditScheduledMessageDialog extends HookConsumerWidget {
  final ScheduledMessage message;

  const EditScheduledMessageDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentController = useTextEditingController(text: message.content);
    // If scheduledTime is null, use current time + 1 hour as default
    final defaultTime = message.scheduledTime ?? DateTime.now().add(const Duration(hours: 1));
    final selectedDateTime = useState(defaultTime);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.edit, color: Colors.blue),
                const SizedBox(width: 12),
                const Text('Sửa tin nhắn hẹn giờ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 20),

            // Content input
            const Text(
              'Nội dung tin nhắn',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung tin nhắn',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),

            // Scheduled time
            const Text(
              'Thời gian gửi',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                // Show schedule dialog to pick new time
                await showDialog(
                  context: context,
                  builder: (context) => ScheduleMessageDialog(
                    initialDateTime: selectedDateTime.value,
                    onSchedule: (newDateTime) {
                      selectedDateTime.value = newDateTime;
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, size: 20, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('HH:mm, dd/MM/yyyy').format(selectedDateTime.value),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    const Icon(Icons.edit, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Hủy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final newContent = contentController.text.trim();
                      if (newContent.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng nhập nội dung tin nhắn'), backgroundColor: Colors.red),
                        );
                        return;
                      }

                      if (selectedDateTime.value.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thời gian hẹn phải trong tương lai'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      try {
                        await ref
                            .read(scheduledMessagesProvider(status: 'PENDING').notifier)
                            .updateScheduledMessage(
                              scheduledMessageId: message.id,
                              content: newContent != message.content ? newContent : null,
                              scheduledTime: selectedDateTime.value != message.scheduledTime
                                  ? selectedDateTime.value
                                  : null,
                            );

                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã cập nhật tin nhắn hẹn giờ'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.red));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Lưu'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
