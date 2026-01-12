import '../models/invite_link_model.dart';
import '../../domain/entities/invite_link.dart';

extension InviteLinkModelMapper on InviteLinkModel {
  InviteLink toEntity() {
    return InviteLink(
      id: id,
      token: token,
      conversationId: conversationId,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdAt: createdAt,
      maxUses: maxUses,
      currentUses: currentUses,
      revoked: revoked,
      revokedAt: revokedAt,
      revokedBy: revokedBy,
      valid: valid,
    );
  }
}

extension InviteLinkInfoModelMapper on InviteLinkInfoModel {
  InviteLinkInfo toEntity() {
    return InviteLinkInfo(
      token: token,
      groupId: groupId,
      memberCount: memberCount,
      valid: valid,
      createdBy: createdBy,
      createdByUsername: createdByUsername,
      createdByFullName: createdByFullName,
    );
  }
}

extension JoinViaInviteLinkResponseMapper on JoinViaInviteLinkResponse {
  JoinViaInviteLink toEntity() {
    return JoinViaInviteLink(success: success, conversationId: conversationId, message: message);
  }
}
