import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Dialog for editing a message
class EditMessageDialog extends HookWidget {
  const EditMessageDialog({
    super.key,
    required this.initialContent,
  });

  final String initialContent;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialContent);

    return AlertDialog(
      title: const Text('Edit Message'),
      content: TextField(
        controller: controller,
        autofocus: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          hintText: 'Enter message',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final newContent = controller.text.trim();
            if (newContent.isNotEmpty && newContent != initialContent) {
              Navigator.of(context).pop(newContent);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

