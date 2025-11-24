# Implementation Plan

- [x] 1. Create IncomingCallRouterNotifier





  - Create new file `lib/core/router/incoming_call_router_notifier.dart`
  - Implement `ChangeNotifier` with `WidgetsBindingObserver` mixin
  - Add constructor that listens to `currentIncomingCallProvider` and calls `notifyListeners()` on changes
  - Implement `didChangeAppLifecycleState` to track lifecycle and call `notifyListeners()`
  - Add `isAppInForeground` getter that checks if lifecycle state is `resumed`
  - Implement proper `dispose()` to remove lifecycle observer
  - _Requirements: 1.1, 4.1, 4.4_

- [ ]* 1.1 Write property test for lifecycle notification
  - **Property 8: Lifecycle changes trigger router refresh**
  - **Validates: Requirements 4.4**

- [x] 2. Create provider for IncomingCallRouterNotifier




  - Add Riverpod provider in `lib/core/router/incoming_call_router_notifier.dart`
  - Ensure provider calls `dispose()` on notifier when disposed
  - _Requirements: 1.1_
-

- [x] 3. Update AppRouter to integrate incoming call redirect




  - Modify `AppRouter.router()` method in `lib/core/router/app_router.dart`
  - Add `incomingCallRouterNotifierProvider` to `refreshListenable` using `Listenable.merge()`
  - Create `_handleIncomingCallRedirect()` static method
  - Update main `redirect` callback to call `_handleIncomingCallRedirect()` after auth redirect
  - _Requirements: 1.1, 1.2, 1.3_

- [ ]* 3.1 Write property test for redirect logic with foreground state
  - **Property 1: Incoming call triggers navigation**
  - **Validates: Requirements 1.1, 1.2**

- [ ]* 3.2 Write property test for redirect logic with background state
  - **Property 7: Background calls don't trigger navigation**
  - **Validates: Requirements 4.2**

- [ ]* 3.3 Write property test for background-to-foreground transition
  - **Property 2: Background-to-foreground transition shows pending call**
  - **Validates: Requirements 1.3**

- [x] 4. Implement _handleIncomingCallRedirect method




  - Read `currentIncomingCallProvider` to get current invitation
  - Check if invitation is not null
  - Check if current location is not already `/incoming-call`
  - Check if app is in foreground using `notifier.isAppInForeground`
  - Return `/incoming-call` if all conditions met, otherwise return null
  - _Requirements: 1.1, 1.2, 4.2_
-

- [x] 5. Update IncomingCallScreen to read invitation from provider




  - Modify `lib/features/call/presentation/pages/incoming_call_screen.dart`
  - Remove `invitation` parameter from constructor
  - Use `ref.watch(currentIncomingCallProvider)` to get invitation
  - Add null check - if invitation is null, navigate to home using `context.go('/')`
  - Add `useEffect` cleanup to call `clearInvitation()` when screen is disposed
  - _Requirements: 3.4, 5.1_

- [ ]* 5.1 Write property test for screen displays caller information
  - **Property 9: Incoming call screen displays complete caller information**
  - **Validates: Requirements 5.1**
-

- [x] 6. Update IncomingCallScreen action handlers



  - Modify `_handleReject()` to call `clearInvitation()` before navigation
  - Change navigation from `context.pop()` to `context.go('/')`
  - Modify `_handleAccept()` to call `clearInvitation()` before navigation
  - Change navigation from `context.pushReplacement()` to `context.go()`
  - Update timeout handler to call `clearInvitation()` before navigation
  - _Requirements: 1.4, 3.3, 3.4, 5.2, 5.3, 5.4_

- [ ]* 6.1 Write property test for call actions clear state
  - **Property 3: Call actions clear state and navigate**
  - **Validates: Requirements 1.4, 5.2, 5.3**

- [ ]* 6.2 Write property test for state cleanup on navigation
  - **Property 6: State cleanup on navigation away**
  - **Validates: Requirements 3.3, 3.4, 4.5**

- [ ]* 6.3 Write unit test for timeout behavior
  - Test that 60-second timeout triggers auto-reject
  - Verify navigation occurs after timeout
  - _Requirements: 5.4_

- [x] 7. Update incoming-call route definition




  - Modify route in `lib/core/router/app_router.dart`
  - Remove `extra` parameter from route builder
  - Change builder to `return const IncomingCallScreen();`
  - _Requirements: 1.1_
-

- [x] 8. Remove IncomingCallListener from main.dart




  - Modify `lib/main.dart`
  - Remove `IncomingCallListener` import
  - Update `builder` property to only include `ToastOverlay`
  - _Requirements: 2.1, 2.4_
-

- [x] 9. Delete IncomingCallListener file



  - Delete `lib/features/call/presentation/widgets/incoming_call_listener.dart`
  - _Requirements: 2.3_

- [ ]* 10. Write integration tests for full flow
  - Test incoming call while app is in foreground
  - Test accept call flow with navigation
  - Test reject call flow with navigation
  - Test background call then foreground transition
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [ ]* 11. Write property test for sequential calls independence
  - **Property 4: Sequential calls maintain independent state**
  - **Validates: Requirements 1.5**

- [ ]* 12. Write property test for ringtone lifecycle
  - **Property 10: Ringtone lifecycle management**
  - **Validates: Requirements 5.5**
-

- [x] 13. Checkpoint - Ensure all tests pass




  - Ensure all tests pass, ask the user if questions arise.
