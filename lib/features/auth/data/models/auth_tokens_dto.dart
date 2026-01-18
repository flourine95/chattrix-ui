import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/domain/entities/auth_tokens.dart';

part 'auth_tokens_dto.freezed.dart';
part 'auth_tokens_dto.g.dart';

@freezed
abstract class AuthTokensDto with _$AuthTokensDto {
  const AuthTokensDto._();

  const factory AuthTokensDto({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
  }) = _AuthTokensDto;

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) => _$AuthTokensDtoFromJson(json);

  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      tokenType: tokenType,
      expiresIn: expiresIn,
    );
  }
}
