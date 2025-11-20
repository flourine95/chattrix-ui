# Implementation Plan - Fix Agora Token API Authentication

## Task List

- [x] 1. Fix API endpoint paths in ApiConstants





  - Add `agoraTokenGenerate` getter returning `$_baseUrl/$_v1/agora/token/generate`
  - Add `agoraTokenRefresh` getter returning `$_baseUrl/$_v1/agora/token/refresh`
  - Remove old `agoraToken` getter that reads from .env
  - _Requirements: 1.1, 1.2_

- [x] 2. Update TokenService to use correct endpoints and request format





  - [x] 2.1 Update fetchToken method


    - Change endpoint from `ApiConstants.agoraToken` to `ApiConstants.agoraTokenGenerate`
    - Change request body from `{channelName, uid, role}` to `{channelId, role, expirationSeconds}`
    - Update response parsing to extract `{token, uid, channelId, expiresAt}` from `response.data['data']`
    - Return `Map<String, dynamic>` instead of just `String`
    - _Requirements: 5.1, 5.2, 5.3_
  
  - [x] 2.2 Update refreshToken method

    - Change endpoint to `ApiConstants.agoraTokenRefresh`
    - Change request body to `{channelId, oldToken}`
    - Update response parsing to match new format
    - _Requirements: 4.1, 4.2_
  
  - [x] 2.3 Add input validation

    - Validate channelId is not empty
    - Validate role is 'publisher' or 'subscriber'
    - Validate expirationSeconds is between 60 and 86400
    - Return `Failure.validation` for invalid inputs
    - _Requirements: 5.4, 5.5_
  
  - [x] 2.4 Enhance error handling

    - Update `_handleDioError` to provide user-friendly messages
    - Add specific handling for 401, 403, 404, 400, 500 errors
    - Add connection error message with backend URL
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 6.1, 6.2, 6.3, 6.4, 6.5_
  
  - [x] 2.5 Add comprehensive logging

    - Log request URL and parameters (excluding sensitive data)
    - Log response status and data
    - Log errors with full details
    - Use CallLogger if available
    - _Requirements: 7.1, 7.2, 7.3, 7.4_

- [x] 3. Update CallRepository to handle new token response format





  - [x] 3.1 Update createCall method


    - Call `fetchToken()` and extract `uid` from response
    - Pass `uid` to `agoraService.joinChannel()`
    - Remove local UID generation logic
    - _Requirements: 1.1, 1.2_
  
  - [x] 3.2 Update joinCall method


    - Same changes as createCall
    - _Requirements: 1.1, 1.2_
  
  - [x] 3.3 Update token refresh handling


    - Pass `oldToken` to `refreshToken()` method
    - Handle new response format
    - _Requirements: 8.1, 8.2, 8.4_

- [x] 4. Verify and update Failure types





  - Check if all required Failure types exist in `lib/core/errors/failures.dart`
  - Add missing types: `validation`, `unauthorized`, `forbidden`, `notFound`
  - Ensure each type has `message` and optional `errorCode` fields
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 5. Clean up .env file




  - Remove `AGORA_TOKEN_SERVER_URL` line (không cần thiết)
  - Keep only `AGORA_APP_ID`
  - _Requirements: 1.1_

- [ ] 6. Test the fix
  - [ ] 6.1 Manual testing
    - Ensure backend is running on localhost:8080
    - Ensure user is logged in (JWT token exists)
    - Initiate a call and verify token fetch succeeds
    - Check logs for request/response details
    - Verify Agora SDK can join channel with fetched token
    - _Requirements: 4.1, 4.2, 9.1, 9.2, 9.3_
  
  - [ ] 6.2 Test error scenarios
    - Test with backend stopped (should show connection error)
    - Test with invalid JWT (should show auth error)
    - Test with invalid channel ID (should show validation error)
    - Verify error messages are user-friendly
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_
  
  - [ ] 6.3 Test token refresh
    - Simulate token expiration during call
    - Verify token refresh is called automatically
    - Verify call continues without interruption
    - _Requirements: 8.1, 8.2, 8.3, 8.4_

- [ ]* 7. Write unit tests for TokenService
  - Test successful token fetch
  - Test token refresh
  - Test input validation
  - Test error handling for each DioException type
  - Test response parsing
  - _Requirements: 1.1, 4.1, 5.1, 6.1_

- [ ]* 8. Add integration tests
  - Test end-to-end token flow from UI to backend
  - Test with valid/expired/invalid JWT tokens
  - Test error recovery flows
  - _Requirements: 1.1, 2.1, 8.1_
