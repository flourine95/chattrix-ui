import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_model.freezed.dart';
part 'auth_tokens_model.g.dart';

@freezed
abstract class AuthTokensModel with _$AuthTokensModel {
  const AuthTokensModel._();

  const factory AuthTokensModel({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) = _AuthTokensModel;

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) => _$AuthTokensModelFromJson(json);

  AuthTokens toEntity() {
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType, expiresIn: expiresIn);
  }
}
