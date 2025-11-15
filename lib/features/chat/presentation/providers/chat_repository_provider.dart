import 'package:chattrix_ui/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chattrix_ui/features/chat/data/repositories/user_status_repository_impl.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_datasource_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDatasource = ref.watch(chatRemoteDatasourceProvider);
  return ChatRepositoryImpl(remoteDatasource: remoteDatasource);
});

final userStatusRepositoryProvider = Provider<UserStatusRepository>((ref) {
  final remoteDatasource = ref.watch(chatRemoteDatasourceProvider);
  return UserStatusRepositoryImpl(remoteDatasource: remoteDatasource);
});
