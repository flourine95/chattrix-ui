import 'package:chattrix_ui/features/invite_links/data/models/invite_link_dto.dart';
import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';

extension InviteLinkDtoMapper on InviteLinkDto {
  InviteLinkEntity toEntity() {
    return InviteLinkEntity(
      id: id,
      token: token,
      conversationId: conversationId,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdAt: DateTime.parse(createdAt),
      expiresAt: expiresAt != null ? DateTime.parse(expiresAt!) : null,
      maxUses: maxUses,
      currentUses: currentUses,
      revoked: revoked,
      revokedAt: revokedAt != null ? DateTime.parse(revokedAt!) : null,
      revokedBy: revokedBy,
      valid: valid,
    );
  }
}

extension InviteLinkInfoDtoMapper on InviteLinkInfoDto {
  InviteLinkInfoEntity toEntity() {
    return InviteLinkInfoEntity(
      token: token,
      groupId: groupId,
      groupName: groupName,
      memberCount: memberCount,
      valid: valid,
      expiresAt: expiresAt != null ? DateTime.parse(expiresAt!) : null,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdByFullName: createdByFullName,
      maxUses: maxUses,
      usesCount: usesCount,
      revoked: revoked,
      groupAvatar: groupAvatar,
    );
  }
}

extension JoinGroupResponseDtoMapper on JoinGroupResponseDto {
  JoinGroupResultEntity toEntity() {
    return JoinGroupResultEntity(
      success: success,
      conversationId: conversationId,
      message: message,
      groupName: groupName,
    );
  }
}
