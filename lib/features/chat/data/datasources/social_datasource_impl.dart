import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/features/chat/data/models/announcement_model.dart';
import 'package:chattrix_ui/features/chat/data/models/announcement_request.dart';
import 'package:chattrix_ui/features/chat/data/models/birthday_model.dart';
import 'package:chattrix_ui/features/chat/data/models/mutual_group_model.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/social_datasource.dart';
import 'package:dio/dio.dart';

class SocialDatasourceImpl implements SocialDatasource {
  final Dio dio;

  SocialDatasourceImpl({required this.dio});

  @override
  Future<List<BirthdayModel>> getBirthdaysToday() async {
    try {
      final response = await dio.get('/v1/birthdays/today');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data.map((json) => BirthdayModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: 'Failed to get birthdays');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get birthdays');
    }
  }

  @override
  Future<SendBirthdayWishesResponse> sendBirthdayWishes({required SendBirthdayWishesRequest request}) async {
    try {
      final response = await dio.post('/v1/birthdays/send-wishes', data: request.toJson());

      if (response.statusCode == 200) {
        return SendBirthdayWishesResponse.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to send birthday wishes');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to send birthday wishes');
    }
  }

  @override
  Future<AnnouncementModel> createAnnouncement({
    required int conversationId,
    required CreateAnnouncementRequest request,
  }) async {
    try {
      final response = await dio.post('/v1/conversations/$conversationId/announcements', data: request.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AnnouncementModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }

      throw ServerException(message: 'Failed to create announcement');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to create announcement');
    }
  }

  @override
  Future<List<MutualGroupModel>> getMutualGroups({required int userId}) async {
    try {
      final response = await dio.get('/v1/users/$userId/mutual-groups');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data.map((json) => MutualGroupModel.fromJson(json as Map<String, dynamic>)).toList();
      }

      throw ServerException(message: 'Failed to get mutual groups');
    } on DioException catch (e) {
      throw ServerException(message: e.response?.data['message'] ?? 'Failed to get mutual groups');
    }
  }
}
