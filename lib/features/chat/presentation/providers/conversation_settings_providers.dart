import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../data/datasources/conversation_settings_datasource_impl.dart';
import '../../data/repositories/conversation_settings_repository_impl.dart';
import '../../domain/datasources/conversation_settings_datasource.dart';
import '../../domain/repositories/conversation_settings_repository.dart';
import '../../domain/usecases/conversation_settings/get_conversation_settings_usecase.dart';
import '../../domain/usecases/conversation_settings/update_conversation_settings_usecase.dart';
import '../../domain/usecases/conversation_settings/mute_conversation_usecase.dart';
import '../../domain/usecases/conversation_settings/unmute_conversation_usecase.dart';
import '../../domain/usecases/conversation_settings/update_permissions_usecase.dart';

part 'conversation_settings_providers.g.dart';

// Datasource Provider
@riverpod
ConversationSettingsDatasource conversationSettingsDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ConversationSettingsDatasourceImpl(dio: dio);
}

// Repository Provider
@riverpod
ConversationSettingsRepository conversationSettingsRepository(Ref ref) {
  final datasource = ref.watch(conversationSettingsDatasourceProvider);
  return ConversationSettingsRepositoryImpl(datasource);
}

// Use Case Providers
@riverpod
GetConversationSettingsUseCase getConversationSettingsUseCase(Ref ref) {
  final repository = ref.watch(conversationSettingsRepositoryProvider);
  return GetConversationSettingsUseCase(repository);
}

@riverpod
UpdateConversationSettingsUseCase updateConversationSettingsUseCase(Ref ref) {
  final repository = ref.watch(conversationSettingsRepositoryProvider);
  return UpdateConversationSettingsUseCase(repository);
}

@riverpod
MuteConversationUseCase muteConversationUseCase(Ref ref) {
  final repository = ref.watch(conversationSettingsRepositoryProvider);
  return MuteConversationUseCase(repository);
}

@riverpod
UnmuteConversationUseCase unmuteConversationUseCase(Ref ref) {
  final repository = ref.watch(conversationSettingsRepositoryProvider);
  return UnmuteConversationUseCase(repository);
}

@riverpod
UpdatePermissionsUseCase updatePermissionsUseCase(Ref ref) {
  final repository = ref.watch(conversationSettingsRepositoryProvider);
  return UpdatePermissionsUseCase(repository);
}
