import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/contacts/domain/datasources/contact_remote_datasource.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:chattrix_ui/features/contacts/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;
  final int currentUserId;

  ContactRepositoryImpl({
    required this.remoteDataSource,
    required this.currentUserId,
  });

  @override
  Future<Either<Failure, FriendRequest>> sendFriendRequest({required int receiverUserId, String? nickname}) async {
    try {
      final result = await remoteDataSource.sendFriendRequest(receiverUserId: receiverUserId, nickname: nickname);
      return Right(result.toEntityAsSent(currentUserId));
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendRequest>>> getReceivedFriendRequests() async {
    try {
      final result = await remoteDataSource.getReceivedFriendRequests();
      return Right(result.map((model) => model.toEntityAsReceived(currentUserId)).toList());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FriendRequest>>> getSentFriendRequests() async {
    try {
      final result = await remoteDataSource.getSentFriendRequests();
      return Right(result.map((model) => model.toEntityAsSent(currentUserId)).toList());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest({required int friendRequestId}) async {
    try {
      await remoteDataSource.acceptFriendRequest(friendRequestId: friendRequestId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rejectFriendRequest({required int friendRequestId}) async {
    try {
      await remoteDataSource.rejectFriendRequest(friendRequestId: friendRequestId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest({required int friendRequestId}) async {
    try {
      await remoteDataSource.cancelFriendRequest(friendRequestId: friendRequestId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final result = await remoteDataSource.getContacts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact>> getContactById(int contactId) async {
    try {
      final result = await remoteDataSource.getContactById(contactId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateContactNickname({required int contactId, required String nickname}) async {
    try {
      await remoteDataSource.updateContactNickname(contactId: contactId, nickname: nickname);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContact({required int contactId}) async {
    try {
      await remoteDataSource.deleteContact(contactId: contactId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  Failure _mapServerExceptionToFailure(ServerException exception) {
    switch (exception.statusCode) {
      case 400:
        return Failure.badRequest(message: exception.message);
      case 401:
        return Failure.unauthorized(message: exception.message);
      case 403:
        return Failure.forbidden(message: exception.message);
      case 404:
        return Failure.notFound(message: exception.message);
      case 409:
        return Failure.conflict(message: exception.message);
      case 422:
        return Failure.validation(message: exception.message);
      case 500:
        return Failure.server(message: exception.message);
      default:
        return Failure.server(message: exception.message);
    }
  }
}
