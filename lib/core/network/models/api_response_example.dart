/// HOW TO USE ApiResponse<T>
/// 
/// This file demonstrates the CORRECT usage matching ACTUAL backend response format

import 'package:chattrix_ui/core/network/models/api_response.dart';
import 'package:chattrix_ui/features/auth/data/models/auth_tokens_model.dart';
import 'package:chattrix_ui/features/auth/data/models/user_model.dart';

/// ============================================================================
/// EXAMPLE 1: SUCCESS RESPONSE
/// ============================================================================

void exampleSuccessResponse() {
  // Raw JSON from API
  final json = {
    'success': true,
    'message': 'Login successful',
    'data': {
      'accessToken': 'token123',
      'refreshToken': 'refresh456',
      'tokenType': 'Bearer',
      'expiresIn': 86400,
    },
  };

  // Parse to ApiResponse<AuthTokensModel>
  final response = ApiResponse.fromJson(
    json,
    (data) => AuthTokensModel.fromJson(data as Map<String, dynamic>),
  );

  // Type-safe access! ✅
  if (response.isSuccess) {
    final tokens = response.data!; // AuthTokensModel - type safe!
    print('Access Token: ${tokens.accessToken}');
    print('Expires in: ${tokens.expiresIn}s');
  }
}

/// ============================================================================
/// EXAMPLE 2: ERROR RESPONSE - Validation Error (ACTUAL BACKEND FORMAT)
/// ============================================================================

void exampleValidationError() {
  // ACTUAL Raw JSON from backend ✅
  final json = {
    'success': false,
    'message': 'Validation failed',
    'code': 'VALIDATION_ERROR', // ← FLAT, không nested
    'details': { // ← FLAT, không nested
      'email': 'Email already exists',
      'username': 'Username must be 4-20 characters',
      'password': 'Password cannot be blank',
    },
    'requestId': 'e46f12cd-985d-4c5f-8440-74cb8eb3990b',
  };

  // Parse to ApiResponse<UserModel>
  final response = ApiResponse<UserModel>.fromJson(
    json,
    (data) => UserModel.fromJson(data as Map<String, dynamic>),
  );

  // Handle errors! ✅
  if (response.isError) {
    print('Error Code: ${response.errorCode}'); // VALIDATION_ERROR
    print('Error Message: ${response.errorMessage}'); // Validation failed

    // Show field-level errors in UI
    final errors = response.validationErrors;
    if (errors != null) {
      errors.forEach((field, message) {
        print('❌ $field: $message');
        // email: Email already exists
        // username: Username must be 4-20 characters
        // password: Password cannot be blank
      });
    }
  }
}

/// ============================================================================
/// EXAMPLE 3: ERROR RESPONSE - Business Error (ACTUAL FORMAT)
/// ============================================================================

void exampleBusinessError() {
  // ACTUAL Raw JSON from backend ✅
  final json = {
    'success': false,
    'code': 'USER_NOT_FOUND',
    'message': 'User with this email does not exist',
    'requestId': 'req-67890',
  };

  final response = ApiResponse<UserModel>.fromJson(
    json,
    (data) => UserModel.fromJson(data as Map<String, dynamic>),
  );

  if (response.isError) {
    // Single business error - show toast/snackbar
    print('🚫 ${response.errorMessage}');
    print('Error Code: ${response.errorCode}');
  }
}

/// ============================================================================
/// CORRECT vs WRONG
/// ============================================================================

/// ❌ WRONG (API spec shows this, but backend doesn't actually do it):
/// {
///   "success": false,
///   "error": {              // ← Nested object (KHÔNG TỒN TẠI)
///     "code": "...",
///     "message": "...",
///     "details": {...}
///   }
/// }

/// ✅ CORRECT (Actual backend response):
/// {
///   "success": false,
///   "message": "...",
///   "code": "...",          // ← Flat structure
///   "details": {...},       // ← Flat structure
///   "requestId": "..."
/// }

