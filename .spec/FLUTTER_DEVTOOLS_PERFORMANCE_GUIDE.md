# Flutter DevTools Performance Verification Guide

This guide provides step-by-step instructions for manually verifying the performance improvements using Flutter DevTools Timeline.

## Prerequisites

- Flutter SDK installed
- Chattrix UI app running in debug mode
- Chrome browser (for DevTools)

## Step 1: Start the App in Debug Mode

```bash
cd chattrix-ui
flutter run --debug
```

Wait for the app to launch on your device or emulator.

## Step 2: Open Flutter DevTools

### Method 1: From Terminal
1. In the terminal where the app is running, press `v`
2. This will open DevTools in your default browser

### Method 2: From URL
1. Look for the DevTools URL in the terminal output
2. It will look like: `http://127.0.0.1:9100/?uri=http://127.0.0.1:xxxxx/`
3. Copy and paste this URL into Chrome

### Method 3: From Android Studio / VS Code
1. Click the "Open DevTools" button in the debug toolbar
2. Or use the command palette: "Dart: Open DevTools"

## Step 3: Navigate to Performance Tab

1. Once DevTools opens, click on the **"Performance"** tab at the top
2. You should see the Timeline view with a "Record" button

## Step 4: Record Performance Timeline

### Test Scenario 1: Receiving Rapid Messages

1. **Click "Record"** button (red circle)
2. **In the app**: Navigate to a conversation
3. **Simulate rapid messages**: 
   - If testing with real backend, send 10-20 messages quickly
   - Or trigger WebSocket message events
4. **Wait 2-3 seconds** to capture the frames
5. **Click "Stop"** button

### Test Scenario 2: Scrolling Through Messages

1. **Click "Record"** button
2. **In the app**: Open a conversation with 50+ messages
3. **Scroll rapidly** up and down through the message list
4. **Continue scrolling** for 5-10 seconds
5. **Click "Stop"** button

### Test Scenario 3: Switching Conversations

1. **Click "Record"** button
2. **In the app**: Navigate to conversation list
3. **Tap on different conversations** rapidly (5-10 times)
4. **Wait 2 seconds** after last tap
5. **Click "Stop"** button

### Test Scenario 4: Sending Messages

1. **Click "Record"** button
2. **In the app**: Open a conversation
3. **Type and send 5 messages** quickly
4. **Wait 2 seconds** after last message
5. **Click "Stop"** button

## Step 5: Analyze Timeline Results

### Understanding the Timeline View

The Timeline shows:
- **Frame Chart**: Visual representation of frame rendering times
- **Timeline Events**: Detailed breakdown of what happened during each frame
- **Frame Times**: Numerical values for build and raster times

### What to Look For

#### ✅ Good Performance Indicators

1. **Green Bars in Frame Chart**
   - All or most bars should be green
   - Green = frame rendered in < 16.67ms (60 FPS)

2. **Consistent Frame Times**
   - Frame times should be consistently under 16.67ms
   - Look at the "Frame Rendering Time" graph

3. **No Red Bars**
   - Red bars indicate dropped frames (> 16.67ms)
   - Should see zero or very few red bars

4. **Isolate Usage**
   - Look for "compute" or isolate spawning events
   - JSON parsing should happen in background isolates
   - Main isolate should be mostly idle during parsing

5. **Smooth Build Times**
   - Build phase should be quick (< 8ms typically)
   - Raster phase should be quick (< 8ms typically)

#### ❌ Performance Issues to Watch For

1. **Red Bars**: Frames taking > 16.67ms
2. **Janky Pattern**: Irregular frame times with spikes
3. **Long Operations on UI Thread**: Heavy work on main isolate
4. **Excessive Rebuilds**: Many widget rebuilds for small changes

### Detailed Analysis Steps

1. **Click on a Frame** in the timeline
   - This shows detailed breakdown of that frame
   - Look at the "Timeline Events" section

2. **Check for Heavy Operations**
   - Look for operations taking > 5ms
   - Verify JSON parsing is NOT on main thread
   - Check that token reads are fast (< 1ms)

3. **Verify Isolate Usage**
   - Expand the "Timeline Events" tree
   - Look for "compute" or "Isolate.spawn" events
   - Confirm parsing happens in background

4. **Check Widget Rebuilds**
   - Look at the "Build" section
   - Should see selective rebuilds, not full tree rebuilds
   - Message list should not rebuild entirely on single message

## Step 6: Performance Overlay (Alternative Method)

### Enable Performance Overlay

1. **In the app**: Open the debug menu
   - Android: Shake the device or press menu button
   - iOS: Shake the device
   - Or add this code temporarily:
     ```dart
     MaterialApp(
       showPerformanceOverlay: true,
       // ... rest of config
     )
     ```

2. **Observe the Overlay**
   - Two graphs appear at top of screen
   - **Top graph**: GPU thread (raster)
   - **Bottom graph**: UI thread (build)

3. **Interpret the Graphs**
   - **Green bars**: Good performance (< 16.67ms)
   - **Red bars**: Frame drops (> 16.67ms)
   - **Height of bars**: Time taken for that frame

### Test with Performance Overlay

