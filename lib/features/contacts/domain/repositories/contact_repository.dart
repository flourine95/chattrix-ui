import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/contact.dart';
import '../entities/friend_request.dart';

abstract class ContactRepository {
  // Friend Requests
  Future<Either<Failure, FriendRequest>> sendFriendRequest({required int receiverUserId, String? nickname});

  Future<Either<Failure, List<FriendRequest>>> getReceivedFriendRequests();

  Future<Either<Failure, List<FriendRequest>>> getSentFriendRequests();

  Future<Either<Failure, void>> acceptFriendRequest({required int friendRequestId});

  Future<Either<Failure, void>> rejectFriendRequest({required int friendRequestId});

  Future<Either<Failure, void>> cancelFriendRequest({required int friendRequestId});

  // Contacts
  Future<Either<Failure, List<Contact>>> getContacts();

  Future<Either<Failure, Contact>> getContactById(int contactId);

  Future<Either<Failure, void>> updateContactNickname({required int contactId, required String nickname});

  Future<Either<Failure, void>> deleteContact({required int contactId});
}
