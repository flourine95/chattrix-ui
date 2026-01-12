import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/friend_request.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_datasource_impl.dart';

class ContactRepositoryImpl extends BaseRepository implements ContactRepository {
  final ContactRemoteDataSourceImpl _remoteDataSource;
  final int _currentUserId;

  ContactRepositoryImpl({required ContactRemoteDataSourceImpl remoteDataSource, required int currentUserId})
    : _remoteDataSource = remoteDataSource,
      _currentUserId = currentUserId;

  @override
  Future<Either<Failure, FriendRequest>> sendFriendRequest({required int receiverUserId, String? nickname}) async {
    return executeApiCall(() async {
      final result = await _remoteDataSource.sendFriendRequest(receiverUserId: receiverUserId, nickname: nickname);
      return result.toEntityAsSent(_currentUserId);
    });
  }

  @override
  Future<Either<Failure, List<FriendRequest>>> getReceivedFriendRequests() async {
    return executeApiCall(() async {
      final result = await _remoteDataSource.getReceivedFriendRequests();
      return result.map((model) => model.toEntityAsReceived(_currentUserId)).toList();
    });
  }

  @override
  Future<Either<Failure, List<FriendRequest>>> getSentFriendRequests() async {
    return executeApiCall(() async {
      final result = await _remoteDataSource.getSentFriendRequests();
      return result.map((model) => model.toEntityAsSent(_currentUserId)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest({required int friendRequestId}) async {
    return executeApiCall(() async {
      await _remoteDataSource.acceptFriendRequest(friendRequestId: friendRequestId);
    });
  }

  @override
  Future<Either<Failure, void>> rejectFriendRequest({required int friendRequestId}) async {
    return executeApiCall(() async {
      await _remoteDataSource.rejectFriendRequest(friendRequestId: friendRequestId);
    });
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest({required int friendRequestId}) async {
    return executeApiCall(() async {
      await _remoteDataSource.cancelFriendRequest(friendRequestId: friendRequestId);
    });
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    return executeApiCall(() async {
      final result = await _remoteDataSource.getContacts();
      return result.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Contact>> getContactById(int contactId) async {
    return executeApiCall(() async {
      final result = await _remoteDataSource.getContactById(contactId);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> updateContactNickname({required int contactId, required String nickname}) async {
    return executeApiCall(() async {
      await _remoteDataSource.updateContactNickname(contactId: contactId, nickname: nickname);
    });
  }

  @override
  Future<Either<Failure, void>> deleteContact({required int contactId}) async {
    return executeApiCall(() async {
      await _remoteDataSource.deleteContact(contactId: contactId);
    });
  }
}