1. **Navigate through the app** with overlay visible
2. **Perform typical actions**:
   - Scroll through messages
   - Receive messages
   - Send messages
   - Switch conversations
3. **Watch for red bars** (should be none or very few)

## Step 7: Memory Profiler (Optional)

### Check for Memory Leaks

1. **In DevTools**: Click "Memory" tab
2. **Click "Profile Memory"**
3. **Use the app** for 2-3 minutes
4. **Take a snapshot**
5. **Look for**:
   - Steady memory usage (no continuous growth)
   - Proper cleanup of isolates
   - No leaked message objects

## Expected Results

### Performance Targets

| Metric | Target | How to Verify |
|--------|--------|---------------|
| Frame time | < 16.67ms | Timeline: All green bars |
| Dropped frames | 0 per minute | Timeline: No red bars |
| JSON parsing | In background | Timeline: compute() events |
| Token reads | < 1ms | Timeline: Fast auth operations |
| Widget rebuilds | Selective only | Timeline: Minimal build events |

### Specific Scenarios

#### Receiving 10 Rapid Messages
- **Expected**: All frames green, no jank
- **Frame times**: Consistently < 16.67ms
- **Parsing**: Visible in background isolate
- **UI**: Smooth updates without stuttering

#### Scrolling Through 100 Messages
- **Expected**: Smooth scrolling, no lag
- **Frame times**: Consistently < 16.67ms
- **Rebuilds**: Only visible messages rebuild
- **Media**: Lazy loading visible in timeline

#### Switching Conversations
- **Expected**: Instant transitions
- **Frame times**: < 16.67ms during transition
- **Token reads**: Fast (< 1ms from cache)
- **No polling**: Only WebSocket events

## Troubleshooting

### If You See Red Bars

1. **Click on the red bar** to see details
2. **Identify the heavy operation**
3. **Check if it's**:
   - JSON parsing on main thread (should be in isolate)
   - Secure storage access (should be cached)
   - Full widget tree rebuild (should be selective)
   - Synchronous network call (should be async)

### If Frame Times Are High

1. **Check Timeline Events** for long operations
2. **Verify isolate usage** for parsing
3. **Check widget rebuild count**
4. **Look for synchronous operations**

### If Memory Keeps Growing

1. **Check for isolate leaks**
2. **Verify stream subscriptions are cancelled**
3. **Check for retained message objects**
4. **Look for unclosed resources**

## Comparison: Before vs After

### Before Optimization

- ❌ Red bars during message receipt
- ❌ Frame times: 30-50ms
- ❌ JSON parsing on main thread
- ❌ Token reads: 5-10ms
- ❌ Continuous polling visible
- ❌ Full list rebuilds

### After Optimization

- ✅ All green bars
- ✅ Frame times: < 16.67ms
- ✅ JSON parsing in isolates
- ✅ Token reads: < 1ms
- ✅ Event-driven updates only
- ✅ Selective rebuilds

## Additional Tools

### Flutter Inspector

1. **In DevTools**: Click "Flutter Inspector" tab
2. **Enable "Highlight Repaints"**
3. **Watch which widgets repaint** during updates
4. **Should see**: Only affected message bubbles repaint

### Network Tab

1. **In DevTools**: Click "Network" tab
2. **Monitor network requests**
3. **Should see**: No polling requests when WebSocket connected
4. **Should see**: Polling only when disconnected

## Automated Performance Tests

In addition to manual verification, run automated tests:

```bash
# Run all performance tests
flutter test test/performance_validation_test.dart

# Run integration tests
flutter test test/integration/performance_integration_test.dart

# Run property-based tests
flutter test test/core/services/json_parsing_service_property_test.dart
flutter test test/core/services/token_cache_service_property_test.dart
```

## Reporting Results

### Document Your Findings

Create a report with:

1. **Test Date**: When you performed the tests
2. **Device/Emulator**: What device you tested on
3. **Scenarios Tested**: List of scenarios
4. **Screenshots**: Capture Timeline screenshots
5. **Frame Times**: Record average and max frame times
6. **Issues Found**: Any performance issues discovered
7. **Comparison**: Before vs after metrics

### Example Report Format

```
Performance Verification Report
Date: [Date]
Device: [Device Name/Emulator]
Flutter Version: [Version]

Scenario 1: Receiving 10 Rapid Messages
- Average Frame Time: 8.2ms
- Max Frame Time: 12.5ms
- Dropped Frames: 0
- Status: ✅ PASS

Scenario 2: Scrolling Through 100 Messages
- Average Frame Time: 9.1ms
- Max Frame Time: 14.3ms
- Dropped Frames: 0
- Status: ✅ PASS

[Continue for all scenarios...]

Overall Assessment: All performance targets met
```

## Conclusion

Following this guide, you should be able to verify that:

1. ✅ No "Skipped frames" warnings during typical usage
2. ✅ Consistent frame times under 16.67ms
3. ✅ JSON parsing happens in background isolates
4. ✅ Token reads are cached and fast
5. ✅ Event-driven updates replace polling
6. ✅ Selective widget rebuilds
7. ✅ Smooth user experience

If all checks pass, the performance optimization is successful!

---

**Last Updated**: November 20, 2025
**Feature**: flutter-main-thread-optimization
