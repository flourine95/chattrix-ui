import 'package:chattrix_ui/features/chat/data/models/invite_link_model.dart';

abstract class InviteLinkDatasource {
  Future<InviteLinkModel> createInviteLink({required int conversationId, required CreateInviteLinkRequest request});

  Future<List<InviteLinkModel>> getInviteLinks({required int conversationId});

  Future<InviteLinkModel> revokeInviteLink({required int conversationId, required int linkId});

  Future<InviteLinkInfoModel> getInviteLinkInfo({required String token});

  Future<JoinViaInviteLinkResponse> joinViaInviteLink({required String token});

  Future<List<int>> getQrCode({required int conversationId, required int linkId, String? apiUrl});
}
