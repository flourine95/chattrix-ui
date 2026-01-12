import 'package:chattrix_ui/features/auth/data/models/auth_tokens_dto.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> verifyEmail({required String email, required String otp});

  Future<void> resendVerification({required String email});

  Future<AuthTokensDto> login({required String usernameOrEmail, required String password});

  Future<UserDto> getCurrentUser(String accessToken);

  Future<AuthTokensDto> refreshToken(String refreshToken);

  Future<void> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
  });

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({required String email, required String otp, required String newPassword});

  Future<void> logout(String accessToken);

  Future<void> logoutAll(String accessToken);
}
