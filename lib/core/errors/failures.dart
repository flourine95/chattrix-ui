import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.server({required String message, String? errorCode}) =
      ServerFailure;

  const factory Failure.network({required String message}) = NetworkFailure;

  const factory Failure.validation({
    required String message,
    List<ValidationError>? errors,
  }) = ValidationFailure;

  const factory Failure.unauthorized({
    required String message,
    String? errorCode,
  }) = UnauthorizedFailure;

  const factory Failure.notFound({required String message, String? errorCode}) =
      NotFoundFailure;

  const factory Failure.conflict({required String message, String? errorCode}) =
      ConflictFailure;

  const factory Failure.rateLimitExceeded({required String message}) =
      RateLimitFailure;

  const factory Failure.unknown({required String message}) = UnknownFailure;
}

class ValidationError {
  final String? field;
  final String errorCode;
  final String message;

  ValidationError({this.field, required this.errorCode, required this.message});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      field: json['field'] as String?,
      errorCode: json['errorCode'] as String,
      message: json['message'] as String,
    );
  }
}
