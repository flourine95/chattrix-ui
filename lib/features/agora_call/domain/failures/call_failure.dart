import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_failure.freezed.dart';

/// Domain-specific failures for call operations
@freezed
abstract class CallFailure with _$CallFailure {
  const factory CallFailure.serverError(String message) = ServerError;
  const factory CallFailure.networkError() = NetworkError;
  const factory CallFailure.userBusy() = UserBusy;
  const factory CallFailure.callNotFound() = CallNotFound;
  const factory CallFailure.permissionDenied(String permission) = PermissionDenied;
  const factory CallFailure.agoraError(String message) = AgoraError;
  const factory CallFailure.unauthorized() = Unauthorized;
}
