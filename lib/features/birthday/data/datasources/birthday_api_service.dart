import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/birthday_user_dto.dart';

class BirthdayApiService {
  final Dio _dio;

  BirthdayApiService(this._dio);

  /// Get users with birthday today
  ///
  /// **Endpoint**: `GET /v1/birthdays/today`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  Future<List<BirthdayUserDto>> getTodayBirthdays() async {
    final response = await _dio.get('/v1/birthdays/today');

    if (response.data is List) {
      return (response.data as List).map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
    }

    return [];
  }

  /// Get users with upcoming birthdays
  ///
  /// **Endpoint**: `GET /v1/birthdays/upcoming?days={days}`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  Future<List<BirthdayUserDto>> getUpcomingBirthdays({int days = 7}) async {
    final response = await _dio.get('/v1/birthdays/upcoming', queryParameters: {'days': days});

    if (response.data is List) {
      return (response.data as List).map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
    }

    return [];
  }

  /// Send birthday wishes
  ///
  /// **Endpoint**: `POST /v1/birthdays/send-wishes`
  ///
  /// **Errors:**
  /// - 400: Validation failed
  /// - 401: Unauthorized
  /// - 403: Not a member of conversation
  /// - 404: User or conversation not found
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

    debugPrint('🌐 API Request: POST /v1/birthdays/send-wishes');
    debugPrint('   Data: $requestData');

    try {
      final response = await _dio.post(
        '/v1/birthdays/send-wishes',
        data: requestData,
        options: Options(
          responseType: ResponseType.plain, // Accept plain text or empty response
          validateStatus: (status) => status != null && status >= 200 && status < 300,
        ),
      );
      debugPrint('✅ API Response: ${response.statusCode}');
      debugPrint('   Data: ${response.data}');

      // Success - no need to return anything
      return;
    } catch (e) {
      debugPrint('❌ API Error: $e');
      rethrow;
    }
  }
}
