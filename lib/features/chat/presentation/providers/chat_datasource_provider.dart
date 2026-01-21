import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRemoteDatasourceProvider = Provider<ChatRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDatasourceImpl(dio: dio);
});

// Provider for implementation (needed for new list methods not in interface)
final chatRemoteDatasourceImplProvider = Provider<ChatRemoteDatasourceImpl>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDatasourceImpl(dio: dio);
});
