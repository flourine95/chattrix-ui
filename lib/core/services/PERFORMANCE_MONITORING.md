# Performance Monitoring Guide

This document explains how to use the performance monitoring features in the Chattrix Flutter application.

## Overview

The performance monitoring system provides:
- Execution time logging for operations exceeding 16ms
- Isolate creation and message passing overhead logging
- Frame timing measurements for typical usage scenarios
- Performance overlay in debug mode

## Components

### 1. PerformanceMonitor

The main service for tracking performance metrics.

**Location**: `lib/core/services/performance_monitor.dart`

#### Measuring Async Operations

```dart
import 'package:chattrix_ui/core/services/performance_monitor.dart';

// Measure an async operation
final result = await PerformanceMonitor.measureAsync(
  'fetchMessages',
  () async {
    return await repository.getMessages(conversationId);
  },
);
```

#### Measuring Sync Operations

```dart
// Measure a synchronous operation
final result = PerformanceMonitor.measureSync(
  'parseJSON',
  () {
    return jsonDecode(jsonString);
  },
);
```

#### Logging Isolate Creation

```dart
final stopwatch = Stopwatch()..start();
final result = await compute(parseFunction, data);
stopwatch.stop();

PerformanceMonitor.logIsolateCreation(
  'parseMessage',
  stopwatch.elapsedMilliseconds,
);
```

#### Frame Timing Measurements

```dart
// Start measuring frame timing
final stopMeasurement = PerformanceMonitor.startFrameTimingMeasurement(
  'Scrolling through 100 messages',
);

// ... perform the action ...

// Stop and log results
stopMeasurement();
```

### 2. PerformanceMeasurementHelper

A helper class for measuring performance in typical usage scenarios.

**Location**: `lib/core/services/performance_measurement_helper.dart`

#### Basic Usage

```dart
import 'package:chattrix_ui/core/services/performance_measurement_helper.dart';

// Start measurement
performanceMeasurement.startMeasurement('Opening conversation list');

// ... perform action ...

// Stop measurement
performanceMeasurement.stopMeasurement();
```

#### Measure Specific Actions

```dart
// Automatically start and stop measurement around an action
await performanceMeasurement.measureAction(
  'Sending 5 messages',
  () async {
    for (int i = 0; i < 5; i++) {
      await sendMessage('Message $i');
    }
  },
);
```

### 3. Performance Overlay

Enable the performance overlay to see real-time FPS and frame timing.

**Location**: `lib/main.dart`

```dart
MaterialApp.router(
  showPerformanceOverlay: true, // Enable in debug mode
  // ... other properties
)
```

## Logging Output

### Execution Time Logs

Operations exceeding 16ms will be logged with WARNING level:

```
[PerformanceMonitor] parseMessage took 23ms (exceeds 16ms threshold)
```

### Isolate Creation Logs

```
[PerformanceMonitor] Isolate created for parseMessage in 12ms
```

### Frame Timing Stats

```
[PerformanceMonitor] Frame timing for "Scrolling through 100 messages":
  Total frames: 120
  Average: 14.23ms
  P95: 15ms
  Max: 18ms
  Dropped frames (>16ms): 5 (4.2%)
```

## Integration Examples

### In JSON Parsing Service

The JSON parsing service automatically logs isolate creation overhead:

```dart
static Future<Message> parseMessage(String jsonString) async {
  return await PerformanceMonitor.measureAsync(
    'parseMessage (isolate)',
    () async {
      final isolateStart = Stopwatch()..start();
      final result = await compute(_parseMessageIsolate, jsonString);
      isolateStart.stop();
      PerformanceMonitor.logIsolateCreation('parseMessage', isolateStart.elapsedMilliseconds);
      return result;
    },
  );
}
```

### In Token Cache Service

Storage operations are automatically measured:

```dart
Future<String?> getAccessToken() async {
  if (_accessToken != null) return _accessToken;
  
  _accessToken = await PerformanceMonitor.measureAsync(
    'getAccessToken (storage read)',
    () => _secureStorage.read(key: AppConstants.accessTokenKey),
  );
  return _accessToken;
}
```

### In UI Components

Measure frame timing during user interactions:

```dart
class ChatViewPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Start measuring when page loads
      final stop = PerformanceMonitor.startFrameTimingMeasurement(
        'Chat view initial render',
      );
      
      return () {
        // Stop measuring when page disposes
        stop();
      };
    }, []);
    
    // ... rest of widget
  }
}
```

## Typical Usage Scenarios

### Scenario 1: Scrolling Performance

```dart
void testScrollingPerformance() {
  performanceMeasurement.startMeasurement('Scrolling through 100 messages');
  
  // Simulate scrolling
  scrollController.animateTo(
    scrollController.position.maxScrollExtent,
    duration: Duration(seconds: 2),
    curve: Curves.linear,
  );
  
  // Stop after animation completes
  Future.delayed(Duration(seconds: 2), () {
    performanceMeasurement.stopMeasurement();
  });
}
```

### Scenario 2: Rapid Message Handling

```dart
Future<void> testRapidMessages() async {
  await performanceMeasurement.measureAction(
    'Receiving 10 rapid messages',
    () async {
      for (int i = 0; i < 10; i++) {
        await simulateIncomingMessage();
        await Future.delayed(Duration(milliseconds: 100));
      }
    },
  );
}
```

### Scenario 3: Message Sending

```dart
Future<void> testMessageSending() async {
  await performanceMeasurement.measureAction(
    'Sending 5 messages',
    () async {
      for (int i = 0; i < 5; i++) {
        await sendMessage('Test message $i');
      }
    },
  );
}
```

## Performance Targets

| Metric | Target | Measurement |
|--------|--------|-------------|
| Frame time | < 16.67ms | Flutter DevTools / PerformanceMonitor |
| Token read time | < 1ms | PerformanceMonitor logs |
| JSON parsing | < 10ms | PerformanceMonitor logs |
| Dropped frames | 0% | Frame timing stats |

## Best Practices

1. **Only measure in debug mode**: Performance monitoring is automatically disabled in release builds
2. **Use descriptive names**: Give clear names to operations for easy identification in logs
3. **Measure typical scenarios**: Focus on real user interactions, not artificial stress tests
4. **Check logs regularly**: Review performance logs during development to catch regressions early
5. **Use the performance overlay**: Enable it during development to see real-time performance

## Troubleshooting

### No logs appearing

- Ensure you're running in debug mode (`flutter run --debug`)
- Check that `kDebugMode` is true
- Verify the operation actually exceeds 16ms threshold

### Performance overlay not showing

- Set `showPerformanceOverlay: true` in `MaterialApp.router`
- Ensure you're running in debug mode
- Restart the app after making changes

### High frame times

- Check PerformanceMonitor logs for operations exceeding 16ms
- Use Flutter DevTools Timeline to identify bottlenecks
- Ensure heavy operations are running in isolates
- Verify token cache is being used (check for cache hit logs)

## Related Files

- `lib/core/services/performance_monitor.dart` - Main monitoring service
- `lib/core/services/performance_measurement_helper.dart` - Helper for typical scenarios
- `lib/core/services/json_parsing_service.dart` - Example integration
- `lib/core/services/token_cache_service.dart` - Example integration
- `lib/main.dart` - Performance overlay configuration
