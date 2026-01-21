import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Auth state using freezed union types
@freezed
abstract class AuthState with _$AuthState {
  /// Initial state - checking auth status
  const factory AuthState.initial() = _Initial;
  
  /// Loading state - performing auth operation
  const factory AuthState.loading() = _Loading;
  
  /// Authenticated state - user is logged in
  const factory AuthState.authenticated({
    required User user,
  }) = _Authenticated;
  
  /// Unauthenticated state - user is not logged in
  const factory AuthState.unauthenticated({
    String? message,
  }) = _Unauthenticated;
  
  /// Error state - auth operation failed
  const factory AuthState.error({
    required String message,
  }) = _Error;
}

/// Extension methods for convenience and backward compatibility
extension AuthStateX on AuthState {
  bool get isLoading => this is _Loading;
  bool get isAuthenticated => this is _Authenticated;
  
  User? get user => maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
  
  String? get errorMessage => maybeWhen(
    error: (message) => message,
    unauthenticated: (message) => message,
    orElse: () => null,
  );
}
