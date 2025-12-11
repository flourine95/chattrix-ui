import 'package:flutter/material.dart';

class SingleFieldEditor extends StatefulWidget {
  final String title;
  final String label;
  final String initialValue;
  final int maxLength;
  final int maxLines;
  final TextInputType inputType;
  final String? helperText;
  final Function(String) onSave;

  const SingleFieldEditor({
    super.key,
    required this.title,
    required this.label,
    required this.initialValue,
    required this.maxLength,
    required this.onSave,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.helperText,
  });

  @override
  State<SingleFieldEditor> createState() => _SingleFieldEditorState();
}

class _SingleFieldEditorState extends State<SingleFieldEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  void _save() {
    widget.onSave(_controller.text.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(
              'Done',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colors.primary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _controller,
              autofocus: true,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              keyboardType: widget.inputType,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.surfaceContainerHighest.withValues(alpha: 0.3),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(icon: const Icon(Icons.clear, size: 20), onPressed: () => _controller.clear()),
                helperText: widget.helperText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
