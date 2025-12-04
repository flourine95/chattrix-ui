import 'package:chattrix_ui/core/network/auth_interceptor.dart';
import 'package:chattrix_ui/core/network/dio_client.dart';
import 'package:chattrix_ui/core/services/token_cache_service.dart';
import 'package:chattrix_ui/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/datasources/auth_remote_datasource.dart';
import 'package:chattrix_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(),

    webOptions: WebOptions(
      dbName: 'ChattrixDB',
    ),

    wOptions: WindowsOptions(
      useBackwardCompatibility: false,
    ),
  );
}

/// Token cache service provider - singleton
@Riverpod(keepAlive: true)
TokenCacheService tokenCacheService(Ref ref) {
  return TokenCacheService(ref.watch(secureStorageProvider));
}

/// Dio client with auth interceptor
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = DioClient.createDio();
  final tokenCache = ref.watch(tokenCacheServiceProvider);

  dio.interceptors.add(AuthInterceptor(dio: dio, tokenCacheService: tokenCache));

  return dio;
}

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSourceImpl(tokenCacheService: ref.watch(tokenCacheServiceProvider));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}