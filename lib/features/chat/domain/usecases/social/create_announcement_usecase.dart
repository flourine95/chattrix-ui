import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import '../../entities/message.dart';
import '../../repositories/social_repository.dart';

/// Use case for creating an announcement
class CreateAnnouncementUseCase {
  final SocialRepository _repository;

  CreateAnnouncementUseCase(this._repository);

  Future<Either<Failure, Message>> call({required int conversationId, required String content}) async {
    // Validation
    if (content.trim().isEmpty) {
      return left(const Failure.validation(message: 'Announcement content cannot be empty', code: 'INVALID_CONTENT'));
    }

    return await _repository.createAnnouncement(conversationId: conversationId, content: content);
  }
}
