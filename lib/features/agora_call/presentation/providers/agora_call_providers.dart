import 'package:chattrix_ui/features/agora_call/data/datasources/agora_call_remote_datasource.dart';
import 'package:chattrix_ui/features/agora_call/data/repositories/agora_call_repository_impl.dart';
import 'package:chattrix_ui/features/agora_call/data/services/agora_engine_service.dart';
import 'package:chattrix_ui/features/agora_call/data/services/call_security_service.dart';
import 'package:chattrix_ui/features/agora_call/data/services/permission_service.dart';
import 'package:chattrix_ui/features/agora_call/data/services/ringtone_service.dart';
import 'package:chattrix_ui/features/agora_call/domain/repositories/agora_call_repository.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Export call state provider for easy access
export 'call_state_provider.dart';
export 'call_controls_provider.dart';

part 'agora_call_providers.g.dart';

/// Dio client provider for Agora call API communication
///
/// Reuses the authenticated Dio instance from auth providers
@Riverpod(keepAlive: true)
Dio agoraCallDio(Ref ref) {
  return ref.watch(dioProvider);
}

/// Remote data source provider for Agora call API
///
/// Handles all HTTP communication with the backend call API
@Riverpod(keepAlive: true)
AgoraCallRemoteDataSource agoraCallRemoteDataSource(Ref ref) {
  return AgoraCallRemoteDataSource(dio: ref.watch(agoraCallDioProvider));
}

/// Repository provider for Agora call operations
///
/// Implements the domain repository interface and handles error mapping
@Riverpod(keepAlive: true)
AgoraCallRepository agoraCallRepository(Ref ref) {
  return AgoraCallRepositoryImpl(remoteDataSource: ref.watch(agoraCallRemoteDataSourceProvider));
}

/// Agora RTC Engine service provider
///
/// Manages the Agora SDK instance for real-time audio/video communication
/// Automatically initializes with the App ID from environment variables
/// Disposes the engine when the provider is disposed
@Riverpod(keepAlive: true)
AgoraEngineService agoraEngineService(Ref ref) {
  final service = AgoraEngineService();

  // Initialize with Agora App ID from environment
  final appId = dotenv.env['AGORA_APP_ID'];
  if (appId == null || appId.isEmpty) {
    throw Exception('AGORA_APP_ID not found in environment variables');
  }

  // Initialize asynchronously (fire and forget)
  // The service will be ready when needed
  service.initialize(appId);

  // Dispose the engine when the provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}

/// Ringtone service provider
///
/// Manages ringtone playback for incoming calls
/// Automatically disposes the audio player when the provider is disposed
@Riverpod(keepAlive: true)
RingtoneService ringtoneService(Ref ref) {
  final service = RingtoneService();

  // Dispose the service when the provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}

/// Permission service provider
///
/// Manages camera and microphone permissions for calls
/// Handles permission requests and checks based on call type
@Riverpod(keepAlive: true)
PermissionService permissionService(Ref ref) {
  return PermissionService();
}

/// Call security service provider
///
/// Manages security measures for calls including:
/// - Token lifecycle management
/// - Secure protocol verification
/// - Sensitive data cleanup
///
/// Requirements: 10.1, 10.2, 10.3, 10.5
@Riverpod(keepAlive: true)
CallSecurityService callSecurityService(Ref ref) {
  final service = CallSecurityService();

  // Dispose the service when the provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}
