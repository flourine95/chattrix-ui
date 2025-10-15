// lib/features/widgets/app_input_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Import flutter_hooks

// Sử dụng HookWidget thay vì StatefulWidget
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
    // Sử dụng hook useState để quản lý trạng thái ẩn/hiện mật khẩu
    final obscureText = useState(isPassword);

    return TextFormField(
      controller: controller,
      // Sử dụng giá trị hiện tại của hook useState
      obscureText: obscureText.value,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon:
            isPassword // Chỉ hiện icon nếu là trường mật khẩu
            ? IconButton(
                icon: Icon(
                  // Thay đổi icon dựa trên state
                  obscureText.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                onPressed: () {
                  // Đảo ngược state. Hook sẽ tự động gọi rebuild
                  obscureText.value = !obscureText.value;
                },
              )
            : null,
      ),
    );
  }
}
