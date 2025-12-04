import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/call/data/repositories/call_repository_impl.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_remote_datasource.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final callRemoteDataSourceProvider = Provider<CallRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return CallRemoteDataSourceImpl(dio: dio);
});

final callRepositoryProvider = Provider<CallRepository>((ref) {
  final remoteDataSource = ref.watch(callRemoteDataSourceProvider);
  return CallRepositoryImpl(remoteDataSource: remoteDataSource);
});
