import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_local_datasource_impl.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/data/repositories/call_repository_impl.dart';
import 'package:chattrix_ui/features/call/data/services/agora_service.dart';
import 'package:chattrix_ui/features/call/data/services/call_signaling_service.dart';
import 'package:chattrix_ui/features/call/data/services/permission_service.dart';
import 'package:chattrix_ui/features/call/data/services/token_service.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_repository_provider.g.dart';

/// Agora Service provider - singleton
@Riverpod(keepAlive: true)
AgoraService agoraService(Ref ref) {
  return AgoraService();
}

/// Token Service provider
@Riverpod(keepAlive: true)
TokenService tokenService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return TokenService(dio: dio);
}

/// Permission Service provider
@Riverpod(keepAlive: true)
PermissionService permissionService(Ref ref) {
  return PermissionService();
}

/// Call Local Data Source provider
@Riverpod(keepAlive: true)
CallLocalDataSourceImpl callLocalDataSource(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return CallLocalDataSourceImpl(secureStorage: secureStorage);
}

/// Call Remote Data Source provider
@Riverpod(keepAlive: true)
CallRemoteDataSource callRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CallRemoteDataSource(dio: dio);
}

/// Call Signaling Service provider
@Riverpod(keepAlive: true)
CallSignalingService callSignalingService(Ref ref) {
  final webSocketService = ref.watch(chatWebSocketServiceProvider);
  return CallSignalingService(webSocketService: webSocketService);
}

/// Main Call Repository provider
@Riverpod(keepAlive: true)
CallRepository callRepository(Ref ref) {
  return CallRepositoryImpl(
    agoraService: ref.watch(agoraServiceProvider),
    localDataSource: ref.watch(callLocalDataSourceProvider),
    remoteDataSource: ref.watch(callRemoteDataSourceProvider),
    tokenService: ref.watch(tokenServiceProvider),
    permissionService: ref.watch(permissionServiceProvider),
    signalingService: ref.watch(callSignalingServiceProvider),
  );
}
