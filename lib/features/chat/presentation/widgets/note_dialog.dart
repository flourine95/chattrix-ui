import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/user_note_entity.dart';
import '../providers/user_notes_provider.dart';

/// Dialog for creating or editing user notes
class NoteDialog extends HookConsumerWidget {
  final String currentUserId;
  final UserNoteEntity? existingNote;

  const NoteDialog({super.key, required this.currentUserId, this.existingNote});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: existingNote?.content ?? '');
    final characterCount = useState(existingNote?.content.length ?? 0);
    const maxCharacters = 60;

    useEffect(() {
      void listener() {
        characterCount.value = controller.text.length;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              existingNote != null ? 'Edit your note' : 'Add a note',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Text field
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: maxCharacters,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                counterText: '${characterCount.value}/$maxCharacters',
              ),
              onChanged: (value) {
                // Character count is already shown in counter
              },
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Delete button (if editing)
                if (existingNote != null) ...[
                  TextButton(
                    onPressed: () {
                      ref.read(userNotesProvider.notifier).deleteNote(currentUserId);
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                  const Spacer(),
                ],

                // Cancel button
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                const SizedBox(width: 8),

                // Save button
                ElevatedButton(
                  onPressed: controller.text.trim().isEmpty
                      ? null
                      : () {
                          ref
                              .read(userNotesProvider.notifier)
                              .createOrUpdateNote(currentUserId, controller.text.trim());
                          Navigator.of(context).pop();
                        },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
