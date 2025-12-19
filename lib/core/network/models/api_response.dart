import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    String? message,
    T? data,
    String? code,
    Map<String, dynamic>? details,
    String? requestId,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

extension ApiResponseX<T> on ApiResponse<T> {
  bool get isSuccess => success && data != null;

  bool get isError => !success || code != null;

  String? get errorMessage => message;

  String? get errorCode => code;

  Map<String, String>? get validationErrors {
    if (details == null) return null;
    return details!.map((key, value) => MapEntry(key, value.toString()));
  }
}
