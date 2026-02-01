import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link_entity.freezed.dart';

@freezed
abstract class InviteLinkEntity with _$InviteLinkEntity {
  const factory InviteLinkEntity({
    required int id,
    required String token,
    String? link,  // Full URL from backend
    required int conversationId,
    required int createdBy,
    String? createdByUsername,  // Made nullable to match backend response
    required DateTime createdAt,
    DateTime? expiresAt,
    int? maxUses,
    required int currentUses,
    required bool revoked,
    DateTime? revokedAt,
    int? revokedBy,
    required bool valid,
  }) = _InviteLinkEntity;

  const InviteLinkEntity._();

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isMaxUsesReached {
    if (maxUses == null) return false;
    return currentUses >= maxUses!;
  }

  // Use backend URL if available, otherwise fallback to localhost
  String get inviteUrl => link ?? 'http://localhost:8080/api/v1/invite/$token';

  String get deepLinkUrl => 'chattrix://invite/$token';
}

@freezed
abstract class InviteLinkInfoEntity with _$InviteLinkInfoEntity {
  const factory InviteLinkInfoEntity({
    required String token,
    required int groupId,
    required String groupName,
    required int memberCount,
    required bool valid,
    DateTime? expiresAt,
    required int createdBy,
    required String createdByUsername,
    required String createdByFullName,
    int? maxUses,
    @Default(0) int usesCount,
    @Default(false) bool revoked,
    String? groupAvatar,
  }) = _InviteLinkInfoEntity;

  const InviteLinkInfoEntity._();

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isMaxUsesReached {
    if (maxUses == null) return false;
    return usesCount >= maxUses!;
  }

  bool get isValid => valid && !isExpired && !isMaxUsesReached && !revoked;

  String get creatorName => createdByFullName.isNotEmpty ? createdByFullName : createdByUsername;

  DateTime get createdAt => DateTime.now();
}

@freezed
abstract class JoinGroupResultEntity with _$JoinGroupResultEntity {
  const factory JoinGroupResultEntity({
    required bool success,
    required int conversationId,
    required String message,
    String? groupName,
  }) = _JoinGroupResultEntity;
}

/// User info in history
@freezed
abstract class InviteLinkUserEntity with _$InviteLinkUserEntity {
  const factory InviteLinkUserEntity({
    required int id,
    required String username,
    required String fullName,
    String? avatarUrl,
    DateTime? lastSeen,
  }) = _InviteLinkUserEntity;
}

/// Single link in history
@freezed
abstract class InviteLinkHistoryItemEntity with _$InviteLinkHistoryItemEntity {
  const factory InviteLinkHistoryItemEntity({
    required String token,
    String? link,  // Full URL from backend
    required InviteLinkUserEntity createdBy,
    required DateTime createdAt,
    required int maxUses,
    required int currentUses,
    required bool isActive,
    required bool isRevoked,
    required bool isExpired,
    required String status,
  }) = _InviteLinkHistoryItemEntity;

  const InviteLinkHistoryItemEntity._();

  // Use backend URL if available, otherwise fallback to localhost
  String get inviteUrl => link ?? 'http://localhost:8080/api/v1/invite/$token';

  String get deepLinkUrl => 'chattrix://invite/$token';

  bool get canUse => isActive && !isExpired && !isRevoked && (maxUses == 0 || currentUses < maxUses);
}

/// Pagination metadata with cursor
@freezed
abstract class InviteLinksMetaEntity with _$InviteLinksMetaEntity {
  const factory InviteLinksMetaEntity({
    String? nextCursor,
    required bool hasNextPage,
    required int itemsPerPage,
  }) = _InviteLinksMetaEntity;
}

/// History response with cursor-based pagination
@freezed
abstract class InviteLinksHistoryEntity with _$InviteLinksHistoryEntity {
  const factory InviteLinksHistoryEntity({
    required List<InviteLinkHistoryItemEntity> items,
    required InviteLinksMetaEntity meta,
  }) = _InviteLinksHistoryEntity;
}
