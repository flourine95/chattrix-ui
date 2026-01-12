import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

/// iOS-style time picker bottom sheet
///
/// Shows 2 tabs: "Date & Time" and "Quick"
class TimePickerBottomSheet extends HookWidget {
  const TimePickerBottomSheet({super.key, required this.initialTime});

  final DateTime initialTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final mediaQuery = MediaQuery.of(context);

    final selectedTab = useState(0);
    final selectedTime = useState(initialTime);

    return Container(
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.9),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Select Time', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _TabButton(
                        label: 'Date & Time',
                        isSelected: selectedTab.value == 0,
                        onTap: () => selectedTab.value = 0,
                      ),
                    ),
                    Expanded(
                      child: _TabButton(
                        label: 'Quick',
                        isSelected: selectedTab.value == 1,
                        onTap: () => selectedTab.value = 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Content
            Flexible(
              child: selectedTab.value == 0
                  ? _DateTimePicker(initialTime: selectedTime.value, onTimeChanged: (time) => selectedTime.value = time)
                  : _QuickOptions(onTimeSelected: (time) => selectedTime.value = time),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, selectedTime.value),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
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

  /// Show the time picker bottom sheet
  static Future<DateTime?> show(BuildContext context, {required DateTime initialTime}) {
    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TimePickerBottomSheet(initialTime: initialTime),
    );
  }
}

/// Tab button widget
class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected ? colors.onPrimary : colors.onSurface,
          ),
        ),
      ),
    );
  }
}

/// Date & Time picker (iOS style)
class _DateTimePicker extends HookWidget {
  const _DateTimePicker({required this.initialTime, required this.onTimeChanged});

  final DateTime initialTime;
  final ValueChanged<DateTime> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Ensure initialTime is not in the past
    final now = DateTime.now();
    final safeInitialTime = initialTime.isBefore(now) ? now : initialTime;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Selected time display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule, color: colors.onPrimaryContainer),
                const SizedBox(width: 12),
                Text(
                  DateFormat('HH:mm, dd/MM/yyyy').format(safeInitialTime),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // iOS-style date picker
          Container(
            height: 200,
            decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
            child: CupertinoTheme(
              data: CupertinoThemeData(brightness: theme.brightness, primaryColor: colors.primary),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: safeInitialTime,
                minimumDate: now,
                onDateTimeChanged: onTimeChanged,
                use24hFormat: true,
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Quick time options
class _QuickOptions extends HookWidget {
  const _QuickOptions({required this.onTimeSelected});

  final ValueChanged<DateTime> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final selectedIndex = useState<int?>(null);

    final options = [
      _QuickOption(label: '15 minutes', icon: Icons.timer, time: now.add(const Duration(minutes: 15))),
      _QuickOption(label: '30 minutes', icon: Icons.timer, time: now.add(const Duration(minutes: 30))),
      _QuickOption(label: '1 hour', icon: Icons.schedule, time: now.add(const Duration(hours: 1))),
      _QuickOption(label: '3 hours', icon: Icons.schedule, time: now.add(const Duration(hours: 3))),
      _QuickOption(label: '6 hours', icon: Icons.schedule, time: now.add(const Duration(hours: 6))),
      _QuickOption(
        label: 'Tomorrow 9 AM',
        icon: Icons.wb_sunny,
        time: DateTime(now.year, now.month, now.day + 1, 9, 0),
      ),
      _QuickOption(
        label: 'Tomorrow 2 PM',
        icon: Icons.wb_sunny,
        time: DateTime(now.year, now.month, now.day + 1, 14, 0),
      ),
      _QuickOption(
        label: 'Tomorrow 8 PM',
        icon: Icons.nightlight,
        time: DateTime(now.year, now.month, now.day + 1, 20, 0),
      ),
      _QuickOption(label: 'Next week', icon: Icons.calendar_today, time: now.add(const Duration(days: 7))),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final option = options[index];
        return _QuickOptionTile(
          option: option,
          isSelected: selectedIndex.value == index,
          onTap: () {
            selectedIndex.value = index;
            onTimeSelected(option.time);
          },
        );
      },
    );
  }
}

/// Quick option data
class _QuickOption {
  const _QuickOption({required this.label, required this.icon, required this.time});

  final String label;
  final IconData icon;
  final DateTime time;
}

/// Quick option tile
class _QuickOptionTile extends StatelessWidget {
  const _QuickOptionTile({required this.option, required this.isSelected, required this.onTap});

  final _QuickOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      color: isSelected ? colors.primaryContainer : colors.surfaceContainerHighest,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: colors.primary, width: 2) : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.primary : colors.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(option.icon, color: isSelected ? colors.onPrimary : colors.onPrimaryContainer, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? colors.onPrimaryContainer : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('HH:mm, dd/MM/yyyy').format(option.time),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected ? colors.onPrimaryContainer : colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.chevron_right,
                  color: isSelected ? colors.primary : colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
