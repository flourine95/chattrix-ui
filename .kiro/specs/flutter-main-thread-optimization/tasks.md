# Implementation Plan

- [x] 1. Create token cache service for in-memory JWT storage
  - Implement `TokenCacheService` class with in-memory cache and FlutterSecureStorage integration
  - Add methods for getting, setting, and clearing tokens
  - Implement cache-first read strategy with fallback to secure storage
  - Create Riverpod provider for `TokenCacheService`
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [x] 1.1 Write property test for token cache consistency
  - **Property 8: Token refresh updates both cache and storage**
  - **Property 9: Token clear removes from both locations**
  - **Validates: Requirements 2.4, 2.5**

- [x] 1.2 Write property test for cache-first reads
  - **Property 5: Token cache avoids repeated storage access**
  - **Validates: Requirements 2.1**

- [x] 2. Update AuthInterceptor to use token cache
  - Replace direct `FlutterSecureStorage` usage with `TokenCacheService`
  - Update `onRequest` to read tokens from cache
  - Update `_refreshAccessToken` to update cache when refreshing tokens
  - Update `_clearTokens` to clear both cache and storage
  - _Requirements: 2.1, 2.3, 2.4, 2.5_

- [x] 2.1 Write unit tests for AuthInterceptor with token cache
  - Test that `onRequest` uses cache for token retrieval
  - Test that token refresh updates cache
  - Test that token clear removes from both locations
  - _Requirements: 2.1, 2.3, 2.4, 2.5_

- [x] 3. Create JSON parsing service with isolate support
  - Implement `JsonParsingService` class with static methods
  - Create top-level isolate functions for parsing messages, conversations, typing indicators, and user status
  - Use `compute()` to execute parsing in background isolates
  - Add error handling for malformed JSON
  - _Requirements: 1.1, 1.2, 1.4, 1.5_

- [x] 3.1 Write property test for JSON parsing in background isolate
  - **Property 1: JSON parsing happens in background isolate**
  - **Validates: Requirements 1.1**

- [x] 3.2 Write property test for large payload handling
  - **Property 4: Large payloads use compute()**
  - **Validates: Requirements 1.4**

- [x] 4. Update ChatWebSocketService to use background parsing
  - Replace synchronous `jsonDecode()` with `JsonParsingService` methods
  - Update `_handleMessage` to use async parsing
  - Ensure all message types (chat, typing, status, conversation) use background parsing
  - Maintain error handling for parsing failures
  - _Requirements: 1.1, 1.2, 1.4, 1.5_

- [x] 4.1 Write property test for frame timing during message parsing
  - **Property 2: JSON parsing does not cause frame drops**
  - **Validates: Requirements 1.2**

- [x] 4.2 Write property test for rapid message handling
  - **Property 3: Rapid messages maintain 60 FPS**
  - **Validates: Requirements 1.3**

- [x] 5. Implement event-driven updates in MessagesNotifier
  - Remove unconditional polling timer from `build()` method
  - Add WebSocket connection state listener
  - Enable polling only when WebSocket is disconnected
  - Disable polling when WebSocket is connected
  - Keep WebSocket message stream listener for event-driven updates
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_

- [x] 5.1 Write property test for polling behavior based on connection state
  - **Property 10: WebSocket connection disables polling**
  - **Property 11: Disconnection enables polling**
  - **Property 12: Reconnection disables polling**
  - **Validates: Requirements 3.1, 3.2, 3.3, 3.4**

- [x] 5.2 Write property test for targeted updates
  - **Property 13: WebSocket messages trigger targeted updates**
  - **Validates: Requirements 3.5**

- [x] 6. Implement event-driven updates in ConversationsNotifier
  - Remove any polling timers if present
  - Rely solely on WebSocket streams for updates
  - Add connection state handling similar to MessagesNotifier
  - _Requirements: 3.1, 3.3_

- [x] 7. Optimize message list rendering in ChatViewPage
  - Add `const` constructors to MessageBubble where possible
  - Verify `cacheExtent` is properly configured in ListView.builder
  - Add `RepaintBoundary` widgets around message bubbles if not present
  - Implement replied message lookup caching using `useMemoized` hook
  - _Requirements: 4.1, 4.2, 4.5_

- [x] 7.1 Write property test for selective widget rebuilds
  - **Property 14: Selective widget rebuilds**
  - **Validates: Requirements 4.3**

- [x] 7.2 Write property test for replied message caching
  - **Property 16: Replied message lookup caching**
  - **Validates: Requirements 4.5**

- [x] 8. Implement lazy loading for media attachments
  - Update image and video widgets to use lazy loading
  - Only load media when message is within viewport
  - Use `addAutomaticKeepAlives: false` for ListView if not already set
  - _Requirements: 4.4_

- [x] 8.1 Write property test for lazy media loading
  - **Property 15: Lazy loading for media**
  - **Validates: Requirements 4.4**

- [x] 9. Add performance monitoring and logging
  - Add execution time logging for operations exceeding 16ms
  - Add isolate creation and message passing overhead logging
  - Enable performance overlay in debug mode
  - Add frame timing measurements for typical usage scenarios
  - _Requirements: 5.1, 5.2, 5.4, 5.5_

- [x] 9.1 Write integration test for overall performance
  - **Property 17: Consistent 60 FPS during typical usage**
  - **Validates: Requirements 5.5**

- [x] 10. Update auth local datasource to use token cache





  - Modify `AuthLocalDataSourceImpl` to inject and use `TokenCacheService` instead of direct `FlutterSecureStorage`
  - Update `saveTokens()` to use `tokenCacheService.setTokens()`
  - Update `getAccessToken()` to use `tokenCacheService.getAccessToken()`
  - Update `getRefreshToken()` to use `tokenCacheService.getRefreshToken()`
  - Update `deleteTokens()` to use `tokenCacheService.clearTokens()`
  - _Requirements: 2.1, 2.4, 2.5_

- [x] 11. Update auth providers to inject token cache service




  - Update `authLocalDataSourceProvider` to inject `TokenCacheService` instead of `FlutterSecureStorage`
  - Ensure all auth flows (login, logout, token refresh) use the cache
  - _Requirements: 2.1, 2.4, 2.5_
-

- [x] 12. Checkpoint - Ensure all tests pass




  - Ensure all tests pass, ask the user if questions arise.
-

- [x] 13. Performance validation and testing




  - Run Flutter DevTools Timeline to verify frame times
  - Test with 10, 50, 100 rapid messages
  - Verify no "Skipped frames" warnings during typical usage
  - Measure and document performance improvements
  - _Requirements: 1.3, 5.5_

- [ ] 14. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
