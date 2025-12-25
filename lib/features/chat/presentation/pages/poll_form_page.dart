import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import '../providers/poll_providers.dart';
import '../../domain/entities/poll.dart';
import '../widgets/time_picker_bottom_sheet.dart';

class PollFormPage extends HookConsumerWidget {
  const PollFormPage({super.key, required this.conversationId, this.poll});

  final int conversationId;
  final Poll? poll; // null = create, non-null = edit (future feature)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isEdit = poll != null;

    // Get initial values safely
    final initialQuestion = poll?.question ?? '';
    final initialOption1 = isEdit && poll!.options.isNotEmpty ? poll!.options[0].optionText : '';
    final initialOption2 = isEdit && poll!.options.length > 1 ? poll!.options[1].optionText : '';
    final initialAllowMultiple = poll?.allowMultipleVotes ?? false;
    final initialHasExpiration = poll?.expiresAt != null;
    final initialExpirationDateTime = poll?.expiresAt ?? DateTime.now().add(const Duration(hours: 1));

    // Controllers
    final questionController = useTextEditingController(text: initialQuestion);
    final option1Controller = useTextEditingController(text: initialOption1);
    final option2Controller = useTextEditingController(text: initialOption2);

    // Additional options
    final additionalOptions = useState<List<TextEditingController>>([]);

    // Initialize additional options for edit mode
    useEffect(() {
      if (isEdit && poll!.options.length > 2) {
        additionalOptions.value = poll!.options
            .skip(2)
            .map((opt) => TextEditingController(text: opt.optionText))
            .toList();
      }
      return null;
    }, []);

    // Settings
    final allowMultiple = useState(initialAllowMultiple);
    final hasExpiration = useState(initialHasExpiration);

    // Date/Time state
    final expirationDateTime = useState(initialExpirationDateTime);

    final isLoading = useState(false);

    Future<void> handleSubmit() async {
      final question = questionController.text.trim();
      if (question.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide a question')));
        return;
      }

      final options = [
        option1Controller.text.trim(),
        option2Controller.text.trim(),
        ...additionalOptions.value.map((c) => c.text.trim()),
      ].where((o) => o.isNotEmpty).toList();

      if (options.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide at least 2 options')));
        return;
      }

      // Calculate expiration datetime if enabled
      DateTime? expiresAt;
      if (hasExpiration.value) {
        expiresAt = expirationDateTime.value;

        if (expiresAt.isBefore(DateTime.now())) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Expiration time must be in the future')));
          return;
        }
      }

      isLoading.value = true;

      try {
        final useCase = ref.read(createPollUseCaseProvider);
        final result = await useCase(
          conversationId: conversationId,
          question: question,
          options: options,
          allowMultipleAnswers: allowMultiple.value,
          expiresAt: expiresAt,
        );

        result.fold(
          (failure) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Failed to create poll: ${failure.message}')));
            }
          },
          (_) {
            ref.invalidate(pollsListProvider(conversationId));
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Poll created successfully')));
            }
          },
        );
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Poll' : 'Create Poll'),
        actions: [
          if (isLoading.value)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              ),
            )
          else
            TextButton(onPressed: handleSubmit, child: Text(isEdit ? 'Save' : 'Create')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Poll Question *',
                hintText: 'e.g., Where should we meet?',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.help_outline),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            // Options Section
            Text('Options *', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Option 1
            TextField(
              controller: option1Controller,
              decoration: InputDecoration(
                labelText: 'Option 1',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.radio_button_unchecked),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 8),

            // Option 2
            TextField(
              controller: option2Controller,
              decoration: InputDecoration(
                labelText: 'Option 2',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.radio_button_unchecked),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),

            // Additional Options
            ...additionalOptions.value.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: 'Option ${entry.key + 3}',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.radio_button_unchecked),
                    filled: true,
                    fillColor: colors.surfaceContainerHighest,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        final newList = List<TextEditingController>.from(additionalOptions.value);
                        newList.removeAt(entry.key);
                        additionalOptions.value = newList;
                      },
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              );
            }),

            const SizedBox(height: 8),

            // Add Option Button
            if (additionalOptions.value.length < 8)
              OutlinedButton.icon(
                onPressed: () {
                  final newList = List<TextEditingController>.from(additionalOptions.value);
                  newList.add(TextEditingController());
                  additionalOptions.value = newList;
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Option'),
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
              ),
            const SizedBox(height: 24),

            // Settings Section
            Text('Settings', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Allow Multiple Votes
            Card(
              child: SwitchListTile(
                title: const Text('Allow multiple votes'),
                subtitle: const Text('Users can select more than one option'),
                value: allowMultiple.value,
                onChanged: (value) {
                  allowMultiple.value = value;
                },
              ),
            ),
            const SizedBox(height: 8),

            // Expiration Toggle
            Card(
              child: SwitchListTile(
                title: const Text('Set expiration time'),
                subtitle: const Text('Poll will close automatically'),
                value: hasExpiration.value,
                onChanged: (value) {
                  hasExpiration.value = value;
                },
              ),
            ),

            // Expiration Date & Time Picker
            if (hasExpiration.value) ...[
              const SizedBox(height: 16),
              Text('Expiration Date & Time', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final selectedTime = await TimePickerBottomSheet.show(context, initialTime: expirationDateTime.value);
                  if (selectedTime != null) {
                    expirationDateTime.value = selectedTime;
                  }
                },
                icon: const Icon(Icons.schedule),
                label: Text(DateFormat('HH:mm, dd/MM/yyyy').format(expirationDateTime.value)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isLoading.value ? null : handleSubmit,
                icon: isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(isEdit ? Icons.save : Icons.add),
                label: Text(isEdit ? 'Save Changes' : 'Create Poll'),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
