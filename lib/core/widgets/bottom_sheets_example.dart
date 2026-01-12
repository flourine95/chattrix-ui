import 'package:flutter/material.dart';
import 'bottom_sheets.dart';

/// Example page demonstrating all reusable bottom sheets
///
/// This file shows how to use each bottom sheet component
class BottomSheetsExamplePage extends StatelessWidget {
  const BottomSheetsExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheets Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Confirmation Bottom Sheet
          _ExampleCard(
            title: 'Confirmation Bottom Sheet',
            description: 'Yes/No confirmation with icon',
            onTap: () => _showConfirmationExample(context),
          ),

          // Input Bottom Sheet
          _ExampleCard(
            title: 'Input Bottom Sheet',
            description: 'Text input with validation',
            onTap: () => _showInputExample(context),
          ),

          // Time Picker Bottom Sheet
          _ExampleCard(
            title: 'Time Picker Bottom Sheet',
            description: 'iOS-style time picker with quick select',
            onTap: () => _showTimePickerExample(context),
          ),

          // Date Picker Bottom Sheet
          _ExampleCard(
            title: 'Date Picker Bottom Sheet',
            description: 'iOS-style date picker',
            onTap: () => _showDatePickerExample(context),
          ),

          // Options Bottom Sheet
          _ExampleCard(
            title: 'Options Bottom Sheet',
            description: 'List of options to select',
            onTap: () => _showOptionsExample(context),
          ),

          // Dangerous Confirmation
          _ExampleCard(
            title: 'Dangerous Confirmation',
            description: 'Confirmation for destructive actions',
            onTap: () => _showDangerousConfirmationExample(context),
          ),
        ],
      ),
    );
  }

  // Example 1: Confirmation Bottom Sheet
  Future<void> _showConfirmationExample(BuildContext context) async {
    final result = await showConfirmationBottomSheet(
      context: context,
      title: 'Leave Group?',
      message: 'Are you sure you want to leave this group? You will no longer receive messages.',
      confirmText: 'Leave',
      cancelText: 'Cancel',
      icon: Icons.exit_to_app,
      isDangerous: true,
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ? 'Confirmed!' : 'Cancelled')));
    }
  }

  // Example 2: Input Bottom Sheet
  Future<void> _showInputExample(BuildContext context) async {
    final result = await showInputBottomSheet(
      context: context,
      title: 'Rename Group',
      subtitle: 'Enter a new name for this group',
      initialValue: 'My Group',
      labelText: 'Group Name',
      hintText: 'Enter group name',
      maxLength: 50,
      prefixIcon: Icons.group,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Group name cannot be empty';
        }
        if (value.length < 3) {
          return 'Group name must be at least 3 characters';
        }
        return null;
      },
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New name: $result')));
    }
  }

  // Example 3: Time Picker Bottom Sheet
  Future<void> _showTimePickerExample(BuildContext context) async {
    final result = await showTimePickerBottomSheet(
      context: context,
      title: 'Schedule Message',
      initialTime: DateTime.now().add(const Duration(hours: 1)),
      quickOptions: [
        QuickTimeOption(label: '5 min', minutes: 5),
        QuickTimeOption(label: '15 min', minutes: 15),
        QuickTimeOption(label: '30 min', minutes: 30),
        QuickTimeOption(label: '1 hour', minutes: 60),
        QuickTimeOption(label: '2 hours', minutes: 120),
        QuickTimeOption(label: '1 day', minutes: 1440),
      ],
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected time: ${result.toString()}')));
    }
  }

  // Example 4: Date Picker Bottom Sheet
  Future<void> _showDatePickerExample(BuildContext context) async {
    final result = await showDatePickerBottomSheet(
      context: context,
      title: 'Select Birthday',
      initialDate: DateTime.now(),
      minimumDate: DateTime(1900),
      maximumDate: DateTime.now(),
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected date: ${result.toString()}')));
    }
  }

  // Example 5: Options Bottom Sheet
  Future<void> _showOptionsExample(BuildContext context) async {
    final result = await showOptionsBottomSheet<String>(
      context: context,
      title: 'Member Options',
      subtitle: 'Choose an action for this member',
      options: [
        BottomSheetOption(label: 'View Profile', icon: Icons.person, value: 'profile'),
        BottomSheetOption(label: 'Make Admin', icon: Icons.admin_panel_settings, value: 'admin'),
        BottomSheetOption(label: 'Send Message', icon: Icons.message, value: 'message'),
        BottomSheetOption(
          label: 'Remove from Group',
          icon: Icons.person_remove,
          iconColor: Colors.red,
          value: 'remove',
          isDangerous: true,
        ),
      ],
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected: $result')));
    }
  }

  // Example 6: Dangerous Confirmation
  Future<void> _showDangerousConfirmationExample(BuildContext context) async {
    final result = await showConfirmationBottomSheet(
      context: context,
      title: 'Delete Message?',
      message: 'This message will be permanently deleted. This action cannot be undone.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      icon: Icons.delete_forever,
      iconColor: Colors.red,
      isDangerous: true,
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ? 'Message deleted' : 'Cancelled'), backgroundColor: result ? Colors.red : null),
      );
    }
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ExampleCard({required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: Icon(Icons.chevron_right, color: colors.primary),
        onTap: onTap,
      ),
    );
  }
}
