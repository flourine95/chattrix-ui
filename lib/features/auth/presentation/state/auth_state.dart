import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Auth state using Freezed for immutability
/// Combined with AsyncValue in provider for loading/error states
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({User? user, @Default(false) bool isAuthenticated}) = _AuthState;
}
