import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link_dto.freezed.dart';
part 'invite_link_dto.g.dart';

@freezed
abstract class CreateInviteLinkRequestDto with _$CreateInviteLinkRequestDto {
  const factory CreateInviteLinkRequestDto({int? expiresIn, int? maxUses}) = _CreateInviteLinkRequestDto;

  factory CreateInviteLinkRequestDto.fromJson(Map<String, dynamic> json) => _$CreateInviteLinkRequestDtoFromJson(json);
}

@freezed
abstract class InviteLinkDto with _$InviteLinkDto {
  const factory InviteLinkDto({
    required int id,
    required String token,
    required int conversationId,
    required int createdBy,
    required String createdByUsername,
    required String createdAt,
    String? expiresAt,
    int? maxUses,
    required int currentUses,
    required bool revoked,
    String? revokedAt,
    int? revokedBy,
    required bool valid,
  }) = _InviteLinkDto;

  factory InviteLinkDto.fromJson(Map<String, dynamic> json) => _$InviteLinkDtoFromJson(json);
}

@freezed
abstract class InviteLinkInfoDto with _$InviteLinkInfoDto {
  const factory InviteLinkInfoDto({
    required String token,
    required int groupId,
    required String groupName,
    required int memberCount,
    required bool valid,
    String? expiresAt,
    required int createdBy,
    required String createdByUsername,
    required String createdByFullName,
    int? maxUses,
    @Default(0) int usesCount,
    @Default(false) bool revoked,
    String? groupAvatar,
  }) = _InviteLinkInfoDto;

  factory InviteLinkInfoDto.fromJson(Map<String, dynamic> json) => _$InviteLinkInfoDtoFromJson(json);
}

@freezed
abstract class JoinGroupResponseDto with _$JoinGroupResponseDto {
  const factory JoinGroupResponseDto({
    required bool success,
    required int conversationId,
    required String message,
    String? groupName,
  }) = _JoinGroupResponseDto;

  factory JoinGroupResponseDto.fromJson(Map<String, dynamic> json) => _$JoinGroupResponseDtoFromJson(json);
}
