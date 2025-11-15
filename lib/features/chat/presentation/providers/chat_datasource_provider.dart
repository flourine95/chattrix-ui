import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/datasources/chat_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatRemoteDatasourceProvider = Provider<ChatRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDatasourceImpl(dio: dio);
});
