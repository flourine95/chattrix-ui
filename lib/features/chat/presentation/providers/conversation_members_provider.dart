import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final conversationMembersProvider = FutureProvider.family<List<SearchUser>, String>((ref, conversationId) async {
  final usecase = ref.watch(getConversationMembersUsecaseProvider);
  final result = await usecase(conversationId: conversationId);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (members) => members,
  );
});

