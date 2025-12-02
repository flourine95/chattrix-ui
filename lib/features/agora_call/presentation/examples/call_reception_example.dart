/// Example demonstrating the call reception flow
///
/// This example shows how the app-level listener automatically handles
/// incoming calls and navigates to the IncomingCallScreen.
///
/// ## Flow Overview:
///
/// 1. **WebSocket Event Received**
///    - Backend sends `call.incoming` event via WebSocket
///    - Event contains: callId, channelId, callerId, callerName, callerAvatar, callType
///
/// 2. **CallStateProvider Processes Event**
///    - `_listenToCallEvents()` filters for `call.incoming` events
///    - `_handleIncomingCall()` parses the invitation
///    - Creates a `CallEntity` with status `CallStatus.ringing`
///    - Updates provider state with the new call
///
/// 3. **Router Detects State Change**
///    - `AgoraCallRouterNotifier` listens to `callStateProvider`
///    - Notifies GoRouter when call state changes
///    - `_handleAgoraIncomingCallRedirect()` checks conditions:
///      * Call exists with status RINGING
///      * Not already on incoming call screen
///      * App is in foreground
///    - Redirects to `/agora-call/incoming`
///
/// 4. **IncomingCallScreen Appears**
///    - Displays caller information (name, avatar)
///    - Shows call type indicator (audio/video)
///    - Starts ringtone playback (loops until response)
///    - Provides accept and reject buttons
///
/// 5. **User Accepts Call**
///    - Stops ringtone
///    - Calls `callStateProvider.notifier.acceptCall(callId)`
///    - Provider sends accept request to backend
///    - Receives Agora token in response
///    - Joins Agora channel with token
///    - Updates status to CONNECTED
///    - Screen listens to state change
///    - Navigates to `/agora-call/active`
///
/// 6. **User Rejects Call**
///    - Stops ringtone
///    - Calls `callStateProvider.notifier.rejectCall(callId, reason: 'declined')`
///    - Provider sends reject request to backend
///    - Clears call state
///    - Screen dismisses (context.pop())
///    - Does NOT join Agora channel
///
/// 7. **Call Times Out**
///    - Backend sends `call.timeout` event
///    - Provider handles event in `_handleCallTimeout()`
///    - Clears call state
///    - Screen detects null state
///    - Stops ringtone and dismisses
///
/// ## Example WebSocket Event:
///
/// ```json
/// {
///   "type": "call.incoming",
///   "data": {
///     "callId": "550e8400-e29b-41d4-a716-446655440000",
///     "channelId": "channel_123456",
///     "callerId": 42,
///     "callerName": "John Doe",
///     "callerAvatar": "https://example.com/avatar.jpg",
///     "callType": "VIDEO"
///   }
/// }
/// ```
///
/// ## Testing the Flow:
///
/// ### Manual Testing:
/// 1. Ensure app is running and user is logged in
/// 2. Send a `call.incoming` WebSocket event from backend
/// 3. Verify IncomingCallScreen appears automatically
/// 4. Verify ringtone starts playing
/// 5. Test accept flow:
///    - Tap accept button
///    - Verify ringtone stops
///    - Verify navigation to ActiveCallScreen
///    - Verify Agora channel is joined
/// 6. Test reject flow:
///    - Tap reject button
///    - Verify ringtone stops
///    - Verify screen dismisses
/// 7. Test timeout flow:
///    - Wait for timeout event
///    - Verify ringtone stops
///    - Verify screen dismisses
///
/// ### Integration Testing:
/// ```dart
/// testWidgets('Call reception flow', (tester) async {
///   // 1. Setup: Mock WebSocket service and providers
///   final mockWsService = MockChatWebSocketService();
///   final callStateController = StreamController<Map<String, dynamic>>();
///
///   when(mockWsService.rawMessageStream)
///       .thenAnswer((_) => callStateController.stream);
///
///   // 2. Build app with mocked dependencies
///   await tester.pumpWidget(
///     ProviderScope(
///       overrides: [
///         chatWebSocketServiceProvider.overrideWithValue(mockWsService),
///       ],
///       child: MyApp(),
///     ),
///   );
///
///   // 3. Simulate incoming call event
///   callStateController.add({
///     'type': 'call.incoming',
///     'data': {
///       'callId': 'test-call-id',
///       'channelId': 'test-channel',
///       'callerId': 42,
///       'callerName': 'Test Caller',
///       'callType': 'VIDEO',
///     },
///   });
///
///   // 4. Wait for navigation and UI update
///   await tester.pumpAndSettle();
///
///   // 5. Verify IncomingCallScreen is displayed
///   expect(find.text('Test Caller'), findsOneWidget);
///   expect(find.text('Video Call'), findsOneWidget);
///   expect(find.text('Accept'), findsOneWidget);
///   expect(find.text('Reject'), findsOneWidget);
///
///   // 6. Test accept flow
///   await tester.tap(find.text('Accept'));
///   await tester.pumpAndSettle();
///
///   // 7. Verify navigation to ActiveCallScreen
///   expect(find.byType(ActiveCallScreen), findsOneWidget);
/// });
/// ```
///
/// ## Edge Cases Handled:
///
/// 1. **Multiple Rapid Calls**
///    - Only the most recent call is shown
///    - Previous calls are auto-rejected
///
/// 2. **App in Background**
///    - Router checks `isAppInForeground`
///    - No redirect if app is backgrounded
///    - Call invitation is queued until app returns to foreground
///
/// 3. **Already on Call Screen**
///    - Router blocks redirects when on any Agora call screen
///    - Prevents navigation loops
///
/// 4. **WebSocket Disconnection**
///    - Provider handles reconnection
///    - Call state is preserved
///
/// 5. **Permission Denied**
///    - Handled in accept flow
///    - User is notified
///    - Call is ended gracefully
///
/// ## Architecture Benefits:
///
/// 1. **Separation of Concerns**
///    - Router handles navigation logic
///    - Provider handles business logic
///    - Screen handles UI and user interaction
///
/// 2. **Reactive Updates**
///    - State changes automatically trigger UI updates
///    - No manual navigation calls needed
///
/// 3. **Testability**
///    - Each component can be tested independently
///    - Easy to mock dependencies
///
/// 4. **Maintainability**
///    - Clear flow from event to UI
///    - Easy to add new features or modify behavior
library;

// This is a documentation file - no executable code
