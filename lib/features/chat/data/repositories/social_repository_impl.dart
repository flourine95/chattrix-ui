import 'package:fpdart/fpdart.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/chat/domain/entities/birthday.dart';
import 'package:chattrix_ui/features/chat/domain/entities/mutual_group.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/social_repository.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/social_datasource.dart';
import 'package:chattrix_ui/features/chat/data/models/birthday_model.dart';
import 'package:chattrix_ui/features/chat/data/models/announcement_request.dart';

class SocialRepositoryImpl extends BaseRepository implements SocialRepository {
  final SocialDatasource _datasource;

  SocialRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<Birthday>>> getBirthdaysToday() async {
    return executeApiCall(() async {
      final models = await _datasource.getBirthdaysToday();
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, SendBirthdayWishes>> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    return executeApiCall(() async {
      final request = SendBirthdayWishesRequest(
        userId: userId,
        conversationIds: conversationIds,
        customMessage: customMessage,
      );
      final response = await _datasource.sendBirthdayWishes(request: request);
      // The datasource returns Map<String, dynamic>, convert to entity
      return SendBirthdayWishes(
        userId: response['userId'] as int,
        conversationIds: (response['conversationIds'] as List).cast<int>(),
        customMessage: response['customMessage'] as String?,
        sentAt: DateTime.parse(response['sentAt'] as String),
      );
    });
  }

  @override
  Future<Either<Failure, Message>> createAnnouncement({required int conversationId, required String content}) async {
    return executeApiCall(() async {
      final request = CreateAnnouncementRequest(content: content);
      final model = await _datasource.createAnnouncement(conversationId: conversationId, request: request);
      // Convert announcement model to message entity
      return Message(
        id: model.id,
        conversationId: model.conversationId,
        senderId: model.senderId,
        senderUsername: model.senderUsername,
        senderFullName: model.senderFullName,
        content: model.content,
        type: model.type,
        reactions: model.reactions,
        sentAt: DateTime.parse(model.sentAt),
        createdAt: DateTime.parse(model.createdAt),
        updatedAt: model.updatedAt != null ? DateTime.parse(model.updatedAt!) : null,
        edited: model.edited,
        deleted: model.deleted,
        forwarded: model.forwarded,
        forwardCount: model.forwardCount,
        scheduled: model.scheduled,
      );
    });
  }

  @override
  Future<Either<Failure, List<MutualGroup>>> getMutualGroups({required int userId}) async {
    return executeApiCall(() async {
      final models = await _datasource.getMutualGroups(userId: userId);
      return models.map((model) => model.toEntity()).toList();
    });
  }
}
