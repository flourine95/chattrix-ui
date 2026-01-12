import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/core/repositories/base_repository.dart';
import 'package:chattrix_ui/features/auth/data/mappers/user_mapper.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserStatusRepositoryImpl extends BaseRepository implements UserStatusRepository {
  final ChatRemoteDatasource remoteDatasource;

  UserStatusRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<User>>> getOnlineUsers() async {
    return executeApiCall(() async {
      final models = await remoteDatasource.getOnlineUsers();
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<User>>> getOnlineUsersInConversation(String conversationId) async {
    return executeApiCall(() async {
      final models = await remoteDatasource.getOnlineUsersInConversation(conversationId);
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, UserStatus>> getUserStatus(String userId) async {
    return executeApiCall(() async {
      final model = await remoteDatasource.getUserStatus(userId);
      return model.toEntity();
    });
  }
}
