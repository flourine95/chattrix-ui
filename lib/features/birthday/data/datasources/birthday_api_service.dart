import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/birthday/data/models/birthday_user_dto.dart';
import 'package:dio/dio.dart';

class BirthdayApiService {
  final Dio _dio;

  BirthdayApiService(this._dio);

  Future<List<BirthdayUserDto>> getTodayBirthdays() async {
    try {
      final response = await _dio.get(ApiConstants.birthdaysToday);

      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data is List) {
          final birthdays = data.map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
          return birthdays;
        }
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BirthdayUserDto>> getUpcomingBirthdays({int days = 7}) async {
    try {
      final response = await _dio.get(ApiConstants.birthdaysUpcoming, queryParameters: {'days': days});

      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data is List) {
          final birthdays = data.map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
          return birthdays;
        }
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendBirthdayWishes({
    required int userId,
    required List<int> conversationIds,
    String? customMessage,
  }) async {
    final requestData = {
      'userId': userId,
      'conversationIds': conversationIds,
      if (customMessage != null && customMessage.isNotEmpty) 'customMessage': customMessage,
    };

    try {
      await _dio.post(
        ApiConstants.sendBirthdayWishes,
        data: requestData,
        options: Options(
          responseType: ResponseType.plain,
          validateStatus: (status) => status != null && status >= 200 && status < 300,
        ),
      );

      return;
    } catch (e) {
      rethrow;
    }
  }
}
