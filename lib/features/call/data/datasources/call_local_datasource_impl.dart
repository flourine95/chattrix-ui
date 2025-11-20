import 'dart:convert';
import 'package:chattrix_ui/features/call/data/models/call_history_model.dart';
import 'package:chattrix_ui/features/call/domain/datasources/call_local_datasource.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CallLocalDataSourceImpl implements CallLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _callHistoryKey = 'call_history';

  CallLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveCallHistory(CallHistoryEntity callHistory) async {
    try {
      // Get existing call history
      final existingHistory = await getCallHistory();

      // Check if call already exists and update it, otherwise add new
      final index = existingHistory.indexWhere((call) => call.id == callHistory.id);
      if (index != -1) {
        existingHistory[index] = callHistory;
      } else {
        existingHistory.add(callHistory);
      }

      // Convert all entities to models
      final models = existingHistory.map((entity) => CallHistoryModel.fromEntity(entity)).toList();

      // Serialize to JSON
      final jsonList = models.map((model) => model.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      // Save to secure storage
      await secureStorage.write(key: _callHistoryKey, value: jsonString);
    } catch (e) {
      throw Exception('Failed to save call history: $e');
    }
  }

  @override
  Future<List<CallHistoryEntity>> getCallHistory() async {
    try {
      // Read from secure storage
      final jsonString = await secureStorage.read(key: _callHistoryKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      // Deserialize from JSON
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      final models = jsonList.map((json) => CallHistoryModel.fromJson(json as Map<String, dynamic>)).toList();

      // Convert models to entities
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get call history: $e');
    }
  }

  @override
  Future<void> deleteCallHistory(String callId) async {
    try {
      // Get existing call history
      final existingHistory = await getCallHistory();

      // Remove the call with the specified ID
      existingHistory.removeWhere((call) => call.id == callId);

      // Convert all entities to models
      final models = existingHistory.map((entity) => CallHistoryModel.fromEntity(entity)).toList();

      // Serialize to JSON
      final jsonList = models.map((model) => model.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      // Save to secure storage
      await secureStorage.write(key: _callHistoryKey, value: jsonString);
    } catch (e) {
      throw Exception('Failed to delete call history: $e');
    }
  }

  @override
  Future<void> clearCallHistory() async {
    try {
      await secureStorage.delete(key: _callHistoryKey);
    } catch (e) {
      throw Exception('Failed to clear call history: $e');
    }
  }
}
