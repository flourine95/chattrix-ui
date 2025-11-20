import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/services/performance_monitor.dart';

/// Helper class for measuring performance in typical usage scenarios
///
/// This class provides convenient methods for measuring frame timing
/// during common user interactions like scrolling, sending messages, etc.
class PerformanceMeasurementHelper {
  VoidCallback? _stopMeasurement;

  /// Start measuring frame timing for a specific scenario
  ///
  /// Example scenarios:
  /// - "Scrolling through 100 messages"
  /// - "Receiving 10 rapid messages"
  /// - "Sending 5 messages"
  /// - "Opening conversation list"
  void startMeasurement(String scenario) {
    if (!kDebugMode) return;

    // Stop any existing measurement
    stopMeasurement();

    _stopMeasurement = PerformanceMonitor.startFrameTimingMeasurement(scenario);
  }

  /// Stop the current measurement and log results
  void stopMeasurement() {
    _stopMeasurement?.call();
    _stopMeasurement = null;
  }

  /// Measure a specific user action
  ///
  /// This will automatically start and stop measurement around the action
  Future<T> measureAction<T>(String actionName, Future<T> Function() action) async {
    startMeasurement(actionName);
    try {
      final result = await action();
      // Give a small delay to capture any trailing frames
      await Future.delayed(const Duration(milliseconds: 100));
      return result;
    } finally {
      stopMeasurement();
    }
  }
}

/// Global instance for easy access
final performanceMeasurement = PerformanceMeasurementHelper();
