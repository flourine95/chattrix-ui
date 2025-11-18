import 'package:chattrix_ui/core/network/auth_interceptor.dart';
import 'package:chattrix_ui/core/network/dio_client.dart';
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

/// Secure storage provider - singleton
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

/// Dio client with auth interceptor
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = DioClient.createDio();
  final secureStorage = ref.watch(secureStorageProvider);

  // Add auth interceptor for automatic token management
  dio.interceptors.add(AuthInterceptor(dio: dio, secureStorage: secureStorage));

  return dio;
}

/// Auth remote data source provider
@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider));
}

/// Auth local data source provider
@Riverpod(keepAlive: true)
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSourceImpl(secureStorage: ref.watch(secureStorageProvider));
}

/// Main auth repository provider
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}
