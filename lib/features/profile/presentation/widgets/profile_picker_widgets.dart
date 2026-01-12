import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:flutter/material.dart';

class PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PickerOption({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: colors.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: colors.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final Gender gender;
  final Gender? selectedGender;
  final Function(Gender) onSelect;

  const GenderOption({super.key, required this.gender, required this.selectedGender, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedGender == gender;
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected ? colors.primary : colors.onSurfaceVariant,
      ),
      title: Text(gender.label),
      onTap: () => onSelect(gender),
    );
  }
}
