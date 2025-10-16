import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_remote_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status.dart';
import 'package:chattrix_ui/features/chat/domain/repositories/user_status_repository.dart';
import 'package:dartz/dartz.dart';

class UserStatusRepositoryImpl implements UserStatusRepository {
  final ChatRemoteDatasource remoteDatasource;

  UserStatusRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<User>>> getOnlineUsers() async {
    try {
      final models = await remoteDatasource.getOnlineUsers();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch online users'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getOnlineUsersInConversation(
    String conversationId,
  ) async {
    try {
      final models = await remoteDatasource.getOnlineUsersInConversation(
        conversationId,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to fetch online users in conversation'),
      );
    }
  }

  @override
  Future<Either<Failure, UserStatus>> getUserStatus(String userId) async {
    try {
      final model = await remoteDatasource.getUserStatus(userId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch user status'));
    }
  }
}
