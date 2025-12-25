import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/invite_link_datasource_impl.dart';
import '../../data/repositories/invite_link_repository_impl.dart';
import '../../domain/datasources/invite_link_datasource.dart';
import '../../domain/repositories/invite_link_repository.dart';
import '../../domain/usecases/invite_link/create_invite_link_usecase.dart';
import '../../domain/usecases/invite_link/get_invite_links_usecase.dart';
import '../../domain/usecases/invite_link/revoke_invite_link_usecase.dart';
import '../../domain/usecases/invite_link/get_invite_link_info_usecase.dart';
import '../../domain/usecases/invite_link/join_via_invite_link_usecase.dart';
import '../../domain/usecases/invite_link/get_qr_code_usecase.dart';

part 'invite_link_providers.g.dart';

// Datasource Provider
@riverpod
InviteLinkDatasource inviteLinkDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return InviteLinkDatasourceImpl(dio: dio);
}

// Repository Provider
@riverpod
InviteLinkRepository inviteLinkRepository(Ref ref) {
  final datasource = ref.watch(inviteLinkDatasourceProvider);
  return InviteLinkRepositoryImpl(datasource);
}

// Use Case Providers
@riverpod
CreateInviteLinkUseCase createInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return CreateInviteLinkUseCase(repository);
}

@riverpod
GetInviteLinksUseCase getInviteLinksUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return GetInviteLinksUseCase(repository);
}

@riverpod
RevokeInviteLinkUseCase revokeInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return RevokeInviteLinkUseCase(repository);
}

@riverpod
GetInviteLinkInfoUseCase getInviteLinkInfoUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return GetInviteLinkInfoUseCase(repository);
}

@riverpod
JoinViaInviteLinkUseCase joinViaInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return JoinViaInviteLinkUseCase(repository);
}

@riverpod
GetQrCodeUseCase getQrCodeUseCase(Ref ref) {
  final repository = ref.watch(inviteLinkRepositoryProvider);
  return GetQrCodeUseCase(repository);
}
