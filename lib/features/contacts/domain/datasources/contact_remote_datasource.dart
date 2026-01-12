import 'package:chattrix_ui/features/contacts/data/models/contact_model.dart';
import 'package:chattrix_ui/features/contacts/data/models/friend_request_model.dart';

abstract class ContactRemoteDataSource {
  Future<FriendRequestModel> sendFriendRequest({required int receiverUserId, String? nickname});

  Future<List<FriendRequestModel>> getReceivedFriendRequests();

  Future<List<FriendRequestModel>> getSentFriendRequests();

  Future<void> acceptFriendRequest({required int friendRequestId});

  Future<void> rejectFriendRequest({required int friendRequestId});

  Future<void> cancelFriendRequest({required int friendRequestId});

  Future<List<ContactModel>> getContacts();

  Future<ContactModel> getContactById(int contactId);

  Future<void> updateContactNickname({required int contactId, required String nickname});

  Future<void> deleteContact({required int contactId});
}
