import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/contacts/data/models/contact_model.dart';
import 'package:chattrix_ui/features/contacts/data/models/friend_request_model.dart';
import 'package:chattrix_ui/features/contacts/domain/datasources/contact_remote_datasource.dart';
import 'package:dio/dio.dart';

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final Dio dio;

  ContactRemoteDataSourceImpl({required this.dio});

  @override
  Future<FriendRequestModel> sendFriendRequest({required int receiverUserId, String? nickname}) async {
    try {
      final response = await dio.post(
        ApiConstants.sendFriendRequest,
        data: {'receiverUserId': receiverUserId, if (nickname != null) 'nickname': nickname},
      );

      final data = _handleResponse(response);
      return FriendRequestModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<FriendRequestModel>> getReceivedFriendRequests() async {
    try {
      final response = await dio.get(ApiConstants.receivedFriendRequests);

      final data = _handleResponse(response);
      final List<dynamic> requestsList = data as List<dynamic>;
      return requestsList.map((json) => FriendRequestModel.fromJson(json)).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<FriendRequestModel>> getSentFriendRequests() async {
    try {
      final response = await dio.get(ApiConstants.sentFriendRequests);

      final data = _handleResponse(response);
      final List<dynamic> requestsList = data as List<dynamic>;
      return requestsList.map((json) => FriendRequestModel.fromJson(json)).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> acceptFriendRequest({required int friendRequestId}) async {
    try {
      final response = await dio.post(ApiConstants.acceptFriendRequest(friendRequestId));

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> rejectFriendRequest({required int friendRequestId}) async {
    try {
      final response = await dio.post(ApiConstants.rejectFriendRequest(friendRequestId));

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> cancelFriendRequest({required int friendRequestId}) async {
    try {
      final response = await dio.delete(ApiConstants.cancelFriendRequest(friendRequestId));

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await dio.get(ApiConstants.contacts);

      final data = _handleResponse(response);
      final List<dynamic> contactsList = data as List<dynamic>;
      return contactsList.map((json) => ContactModel.fromJson(json)).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ContactModel> getContactById(int contactId) async {
    try {
      final response = await dio.get(ApiConstants.contactById(contactId));

      final data = _handleResponse(response);
      return ContactModel.fromJson(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> updateContactNickname({required int contactId, required String nickname}) async {
    try {
      final response = await dio.put(ApiConstants.updateContactNickname(contactId), data: {'nickname': nickname});

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteContact({required int contactId}) async {
    try {
      final response = await dio.delete(ApiConstants.deleteContact(contactId));

      _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['data'];
    } else {
      throw ServerException(
        message: response.data['message'] ?? 'Unknown error',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        final statusCode = error.response!.statusCode ?? 500;
        final message = error.response!.data?['message'] ?? 'An error occurred';
        return ServerException(message: message, statusCode: statusCode);
      } else {
        return NetworkException(message: error.message ?? 'Network error occurred');
      }
    }
    return ServerException(message: error.toString(), statusCode: 500);
  }
}
