import 'dart:async';

/// Utility class to debounce typing events and auto-stop after inactivity
class TypingDebouncer {
  Timer? _debounceTimer;
  Timer? _stopTimer;
  bool _isTyping = false;

  final Duration debounceDuration;
  final Duration stopDuration;

  TypingDebouncer({
    this.debounceDuration = const Duration(milliseconds: 300),
    this.stopDuration = const Duration(seconds: 3),
  });

  /// Handle text change with debouncing
  ///
  /// [text] - Current text value
  /// [onStart] - Callback when typing starts
  /// [onStop] - Callback when typing stops
  void onTextChanged(String text, void Function() onStart, void Function() onStop) {
    // Cancel previous timers
    _debounceTimer?.cancel();
    _stopTimer?.cancel();

    // If text is empty, stop typing immediately
    if (text.trim().isEmpty) {
      if (_isTyping) {
        onStop();
        _isTyping = false;
      }
      return;
    }

    // Debounce: wait a bit before sending typing start
    _debounceTimer = Timer(debounceDuration, () {
      // Send typing start if not already typing
      if (!_isTyping) {
        onStart();
        _isTyping = true;
      }

      // Schedule auto-stop after inactivity
      _scheduleAutoStop(onStop);
    });
  }

  /// Schedule automatic typing stop after inactivity
  void _scheduleAutoStop(void Function() onStop) {
    _stopTimer?.cancel();
    _stopTimer = Timer(stopDuration, () {
      if (_isTyping) {
        onStop();
        _isTyping = false;
      }
    });
  }

  /// Manually stop typing (e.g., when sending message or leaving chat)
  void stop(void Function() onStop) {
    _debounceTimer?.cancel();
    _stopTimer?.cancel();

    if (_isTyping) {
      onStop();
      _isTyping = false;
    }
  }

  /// Check if currently typing
  bool get isTyping => _isTyping;

  /// Dispose and cleanup timers
  void dispose() {
    _debounceTimer?.cancel();
    _stopTimer?.cancel();
    _debounceTimer = null;
    _stopTimer = null;
    _isTyping = false;
  }
}
