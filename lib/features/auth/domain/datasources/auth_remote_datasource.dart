import '../../data/models/auth_tokens_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> verifyEmail({required String email, required String otp});

  Future<void> resendVerification({required String email});

  Future<AuthTokensModel> login({
    required String usernameOrEmail,
    required String password,
  });

  Future<UserModel> getCurrentUser(String accessToken);

  Future<AuthTokensModel> refreshToken(String refreshToken);

  Future<void> changePassword({
    required String accessToken,
    required String currentPassword,
    required String newPassword,
  });

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<void> logout(String accessToken);

  Future<void> logoutAll(String accessToken);
}
