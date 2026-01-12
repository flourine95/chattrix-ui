import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Bottom sheet for editing a message
class EditMessageBottomSheet extends HookWidget {
  const EditMessageBottomSheet({super.key, required this.initialContent, required this.onSave});

  final String initialContent;
  final Function(String newContent) onSave;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialContent);
    final focusNode = useFocusNode();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Auto-focus when sheet opens
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        focusNode.requestFocus();
        // Select all text
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      });
      return null;
    }, []);

    void handleSave() {
      final newContent = controller.text.trim();
      if (newContent.isNotEmpty && newContent != initialContent) {
        onSave(newContent);
        Navigator.of(context).pop();
      } else if (newContent.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Message cannot be empty'), duration: Duration(seconds: 2)));
      } else {
        Navigator.of(context).pop();
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit, color: colors.primary, size: 24),
                  const SizedBox(width: 12),
                  Text('Edit Message', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Text field
              TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: null,
                minLines: 3,
                maxLength: 1000,
                decoration: InputDecoration(
                  hintText: 'Enter message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                  filled: true,
                  fillColor: colors.surfaceContainerHighest.withValues(alpha: 0.3),
                  contentPadding: const EdgeInsets.all(16),
                ),
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 16),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Save'),
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
}

/// Show edit message bottom sheet
void showEditMessageBottomSheet({
  required BuildContext context,
  required String initialContent,
  required Function(String newContent) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => EditMessageBottomSheet(initialContent: initialContent, onSave: onSave),
  );
}
