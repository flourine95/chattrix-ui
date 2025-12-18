import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class for domain-level error handling
///
/// All failures include a code field matching API error codes:
/// - VALIDATION_ERROR, UNAUTHORIZED, FORBIDDEN, RESOURCE_NOT_FOUND, CONFLICT, RATE_LIMIT_EXCEEDED
/// - TIMEOUT, NO_CONNECTION, SERVER_ERROR, UNEXPECTED_ERROR
@freezed
abstract class Failure with _$Failure {
  /// Server error (5xx or unexpected errors)
  const factory Failure.server({required String message, required String code, String? requestId}) = ServerFailure;

  /// Network connectivity error
  const factory Failure.network({required String message, required String code}) = NetworkFailure;

  /// Validation error with field-specific details
  const factory Failure.validation({
    required String message,
    required String code,
    Map<String, String>? details,
    String? requestId,
  }) = ValidationFailure;

  /// Authentication/Authorization error (401, 403)
  const factory Failure.auth({required String message, required String code, String? requestId}) = AuthFailure;

  /// Resource not found error (404)
  const factory Failure.notFound({required String message, required String code, String? requestId}) = NotFoundFailure;

  /// Conflict error (409) - e.g., duplicate email/username
  const factory Failure.conflict({required String message, required String code, String? requestId}) = ConflictFailure;

  /// Rate limit exceeded error (429)
  const factory Failure.rateLimit({required String message, required String code, String? requestId}) =
      RateLimitFailure;
}

/// Extension to provide user-friendly error messages for all Failure types
extension FailureMessage on Failure {
  String get userMessage {
    return when(
      server: (message, code, requestId) => 'Server error. Please try again later.',
      network: (message, code) => 'Network error. Please check your internet connection.',
      validation: (message, code, details, requestId) => message,
      auth: (message, code, requestId) => 'Authentication failed. Please login again.',
      notFound: (message, code, requestId) => 'Resource not found. Please try again.',
      conflict: (message, code, requestId) => 'A conflict occurred. Please refresh and try again.',
      rateLimit: (message, code, requestId) => 'Too many requests. Please wait a moment and try again.',
    );
  }
}
