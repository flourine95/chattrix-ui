import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/create_poll_params.dart';
import '../providers/create_poll_provider.dart';
import '../widgets/date_time_picker_bottom_sheet.dart';

/// Full screen page for creating a poll
class CreatePollPage extends HookConsumerWidget {
  final int conversationId;

  const CreatePollPage({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Controllers
    final questionController = useTextEditingController();
    final optionControllers = useState<List<TextEditingController>>([
      useTextEditingController(),
      useTextEditingController(),
    ]);

    // State
    final allowMultiple = useState(false);
    final selectedDateTime = useState<DateTime?>(null);
    final characterCount = useState(0);

    // Watch provider
    final asyncState = ref.watch(createPollProvider);

    // Listen to question changes
    useEffect(() {
      void listener() {
        characterCount.value = questionController.text.length;
      }

      questionController.addListener(listener);
      return () => questionController.removeListener(listener);
    }, [questionController]);

    // Add option
    void addOption() {
      if (optionControllers.value.length < 10) {
        optionControllers.value = [...optionControllers.value, TextEditingController()];
      }
    }

    // Remove option
    void removeOption(int index) {
      if (optionControllers.value.length > 2) {
        final controllers = [...optionControllers.value];
        controllers[index].dispose();
        controllers.removeAt(index);
        optionControllers.value = controllers;
      }
    }

    // Pick date time
    Future<void> pickDateTime() async {
      final now = DateTime.now();
      final initialDateTime = selectedDateTime.value ?? now.add(const Duration(hours: 1));

      final picked = await DateTimePickerBottomSheet.show(context, initialDateTime: initialDateTime);

      if (picked != null) {
        selectedDateTime.value = picked;
      }
    }

    // Create poll
    Future<void> createPoll() async {
      // Validation
      if (questionController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a question')));
        return;
      }

      final options = optionControllers.value.map((c) => c.text.trim()).where((text) => text.isNotEmpty).toList();

      if (options.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('At least 2 options required')));
        return;
      }

      // Build deadline
      DateTime? expiresAt = selectedDateTime.value;

      // Create params
      final params = CreatePollParams(
        conversationId: conversationId,
        question: questionController.text.trim(),
        options: options,
        allowMultipleVotes: allowMultiple.value,
        expiresAt: expiresAt,
      );

      // Execute
      try {
        final notifier = ref.read(createPollProvider.notifier);
        await notifier.execute(params: params);

        if (!context.mounted) return;

        // Success - navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Poll created successfully!', style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.grey.shade900,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        context.pop();
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to create poll: $e', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create Poll')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Text('Question', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: questionController,
              maxLength: 500,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
                counterText: '',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${characterCount.value}/500 characters',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 24),

            // Options
            Text('Options', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...List.generate(optionControllers.value.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: optionControllers.value[index],
                        decoration: InputDecoration(
                          hintText: 'Option ${index + 1}',
                          prefixText: '${index + 1}. ',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    if (optionControllers.value.length > 2) ...[
                      const SizedBox(width: 8),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => removeOption(index)),
                    ],
                  ],
                ),
              );
            }),
            if (optionControllers.value.length < 10)
              OutlinedButton.icon(
                onPressed: addOption,
                icon: const Icon(Icons.add),
                label: const Text('Add Option'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            const SizedBox(height: 24),

            // Settings
            Text('Settings', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            // Allow multiple
            SwitchListTile(
              value: allowMultiple.value,
              onChanged: (value) => allowMultiple.value = value,
              title: const Text('Allow multiple answers'),
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 8),

            // Deadline
            Card(
              elevation: 0,
              color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
              child: InkWell(
                onTap: pickDateTime,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.schedule, color: theme.colorScheme.onPrimaryContainer, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedDateTime.value != null
                                  ? DateFormat('HH:mm, dd/MM/yyyy').format(selectedDateTime.value!)
                                  : 'No limit',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      if (selectedDateTime.value != null)
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => selectedDateTime.value = null,
                          tooltip: 'Remove time',
                        )
                      else
                        Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Create button
            FilledButton(
              onPressed: asyncState.isLoading ? null : createPoll,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: asyncState.isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Create Poll', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
