import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.server({required String message, String? errorCode}) = ServerFailure;

  const factory Failure.network({required String message}) = NetworkFailure;

  const factory Failure.validation({required String message, List<ValidationError>? errors}) = ValidationFailure;

  const factory Failure.badRequest({required String message, String? errorCode}) = BadRequestFailure;

  const factory Failure.unauthorized({required String message, String? errorCode}) = UnauthorizedFailure;

  const factory Failure.forbidden({required String message, String? errorCode}) = ForbiddenFailure;

  const factory Failure.notFound({required String message, String? errorCode}) = NotFoundFailure;

  const factory Failure.conflict({required String message, String? errorCode}) = ConflictFailure;

  const factory Failure.rateLimitExceeded({required String message}) = RateLimitFailure;

  const factory Failure.unknown({required String message}) = UnknownFailure;

  // Call feature specific failures
  const factory Failure.permission({required String message}) = PermissionFailure;

  const factory Failure.agoraEngine({required String message, int? code}) = AgoraEngineFailure;

  const factory Failure.tokenExpired({required String message}) = TokenExpiredFailure;

  const factory Failure.channelJoin({required String message}) = ChannelJoinFailure;

  // WebSocket signaling failures
  const factory Failure.webSocketNotConnected({required String message}) = WebSocketNotConnectedFailure;

  const factory Failure.webSocketSendFailed({required String message}) = WebSocketSendFailure;

  // Call-specific failures
  const factory Failure.callNotFound({required String message}) = CallNotFoundFailure;

  const factory Failure.callAlreadyActive({required String message}) = CallAlreadyActiveFailure;
}

class ValidationError {
  final String? field;
  final String errorCode;
  final String message;

  ValidationError({this.field, required this.errorCode, required this.message});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      field: json['field'] as String?,
      errorCode: json['code'] ?? json['errorCode'] as String,
      message: json['message'] as String,
    );
  }
}

/// Extension to provide user-friendly error messages for all Failure types
extension FailureMessage on Failure {
  String get userMessage {
    return when(
      server: (message, errorCode) => 'Server error. Please try again later.',
      network: (message) => 'Network error. Please check your internet connection.',
      validation: (message, errors) => message,
      badRequest: (message, errorCode) => 'Invalid request. Please check your input.',
      unauthorized: (message, errorCode) => 'Authentication failed. Please login again.',
      forbidden: (message, errorCode) => 'Access denied. You do not have permission to perform this action.',
      notFound: (message, errorCode) => 'Resource not found. Please try again.',
      conflict: (message, errorCode) => 'A conflict occurred. Please refresh and try again.',
      rateLimitExceeded: (message) => 'Too many requests. Please wait a moment and try again.',
      unknown: (message) => 'An unexpected error occurred. Please try again.',
      permission: (message) => message,
      agoraEngine: (message, code) => 'Failed to join call. Please check your connection and try again.',
      tokenExpired: (message) => 'Session expired. Please login again.',
      channelJoin: (message) => 'Failed to join call. Please try again.',
      webSocketNotConnected: (message) => 'Connection lost. Please check your internet connection.',
      webSocketSendFailed: (message) => 'Failed to send message. Please try again.',
      callNotFound: (message) => 'Call not found. It may have already ended.',
      callAlreadyActive: (message) => 'You are already in a call.',
    );
  }
}
