import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:chattrix_ui/features/call/data/datasources/call_websocket_datasource_impl.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_websocket_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final callWebSocketDataSourceProvider = Provider<CallWebSocketDataSource>((ref) {
  final webSocketService = ref.watch(webSocketServiceProvider);

  final dataSource = CallWebSocketDataSourceImpl(
    webSocketService: webSocketService,
  );

  ref.onDispose(() {
    dataSource.dispose();
  });

  return dataSource;
});

