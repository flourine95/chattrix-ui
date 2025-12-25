import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_link_entity.freezed.dart';

@freezed
abstract class InviteLinkEntity with _$InviteLinkEntity {
  const factory InviteLinkEntity({
    required int id,
    required String token,
    required int conversationId,
    required int createdBy,
    required String createdByUsername,
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

  String get inviteUrl => 'https://chattrix.app/invite/$token';

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
