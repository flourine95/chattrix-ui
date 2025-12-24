import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/remote/invite_links_api_service.dart';
import '../../data/repositories/invite_links_repository_impl.dart';
import '../../domain/repositories/invite_links_repository.dart';
import '../../domain/usecases/create_invite_link_usecase.dart';
import '../../domain/usecases/get_invite_links_usecase.dart';
import '../../domain/usecases/revoke_invite_link_usecase.dart';
import '../../domain/usecases/get_qr_code_usecase.dart';
import '../../domain/usecases/get_invite_link_info_usecase.dart';
import '../../domain/usecases/join_group_via_link_usecase.dart';

part 'invite_links_providers.g.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// API Service Provider
@Riverpod(keepAlive: true)
InviteLinksApiService inviteLinksApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return InviteLinksApiService(dio);
}

/// Repository Provider
@Riverpod(keepAlive: true)
InviteLinksRepository inviteLinksRepository(Ref ref) {
  final apiService = ref.watch(inviteLinksApiServiceProvider);
  return InviteLinksRepositoryImpl(apiService);
}

// ============================================================================
// Use Case Providers
// ============================================================================

/// Create Invite Link Use Case
@riverpod
CreateInviteLinkUseCase createInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return CreateInviteLinkUseCase(repository);
}

/// Get Invite Links Use Case
@riverpod
GetInviteLinksUseCase getInviteLinksUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetInviteLinksUseCase(repository);
}

/// Revoke Invite Link Use Case
@riverpod
RevokeInviteLinkUseCase revokeInviteLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return RevokeInviteLinkUseCase(repository);
}

/// Get QR Code Use Case
@riverpod
GetQRCodeUseCase getQRCodeUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetQRCodeUseCase(repository);
}

/// Get Invite Link Info Use Case
@riverpod
GetInviteLinkInfoUseCase getInviteLinkInfoUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return GetInviteLinkInfoUseCase(repository);
}

/// Join Group Via Link Use Case
@riverpod
JoinGroupViaLinkUseCase joinGroupViaLinkUseCase(Ref ref) {
  final repository = ref.watch(inviteLinksRepositoryProvider);
  return JoinGroupViaLinkUseCase(repository);
}
