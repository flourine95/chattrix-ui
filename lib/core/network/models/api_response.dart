import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    String? message,
    T? data,
    // Error fields (flat structure, NOT nested)
    String? code, // Error code: VALIDATION_ERROR, UNAUTHORIZED, etc.
    Map<String, dynamic>? details, // Field-level validation errors
    String? requestId, // Request tracking ID
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

/// Helper extension for easier error checking
extension ApiResponseX<T> on ApiResponse<T> {
  /// Check if response is successful
  bool get isSuccess => success && data != null;

  /// Check if response is error
  bool get isError => !success || code != null;

  /// Get error message safely
  String? get errorMessage => message;

  /// Get error code safely
  String? get errorCode => code;

  /// Get field-level validation errors as Map<String, String>
  Map<String, String>? get validationErrors {
    if (details == null) return null;
    return details!.map((key, value) => MapEntry(key, value.toString()));
  }
}


