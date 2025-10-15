import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppInputField extends HookWidget {
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const AppInputField({
    super.key,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(isPassword);

    return TextFormField(
      controller: controller,
      obscureText: obscureText.value,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
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
