import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetConversationsUsecase {
  final ChatRepository repository;

  GetConversationsUsecase(this.repository);

  Future<Either<Failure, List<Conversation>>> call({ConversationFilter filter = ConversationFilter.all}) {
    return repository.getConversations(filter: filter);
  }
}
