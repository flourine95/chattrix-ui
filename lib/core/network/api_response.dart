import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Generic API response wrapper matching backend structure
///
/// Success response: {success: true, message: string, data: T}
/// Error response: {success: false, message: string, code: string, details?: Map, requestId: string}
@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({required bool success, required String message, T? data}) = _ApiResponse<T>;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
