import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateConversationUsecase {
  final ChatRepository repository;

  CreateConversationUsecase(this.repository);

  Future<Either<Failure, Conversation>> call({
    String? name,
    required String type,
    required List<String> participantIds,
  }) async {
    // Validate conversation type
    final normalizedType = type.toUpperCase();
    if (normalizedType != 'DIRECT' && normalizedType != 'GROUP') {
      return left(
        const Failure.validation(message: 'Invalid conversation type. Must be DIRECT or GROUP', code: 'INVALID_TYPE'),
      );
    }

    // Validate DIRECT conversation: exactly 2 participants (including current user)
    if (normalizedType == 'DIRECT') {
      if (participantIds.length != 2) {
        return left(
          const Failure.validation(
            message: 'DIRECT conversation must have exactly 2 participants',
            code: 'INVALID_PARTICIPANT_COUNT',
          ),
        );
      }
    }

    // Validate GROUP conversation: at least 2 participants (including current user)
    if (normalizedType == 'GROUP') {
      if (participantIds.length < 2) {
        return left(
          const Failure.validation(
            message: 'GROUP conversation must have at least 2 participants',
            code: 'INVALID_PARTICIPANT_COUNT',
          ),
        );
      }

      // Validate group name is provided
      if (name == null || name.trim().isEmpty) {
        return left(
          const Failure.validation(message: 'GROUP conversation must have a name', code: 'MISSING_GROUP_NAME'),
        );
      }
    }

    // Call repository to create conversation
    // The API will handle duplicate conversation check and return existing conversation if found
    return repository.createConversation(name: name, type: normalizedType, participantIds: participantIds);
  }
}
