import 'package:chattrix_ui/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/edit_message_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversation_members_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversation_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_online_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/get_user_status_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/mark_conversation_as_read_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/search_messages_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/search_users_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chattrix_ui/features/chat/domain/usecases/toggle_reaction_usecase.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createConversationUsecaseProvider = Provider<CreateConversationUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return CreateConversationUsecase(repository);
});

final getConversationsUsecaseProvider = Provider<GetConversationsUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationsUsecase(repository);
});

final getConversationUsecaseProvider = Provider<GetConversationUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationUsecase(repository);
});

final getMessagesUsecaseProvider = Provider<GetMessagesUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetMessagesUsecase(repository);
});

final sendMessageUsecaseProvider = Provider<SendMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessageUsecase(repository);
});

final editMessageUsecaseProvider = Provider<EditMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return EditMessageUsecase(repository: repository);
});

final deleteMessageUsecaseProvider = Provider<DeleteMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return DeleteMessageUsecase(repository: repository);
});

final getOnlineUsersUsecaseProvider = Provider<GetOnlineUsersUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetOnlineUsersUsecase(repository);
});

final getUserStatusUsecaseProvider = Provider<GetUserStatusUsecase>((ref) {
  final repository = ref.watch(userStatusRepositoryProvider);
  return GetUserStatusUsecase(repository);
});

final searchUsersUsecaseProvider = Provider<SearchUsersUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SearchUsersUsecase(repository);
});

final toggleReactionUsecaseProvider = Provider<ToggleReactionUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ToggleReactionUsecase(repository);
});

final markConversationAsReadUsecaseProvider = Provider<MarkConversationAsReadUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return MarkConversationAsReadUseCase(repository);
});

final getConversationMembersUsecaseProvider = Provider<GetConversationMembersUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetConversationMembersUseCase(repository);
});

final searchMessagesUsecaseProvider = Provider<SearchMessagesUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SearchMessagesUseCase(repository);
});
