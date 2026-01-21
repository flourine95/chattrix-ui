import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppInputField extends HookWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool useModernStyle;

  const AppInputField({
    super.key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.useModernStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(isPassword);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (useModernStyle) {
      // Modern style: rounded, no border, grey background
      return TextFormField(
        controller: controller,
        obscureText: obscureText.value,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 15,
          ),
          filled: true,
          fillColor: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    size: 20,
                  ),
                  onPressed: () {
                    obscureText.value = !obscureText.value;
                  },
                )
              : null,
        ),
      );
    }

    // Standard style (for other screens)
    return TextFormField(
      controller: controller,
      obscureText: obscureText.value,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
              )
            : null,
      ),
    );
  }
}
