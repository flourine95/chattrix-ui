import 'package:flutter/material.dart';

enum ToastType { info, success, warning, error, loading }

IconData toastIcon(ToastType type) {
  switch (type) {
    case ToastType.success:
      return Icons.check_circle_rounded;
    case ToastType.warning:
      return Icons.warning_amber_rounded;
    case ToastType.error:
      return Icons.error_rounded;
    case ToastType.loading:
      return Icons.hourglass_bottom_rounded;
    case ToastType.info:
    return Icons.info_rounded;
  }
}

Color toastAccentColor(ToastType type, Brightness brightness) {
  final bool dark = brightness == Brightness.dark;
  switch (type) {
    case ToastType.success:
      return dark ? const Color(0xFF22C55E) : const Color(0xFF16A34A);
    case ToastType.warning:
      return dark ? const Color(0xFFF59E0B) : const Color(0xFFD97706);
    case ToastType.error:
      return dark ? const Color(0xFFEF4444) : const Color(0xFFDC2626);
    case ToastType.loading:
      return dark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
    case ToastType.info:
    return dark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7);
  }
}
