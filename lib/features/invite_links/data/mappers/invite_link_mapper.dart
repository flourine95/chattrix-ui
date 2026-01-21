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

extension InviteLinkUserDtoMapper on InviteLinkUserDto {
  InviteLinkUserEntity toEntity() {
    return InviteLinkUserEntity(
      id: id,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
    );
  }
}

extension InviteLinkHistoryItemDtoMapper on InviteLinkHistoryItemDto {
  InviteLinkHistoryItemEntity toEntity() {
    return InviteLinkHistoryItemEntity(
      token: token,
      createdBy: createdBy.toEntity(),
      createdAt: DateTime.parse(createdAt),
      maxUses: maxUses,
      currentUses: currentUses,
      isActive: isActive,
      isRevoked: isRevoked,
      isExpired: isExpired,
      status: status,
    );
  }
}

extension InviteLinksMetaDtoMapper on InviteLinksMetaDto {
  InviteLinksMetaEntity toEntity() {
    return InviteLinksMetaEntity(
      nextCursor: nextCursor,
      hasNextPage: hasNextPage,
      itemsPerPage: itemsPerPage,
    );
  }
}

extension InviteLinksHistoryDtoMapper on InviteLinksHistoryDto {
  InviteLinksHistoryEntity toEntity() {
    return InviteLinksHistoryEntity(
      items: items.map((item) => item.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }
}
