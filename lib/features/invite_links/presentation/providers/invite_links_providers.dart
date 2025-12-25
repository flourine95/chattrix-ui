import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/invite_links/data/datasources/remote/invite_links_api_service.dart';
import 'package:chattrix_ui/features/invite_links/data/repositories/invite_links_repository_impl.dart';
import 'package:chattrix_ui/features/invite_links/domain/repositories/invite_links_repository.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/create_invite_link_usecase.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/get_invite_link_info_usecase.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/get_invite_links_usecase.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/get_qr_code_usecase.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/join_group_via_link_usecase.dart';
import 'package:chattrix_ui/features/invite_links/domain/usecases/revoke_invite_link_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invite_links_providers.g.dart';

@Riverpod(keepAlive: true)
InviteLinksApiService inviteLinksApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return InviteLinksApiService(dio);
}

@Riverpod(keepAlive: true)
InviteLinksRepository inviteLinksRepository(Ref ref) {
  final apiService = ref.watch(inviteLinksApiServiceProvider);
  return InviteLinksRepositoryImpl(apiService);
}

@riverpod
CreateInviteLinkUseCase createInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return CreateInviteLinkUseCase(repository);
}

@riverpod
GetInviteLinksUseCase getInviteLinksUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetInviteLinksUseCase(repository);
}

@riverpod
RevokeInviteLinkUseCase revokeInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return RevokeInviteLinkUseCase(repository);
}

@riverpod
GetQRCodeUseCase getQRCodeUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetQRCodeUseCase(repository);
}

@riverpod
GetInviteLinkInfoUseCase getInviteLinkInfoUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetInviteLinkInfoUseCase(repository);
}

@riverpod
JoinGroupViaLinkUseCase joinGroupViaLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return JoinGroupViaLinkUseCase(repository);
}
