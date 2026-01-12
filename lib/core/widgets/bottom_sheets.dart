import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Reusable bottom sheet components with consistent design
///
/// Available bottom sheets:
/// - showConfirmationBottomSheet: Yes/No confirmation with icon
/// - showInputBottomSheet: Text input with validation
/// - showTimePickerBottomSheet: iOS-style time picker with quick select
/// - showDatePickerBottomSheet: iOS-style date picker
/// - showOptionsBottomSheet: List of options to select

// ============================================================================
// CONFIRMATION BOTTOM SHEET (Yes/No)
// ============================================================================

/// Show a confirmation bottom sheet with Yes/No buttons
///
/// Returns `true` if user confirms, `false` if user cancels, `null` if dismissed
/// If [onConfirm] is provided, it will be called when user confirms (after bottom sheet closes)
Future<bool?> showConfirmationBottomSheet({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  IconData? icon,
  Color? iconColor,
  Color? confirmColor,
  bool isDangerous = false,
  Future<void> Function()? onConfirm,
}) async {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Icon
            if (icon != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (iconColor ?? (isDangerous ? Colors.red : colors.primary)).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor ?? (isDangerous ? Colors.red : colors.primary), size: 32),
              ),
            if (icon != null) const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Message
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: colors.outline),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(cancelText),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context, true);
                      // Execute callback if provided
                      if (onConfirm != null) {
                        await onConfirm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor ?? (isDangerous ? Colors.red : colors.primary),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(confirmText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// INPUT BOTTOM SHEET
// ============================================================================

/// Show an input bottom sheet with text field
///
/// Returns the input text if user confirms, `null` if cancelled
Future<String?> showInputBottomSheet({
  required BuildContext context,
  required String title,
  String? subtitle,
  String? initialValue,
  String? hintText,
  String? labelText,
  String confirmText = 'Save',
  String cancelText = 'Cancel',
  int? maxLines,
  int? maxLength,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  IconData? prefixIcon,
}) async {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final controller = TextEditingController(text: initialValue);
  String? errorText;

  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            Text(title, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
            ],
            const SizedBox(height: 16),

            // Text field
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: maxLines ?? 1,
              maxLength: maxLength,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                errorText: errorText,
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (validator != null) {
                  setState(() {
                    errorText = validator(value);
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(cancelText),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final value = controller.text.trim();
                      if (validator != null) {
                        final error = validator(value);
                        if (error != null) {
                          setState(() {
                            errorText = error;
                          });
                          return;
                        }
                      }
                      Navigator.pop(context, value);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(confirmText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// TIME PICKER BOTTOM SHEET (iOS Style with Quick Select)
// ============================================================================

/// Show an iOS-style time picker with quick select options
///
/// Returns selected DateTime if user confirms, `null` if cancelled
Future<DateTime?> showTimePickerBottomSheet({
  required BuildContext context,
  DateTime? initialTime,
  String title = 'Select Time',
  String confirmText = 'Done',
  String cancelText = 'Cancel',
  List<QuickTimeOption>? quickOptions,
}) async {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  DateTime selectedTime = initialTime ?? DateTime.now();
  String? selectedQuickOption;

  // Default quick options
  final defaultQuickOptions = [
    QuickTimeOption(label: '5 min', minutes: 5),
    QuickTimeOption(label: '15 min', minutes: 15),
    QuickTimeOption(label: '30 min', minutes: 30),
    QuickTimeOption(label: '1 hour', minutes: 60),
    QuickTimeOption(label: '2 hours', minutes: 120),
    QuickTimeOption(label: '1 day', minutes: 1440),
  ];

  final options = quickOptions ?? defaultQuickOptions;

  return await showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(cancelText)),
                  Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  TextButton(onPressed: () => Navigator.pop(context, selectedTime), child: Text(confirmText)),
                ],
              ),
            ),

            const Divider(height: 1),

            // Quick select options
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  final isSelected = selectedQuickOption == option.label;
                  return ChoiceChip(
                    label: Text(option.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedQuickOption = selected ? option.label : null;
                        if (selected) {
                          selectedTime = DateTime.now().add(Duration(minutes: option.minutes));
                        }
                      });
                    },
                    selectedColor: colors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? colors.onPrimary : colors.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
            ),

            const Divider(height: 1),

            // iOS-style time picker
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: selectedTime,
                minimumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newTime) {
                  setState(() {
                    selectedTime = newTime;
                    selectedQuickOption = null; // Clear quick select
                  });
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

/// Quick time option for time picker
class QuickTimeOption {
  final String label;
  final int minutes;

  QuickTimeOption({required this.label, required this.minutes});
}

// ============================================================================
// DATE PICKER BOTTOM SHEET (iOS Style)
// ============================================================================

/// Show an iOS-style date picker
///
/// Returns selected DateTime if user confirms, `null` if cancelled
Future<DateTime?> showDatePickerBottomSheet({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? minimumDate,
  DateTime? maximumDate,
  String title = 'Select Date',
  String confirmText = 'Done',
  String cancelText = 'Cancel',
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
}) async {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  DateTime selectedDate = initialDate ?? DateTime.now();

  return await showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text(cancelText)),
                Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                TextButton(onPressed: () => Navigator.pop(context, selectedDate), child: Text(confirmText)),
              ],
            ),
          ),

          const Divider(height: 1),

          // iOS-style date picker
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: mode,
              initialDateTime: selectedDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ============================================================================
// OPTIONS BOTTOM SHEET
// ============================================================================

/// Option item for options bottom sheet
class BottomSheetOption<T> {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final T? value;
  final VoidCallback? onTap;
  final bool isDangerous;

  BottomSheetOption({required this.label, this.icon, this.iconColor, this.value, this.onTap, this.isDangerous = false})
    : assert(value != null || onTap != null, 'Either value or onTap must be provided');
}

/// Show a bottom sheet with a list of options
///
/// Returns selected option value if user selects, `null` if cancelled
Future<T?> showOptionsBottomSheet<T>({
  required BuildContext context,
  required String title,
  String? subtitle,
  required List<BottomSheetOption<T>> options,
}) async {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return await showModalBottomSheet<T>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Options
          ...options.map((option) {
            final color = option.isDangerous ? Colors.red : (option.iconColor ?? colors.onSurface);

            return ListTile(
              leading: option.icon != null ? Icon(option.icon, color: color) : null,
              title: Text(
                option.label,
                style: textTheme.bodyLarge?.copyWith(color: option.isDangerous ? Colors.red : null),
              ),
              onTap: () {
                Navigator.pop(context, option.value);
                // Execute callback if provided
                option.onTap?.call();
              },
            );
          }),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
