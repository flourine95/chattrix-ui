import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_update_model.dart';
import 'package:chattrix_ui/features/chat/data/models/typing_indicator_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_update_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:chattrix_ui/core/services/performance_monitor.dart';

/// Service for parsing JSON in background isolates to avoid blocking the main thread
///
/// This service uses Flutter's compute() function to offload JSON parsing to background isolates,
/// preventing frame drops and UI jank when processing WebSocket messages.
class JsonParsingService {
  /// Parse a single message in a background isolate
  ///
  /// Takes a JSON string and returns a Message entity after parsing in a background isolate.
  /// Throws FormatException if JSON is malformed.
  static Future<Message> parseMessage(String jsonString) async {
    try {
      return await PerformanceMonitor.measureAsync('parseMessage (isolate)', () async {
        final isolateStart = Stopwatch()..start();
        final result = await compute(_parseMessageIsolate, jsonString);
        isolateStart.stop();
        PerformanceMonitor.logIsolateCreation('parseMessage', isolateStart.elapsedMilliseconds);
        return result;
      });
    } catch (e) {
      throw FormatException('Failed to parse message: $e');
    }
  }

  /// Parse multiple messages in a background isolate
  ///
  /// Takes a JSON string containing an array of messages and returns a list of Message entities.
  /// Throws FormatException if JSON is malformed.
  static Future<List<Message>> parseMessages(String jsonString) async {
    try {
      return await PerformanceMonitor.measureAsync('parseMessages (isolate)', () async {
        final isolateStart = Stopwatch()..start();
        final result = await compute(_parseMessagesIsolate, jsonString);
        isolateStart.stop();
        PerformanceMonitor.logIsolateCreation('parseMessages', isolateStart.elapsedMilliseconds);
        return result;
      });
    } catch (e) {
      throw FormatException('Failed to parse messages: $e');
    }
  }

  /// Parse conversation update in a background isolate
  ///
  /// Takes a JSON string and returns a ConversationUpdate entity.
  /// Throws FormatException if JSON is malformed.
  static Future<ConversationUpdate> parseConversationUpdate(String jsonString) async {
    try {
      return await PerformanceMonitor.measureAsync('parseConversationUpdate (isolate)', () async {
        final isolateStart = Stopwatch()..start();
        final result = await compute(_parseConversationUpdateIsolate, jsonString);
        isolateStart.stop();
        PerformanceMonitor.logIsolateCreation('parseConversationUpdate', isolateStart.elapsedMilliseconds);
        return result;
      });
    } catch (e) {
      throw FormatException('Failed to parse conversation update: $e');
    }
  }

  /// Parse typing indicator in a background isolate
  ///
  /// Takes a JSON string and returns a TypingIndicator entity.
  /// Throws FormatException if JSON is malformed.
  static Future<TypingIndicator> parseTypingIndicator(String jsonString) async {
    try {
      return await PerformanceMonitor.measureAsync('parseTypingIndicator (isolate)', () async {
        final isolateStart = Stopwatch()..start();
        final result = await compute(_parseTypingIndicatorIsolate, jsonString);
        isolateStart.stop();
        PerformanceMonitor.logIsolateCreation('parseTypingIndicator', isolateStart.elapsedMilliseconds);
        return result;
      });
    } catch (e) {
      throw FormatException('Failed to parse typing indicator: $e');
    }
  }

  /// Parse user status update in a background isolate
  ///
  /// Takes a JSON string and returns a UserStatusUpdate entity.
  /// Throws FormatException if JSON is malformed.
  static Future<UserStatusUpdate> parseUserStatusUpdate(String jsonString) async {
    try {
      return await PerformanceMonitor.measureAsync('parseUserStatusUpdate (isolate)', () async {
        final isolateStart = Stopwatch()..start();
        final result = await compute(_parseUserStatusUpdateIsolate, jsonString);
        isolateStart.stop();
        PerformanceMonitor.logIsolateCreation('parseUserStatusUpdate', isolateStart.elapsedMilliseconds);
        return result;
      });
    } catch (e) {
      throw FormatException('Failed to parse user status update: $e');
    }
  }
}

// Top-level functions for isolate execution
// These must be top-level or static functions to work with compute()

/// Parse a single message from JSON string (isolate function)
Message _parseMessageIsolate(String jsonString) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final model = MessageModel.fromApi(json);
  return model.toEntity();
}

/// Parse multiple messages from JSON string (isolate function)
List<Message> _parseMessagesIsolate(String jsonString) {
  final jsonList = jsonDecode(jsonString) as List<dynamic>;
  return jsonList
      .map((json) => MessageModel.fromApi(json as Map<String, dynamic>))
      .map((model) => model.toEntity())
      .toList();
}

/// Parse conversation update from JSON string (isolate function)
ConversationUpdate _parseConversationUpdateIsolate(String jsonString) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final model = ConversationUpdateModel.fromJson(json);
  return model.toEntity();
}

/// Parse typing indicator from JSON string (isolate function)
TypingIndicator _parseTypingIndicatorIsolate(String jsonString) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final model = TypingIndicatorModel.fromJson(json);
  return model.toEntity();
}

/// Parse user status update from JSON string (isolate function)
UserStatusUpdate _parseUserStatusUpdateIsolate(String jsonString) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final model = UserStatusUpdateModel.fromJson(json);
  return model.toEntity();
}
