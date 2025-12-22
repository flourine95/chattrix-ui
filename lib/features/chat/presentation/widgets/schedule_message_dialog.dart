import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

/// Dialog để chọn thời gian hẹn giờ gửi tin nhắn
///
/// UI tham khảo từ Zalo với các quick actions và date/time picker
class ScheduleMessageDialog extends HookWidget {
  final DateTime? initialDateTime;
  final Function(DateTime) onSchedule;

  const ScheduleMessageDialog({super.key, this.initialDateTime, required this.onSchedule});

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<DateTime>(initialDateTime ?? DateTime.now().add(const Duration(hours: 1)));
    final selectedTime = useState<TimeOfDay>(TimeOfDay.fromDateTime(selectedDate.value));

    // Combine date and time
    DateTime getScheduledDateTime() {
      return DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute,
      );
    }

    // Quick action buttons
    Widget buildQuickAction(String label, Duration duration) {
      return OutlinedButton(
        onPressed: () {
          final newDateTime = DateTime.now().add(duration);
          selectedDate.value = newDateTime;
          selectedTime.value = TimeOfDay.fromDateTime(newDateTime);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label),
      );
    }

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
                const Icon(Icons.schedule, color: Colors.blue),
                const SizedBox(width: 12),
                const Text('Hẹn giờ gửi tin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 20),

            // Quick actions
            const Text(
              'Chọn nhanh',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                buildQuickAction('1 giờ nữa', const Duration(hours: 1)),
                buildQuickAction('3 giờ nữa', const Duration(hours: 3)),
                buildQuickAction(
                  'Sáng mai 9h',
                  Duration(
                    days: DateTime.now().hour >= 9 ? 1 : 0,
                    hours: 9 - DateTime.now().hour,
                    minutes: -DateTime.now().minute,
                  ),
                ),
                buildQuickAction(
                  'Chiều mai 18h',
                  Duration(
                    days: DateTime.now().hour >= 18 ? 1 : 0,
                    hours: 18 - DateTime.now().hour,
                    minutes: -DateTime.now().minute,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Date picker
            const Text(
              'Chọn ngày',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.blue)),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  selectedDate.value = picked;
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(DateFormat('dd/MM/yyyy').format(selectedDate.value), style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Time picker
            const Text(
              'Chọn giờ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.blue)),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  selectedTime.value = picked;
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 20, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(selectedTime.value.format(context), style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Preview
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tin nhắn sẽ được gửi vào ${DateFormat('HH:mm, dd/MM/yyyy').format(getScheduledDateTime())}',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ],
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
                    onPressed: () {
                      final scheduledDateTime = getScheduledDateTime();
                      if (scheduledDateTime.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thời gian hẹn phải trong tương lai'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      Navigator.pop(context);
                      onSchedule(scheduledDateTime);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Hẹn giờ'),
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
