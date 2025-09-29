import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import 'toast_type.dart';

class ToastEntry {
  ToastEntry({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.duration,
  });

  final String id;
  final String title;
  final String? description;
  final ToastType type;
  final Duration duration;

  bool dismissed = false;
  DateTime createdAt = DateTime.now();
}

class ToastController extends ChangeNotifier {
  ToastController({this.maxVisible = 3});

  final int maxVisible;
  final List<ToastEntry> _toasts = <ToastEntry>[];
  final Map<String, Timer> _timers = <String, Timer>{};

  List<ToastEntry> get toasts => List.unmodifiable(_toasts);

  String show({
    required String title,
    String? description,
    ToastType type = ToastType.info,
    Duration? duration,
  }) {
    final entry = ToastEntry(
      id: UniqueKey().toString(),
      title: title,
      description: description,
      type: type,
      duration: duration ?? const Duration(milliseconds: 3400),
    );

    _toasts.add(entry);

    while (_toasts.length > maxVisible) {
      final removed = _toasts.removeAt(0);
      _cancelTimer(removed.id);
    }

    _startAutoDismiss(entry);

    notifyListeners();
    return entry.id;
  }

  void dismiss(String id) {
    final idx = _toasts.indexWhere((e) => e.id == id);
    if (idx != -1) {
      _toasts[idx].dismissed = true;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 320), () {
        _removeById(id);
      });
    }
  }

  void _removeById(String id) {
    _cancelTimer(id);
    _toasts.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void _startAutoDismiss(ToastEntry e) {
    _cancelTimer(e.id);
    _timers[e.id] = Timer(e.duration, () => dismiss(e.id));
  }

  void _cancelTimer(String id) {
    _timers.remove(id)?.cancel();
  }

  @override
  void dispose() {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
    super.dispose();
  }
}

final toastControllerProvider = ChangeNotifierProvider<ToastController>((ref) {
  return ToastController();
});

/// Public API helpers
class Toasts {
  static String show(
    BuildContext context, {
    required String title,
    String? description,
    ToastType type = ToastType.info,
    Duration? duration,
  }) {
    final container = ProviderScope.containerOf(context, listen: false);
    final controller = container.read(toastControllerProvider);
    return controller.show(
      title: title,
      description: description,
      type: type,
      duration: duration,
    );
  }

  static String success(BuildContext context, {required String title, String? description, Duration? duration}) =>
      show(context, title: title, description: description, type: ToastType.success, duration: duration);
  static String error(BuildContext context, {required String title, String? description, Duration? duration}) =>
      show(context, title: title, description: description, type: ToastType.error, duration: duration);
  static String warning(BuildContext context, {required String title, String? description, Duration? duration}) =>
      show(context, title: title, description: description, type: ToastType.warning, duration: duration);
  static String info(BuildContext context, {required String title, String? description, Duration? duration}) =>
      show(context, title: title, description: description, type: ToastType.info, duration: duration);
  static String loading(BuildContext context, {required String title, String? description, Duration? duration}) =>
      show(context, title: title, description: description, type: ToastType.loading, duration: duration ?? const Duration(milliseconds: 1600));
}
