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
    final now = DateTime.now();
    debugPrint('🌐 [BirthdayAPI] GET /v1/birthdays/today');
    debugPrint(
      '   📅 Current date: ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
    );
    debugPrint('   🕐 Current time: ${now.hour}:${now.minute}:${now.second}');
    debugPrint('   🌍 Timezone: ${now.timeZoneName} (offset: ${now.timeZoneOffset})');

    try {
      final response = await _dio.get('/v1/birthdays/today');

      debugPrint('✅ [BirthdayAPI] Response status: ${response.statusCode}');
      debugPrint('   Response data type: ${response.data.runtimeType}');
      debugPrint('   Response data: ${response.data}');

      // API returns: {success: true, message: "...", data: [...]}
      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data is List) {
          debugPrint('   📊 Data array length: ${data.length}');
          if (data.isEmpty) {
            debugPrint('   ⚠️ Backend returned empty array - possible issues:');
            debugPrint('      1. No users have dateOfBirth set in database');
            debugPrint('      2. Backend timezone mismatch (server date != client date)');
            debugPrint('      3. Backend date comparison logic bug');
            debugPrint('      4. Date format mismatch in database');
          }

          final birthdays = data.map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
          debugPrint('   ✅ Parsed ${birthdays.length} birthdays from data field');
          return birthdays;
        }
      }

      debugPrint('⚠️ [BirthdayAPI] Unexpected response format, returning empty');
      return [];
    } catch (e, st) {
      debugPrint('❌ [BirthdayAPI] Error: $e');
      debugPrint('   Stack trace: $st');
      rethrow;
    }
  }

  /// Get users with upcoming birthdays
  ///
  /// **Endpoint**: `GET /v1/birthdays/upcoming?days={days}`
  ///
  /// **Errors:**
  /// - 401: Unauthorized
  Future<List<BirthdayUserDto>> getUpcomingBirthdays({int days = 7}) async {
    debugPrint('🌐 [BirthdayAPI] GET /v1/birthdays/upcoming?days=$days');

    try {
      final response = await _dio.get('/v1/birthdays/upcoming', queryParameters: {'days': days});

      debugPrint('✅ [BirthdayAPI] Response status: ${response.statusCode}');

      // API returns: {success: true, message: "...", data: [...]}
      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'];

        if (data is List) {
          final birthdays = data.map((json) => BirthdayUserDto.fromJson(json as Map<String, dynamic>)).toList();
          debugPrint('   Parsed ${birthdays.length} upcoming birthdays');
          return birthdays;
        }
      }

      debugPrint('⚠️ [BirthdayAPI] Unexpected response format, returning empty');
      return [];
    } catch (e) {
      debugPrint('❌ [BirthdayAPI] Error: $e');
      rethrow;
    }
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
