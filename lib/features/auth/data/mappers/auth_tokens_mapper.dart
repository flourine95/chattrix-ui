import 'package:chattrix_ui/features/auth/data/models/auth_tokens_dto.dart';
import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';

extension AuthTokensDtoMapper on AuthTokensDto {
  AuthTokens toEntity() {
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken, tokenType: tokenType, expiresIn: expiresIn);
  }
}

extension AuthTokensEntityMapper on AuthTokens {
  AuthTokensDto toDto() {
    return AuthTokensDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }
}
