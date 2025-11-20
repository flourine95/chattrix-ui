# Requirements Document - Fix Agora Token API Authentication

## Introduction

This document defines the requirements for fixing the authentication issue when calling Agora token API endpoints from the Flutter application. The backend requires JWT authentication for all Agora token endpoints, but the current implementation may not be sending the authentication token correctly, resulting in "Network error while fetching token" errors.

## Glossary

- **JWT Token**: JSON Web Token used for authenticating API requests
- **Dio Interceptor**: A mechanism in Dio HTTP client to intercept and modify requests/responses
- **Secure Storage**: Flutter secure storage for storing sensitive data like JWT tokens
- **Authentication Header**: HTTP header containing the Bearer token for authentication
- **Agora Token API**: Backend endpoints for generating and refreshing Agora RTC tokens
- **Network Error**: Generic error message when HTTP request fails
- **401 Unauthorized**: HTTP status code indicating authentication failure
- **Bearer Token**: Authentication scheme where the token is sent in the Authorization header

## Requirements

### Requirement 1

**User Story:** As a Flutter developer, I want to ensure JWT tokens are sent with Agora token API requests, so that authentication succeeds.

#### Acceptance Criteria

1. WHEN the app makes a request to Agora token endpoints THEN the system SHALL include the JWT token in the Authorization header
2. WHEN the JWT token is retrieved THEN the system SHALL use the format "Bearer {token}"
3. WHEN the JWT token is not available THEN the system SHALL return a clear authentication error
4. WHEN the request is made THEN the system SHALL log the request URL and headers for debugging
5. WHEN authentication fails THEN the system SHALL provide a user-friendly error message

### Requirement 2

**User Story:** As a Flutter developer, I want to verify the Dio client is configured correctly, so that all API requests include authentication.

#### Acceptance Criteria

1. WHEN the Dio client is initialized THEN the system SHALL add an interceptor for authentication
2. WHEN an interceptor adds the token THEN the system SHALL retrieve it from secure storage
3. WHEN the token is expired THEN the system SHALL attempt to refresh it before making the request
4. WHEN token refresh fails THEN the system SHALL redirect the user to login
5. WHEN the Dio client makes a request THEN the system SHALL log request and response for debugging

### Requirement 3

**User Story:** As a user, I want clear error messages when token fetching fails, so that I understand what went wrong.

#### Acceptance Criteria

1. WHEN a 401 error occurs THEN the system SHALL display "Authentication failed. Please login again."
2. WHEN a network error occurs THEN the system SHALL display "Network error. Please check your connection."
3. WHEN a 500 error occurs THEN the system SHALL display "Server error. Please try again later."
4. WHEN the backend is unreachable THEN the system SHALL display "Cannot connect to server. Please check if the backend is running."
5. WHEN an error occurs THEN the system SHALL log the full error details for debugging

### Requirement 4

**User Story:** As a Flutter developer, I want to verify the backend is running and accessible, so that I can rule out connectivity issues.

#### Acceptance Criteria

1. WHEN debugging THEN the system SHALL provide a health check endpoint test
2. WHEN the health check succeeds THEN the system SHALL confirm the backend is reachable
3. WHEN the health check fails THEN the system SHALL display the connection error details
4. WHEN testing authentication THEN the system SHALL provide a way to test with a sample token
5. WHEN the base URL is incorrect THEN the system SHALL display a clear error message

### Requirement 5

**User Story:** As a Flutter developer, I want to ensure the request body format matches backend expectations, so that validation succeeds.

#### Acceptance Criteria

1. WHEN generating a token THEN the system SHALL send channelId, role, and expirationSeconds in the request body
2. WHEN the request body is created THEN the system SHALL validate all required fields are present
3. WHEN the backend returns validation errors THEN the system SHALL display which fields are invalid
4. WHEN the role is set THEN the system SHALL use "publisher" or "subscriber" as valid values
5. WHEN expirationSeconds is set THEN the system SHALL ensure it is between 60 and 86400

### Requirement 6

**User Story:** As a Flutter developer, I want to implement proper error handling in the repository layer, so that errors are caught and transformed correctly.

#### Acceptance Criteria

1. WHEN a DioException occurs THEN the system SHALL check the response status code
2. WHEN the status code is 401 THEN the system SHALL return Failure.authentication
3. WHEN the status code is 400 THEN the system SHALL return Failure.validation with details
4. WHEN the status code is 500 THEN the system SHALL return Failure.server
5. WHEN no response is received THEN the system SHALL return Failure.network with connection details

### Requirement 7

**User Story:** As a Flutter developer, I want to add logging throughout the token fetching flow, so that I can debug issues easily.

#### Acceptance Criteria

1. WHEN a token request starts THEN the system SHALL log the channel ID and role
2. WHEN the request is sent THEN the system SHALL log the full URL and headers (excluding sensitive data)
3. WHEN a response is received THEN the system SHALL log the status code and response body
4. WHEN an error occurs THEN the system SHALL log the error type and message
5. WHEN debugging is enabled THEN the system SHALL log the JWT token (first 20 characters only)

### Requirement 8

**User Story:** As a user, I want the app to handle token expiration gracefully, so that my calls are not interrupted.

#### Acceptance Criteria

1. WHEN the JWT token is about to expire THEN the system SHALL refresh it proactively
2. WHEN token refresh succeeds THEN the system SHALL retry the original request
3. WHEN token refresh fails THEN the system SHALL log the user out
4. WHEN the Agora token expires during a call THEN the system SHALL request a new one automatically
5. WHEN Agora token refresh fails THEN the system SHALL end the call gracefully

### Requirement 9

**User Story:** As a Flutter developer, I want to create a test endpoint to verify authentication works, so that I can isolate the issue.

#### Acceptance Criteria

1. WHEN testing authentication THEN the system SHALL provide a simple test method
2. WHEN the test succeeds THEN the system SHALL confirm authentication is working
3. WHEN the test fails THEN the system SHALL display the specific error
4. WHEN testing THEN the system SHALL use the same Dio client as the real implementation
5. WHEN testing THEN the system SHALL log all request and response details

### Requirement 10

**User Story:** As a Flutter developer, I want to verify CORS is configured correctly on the backend, so that browser-based testing works.

#### Acceptance Criteria

1. WHEN the backend receives a preflight request THEN the system SHALL return appropriate CORS headers
2. WHEN CORS is configured THEN the system SHALL allow requests from the Flutter app origin
3. WHEN CORS fails THEN the system SHALL log the CORS error details
4. WHEN testing on web THEN the system SHALL verify CORS headers are present
5. WHEN CORS is misconfigured THEN the system SHALL provide instructions to fix it
