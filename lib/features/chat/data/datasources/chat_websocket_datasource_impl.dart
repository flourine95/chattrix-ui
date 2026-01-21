import 'dart:async';

import 'package:chattrix_ui/core/constants/websocket_events.dart';
import 'package:chattrix_ui/core/network/websocket_service.dart';
import 'package:chattrix_ui/core/services/online_status_cache.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/data/models/conversation_update_model.dart';
import 'package:chattrix_ui/features/chat/data/models/message_model.dart';
import 'package:chattrix_ui/features/chat/data/models/typing_indicator_model.dart';
import 'package:chattrix_ui/features/chat/data/models/user_status_update_model.dart';
import 'package:chattrix_ui/features/chat/data/models/websocket/scheduled_message_failed_dto.dart';
import 'package:chattrix_ui/features/chat/data/models/websocket/scheduled_message_sent_dto.dart';
import 'package:chattrix_ui/features/chat/domain/datasources/chat_websocket_datasource.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:flutter/foundation.dart';

class ChatWebSocketDataSourceImpl implements ChatWebSocketDataSource {
  final WebSocketService _webSocketService;
  StreamSubscription<Map<String, dynamic>>? _subscription;

  final _messageController = StreamController<Message>.broadcast();
  final _messageIdUpdateController = StreamController<Map<String, dynamic>>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationCreatedController = StreamController<Map<String, dynamic>>.broadcast();
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  final _scheduledMessageSentController = StreamController<ScheduledMessageSentDto>.broadcast();
  final _scheduledMessageFailedController = StreamController<ScheduledMessageFailedDto>.broadcast();
  final _pollEventController = StreamController<Map<String, dynamic>>.broadcast();
  final _eventEventController = StreamController<Map<String, dynamic>>.broadcast();
  final _heartbeatAckController = StreamController<void>.broadcast();

  ChatWebSocketDataSourceImpl({required WebSocketService webSocketService}) : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    final chatMessageTypes = [
      WebSocketEvents.chatMessage,
      WebSocketEvents.messageIdUpdate,
      WebSocketEvents.typingIndicator,
      WebSocketEvents.userStatus,
      WebSocketEvents.conversationCreated,
      WebSocketEvents.conversationUpdate,
      WebSocketEvents.scheduledMessageSent,
      WebSocketEvents.scheduledMessageFailed,
      WebSocketEvents.messageReaction,
      WebSocketEvents.pollEvent,
      WebSocketEvents.eventEvent,
      WebSocketEvents.heartbeatAck,
    ];

    _subscription = _webSocketService.messageRouter
        .getStreamForTypes(chatMessageTypes)
        .listen(
          _handleMessage,
          onError: (error) {
            debugPrint('🟡 WS Stream Error: $error');
          },
        );
  }

  void _handleMessage(Map<String, dynamic> message) {
    String? type;
    dynamic payload;
    
    try {
      type = message['type'] as String?;
      if (type == null) {
        debugPrint('🟡 WS Message without type: $message');
        return;
      }

      payload = message['payload'] ?? message['data'];
      if (payload == null) {
        debugPrint('🟡 WS Message without payload: type=$type');
        return;
      }

      // Log all incoming messages for debugging
      debugPrint('📨 [WS] Received: type=$type');

      // Dùng switch case trực tiếp với WebSocketEvents
      switch (type) {
        case WebSocketEvents.chatMessage:
          final messageEntity = MessageModel.fromApi(payload as Map<String, dynamic>).toEntity();
          _messageController.add(messageEntity);
          break;

        case WebSocketEvents.messageIdUpdate:
          final tempId = payload['tempId'] as int;
          final realId = payload['realId'] as int;
          final conversationId = payload['conversationId'] as int;
          _messageIdUpdateController.add({'tempId': tempId, 'realId': realId, 'conversationId': conversationId});
          break;

        case WebSocketEvents.typingIndicator:
          final indicatorEntity = TypingIndicatorModel.fromJson(payload as Map<String, dynamic>).toEntity();
          _typingController.add(indicatorEntity);
          break;

        case WebSocketEvents.userStatus:
          debugPrint('👤 [UserStatus] Raw payload: $payload');
          final statusEntity = UserStatusUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();

          debugPrint('👤 [UserStatus] Received status update: userId=${statusEntity.userId}, status=${statusEntity.isOnline ? "ONLINE" : "OFFLINE"}');

          final cache = OnlineStatusCache();
          final userId = int.tryParse(statusEntity.userId);
          if (userId != null) {
            // Parse lastSeen as UTC and convert to local time
            DateTime? lastSeen;
            if (statusEntity.lastSeen != null) {
              try {
                lastSeen = DateTime.parse(statusEntity.lastSeen!).toLocal();
                debugPrint('📅 [UserStatus] Parsed lastSeen: ${statusEntity.lastSeen} → $lastSeen (local)');
              } catch (e) {
                debugPrint('❌ [UserStatus] Failed to parse lastSeen: ${statusEntity.lastSeen}, error: $e');
              }
            }
            cache.updateStatus(userId, statusEntity.isOnline, lastSeen: lastSeen);
            debugPrint('✅ [UserStatus] Updated cache for user $userId: ${statusEntity.isOnline ? "ONLINE" : "OFFLINE"}');
          } else {
            debugPrint('❌ [UserStatus] Failed to parse userId: ${statusEntity.userId}');
          }

          _userStatusController.add(statusEntity);
          break;

        case WebSocketEvents.conversationCreated:
          debugPrint('🆕 [WS] New conversation created');
          _conversationCreatedController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.conversationUpdate:
          final updateEntity = ConversationUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();
          _conversationUpdateController.add(updateEntity);
          break;

        case WebSocketEvents.scheduledMessageSent:
          final dto = ScheduledMessageSentDto.fromJson(payload as Map<String, dynamic>);
          _scheduledMessageSentController.add(dto);
          break;

        case WebSocketEvents.scheduledMessageFailed:
          final dto = ScheduledMessageFailedDto.fromJson(payload as Map<String, dynamic>);
          _scheduledMessageFailedController.add(dto);
          break;

        case WebSocketEvents.messageReaction:
          break;

        case WebSocketEvents.pollEvent:
          _pollEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.eventEvent:
          _eventEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.heartbeatAck:
          debugPrint('💚 [WS] Heartbeat acknowledged');
          _heartbeatAckController.add(null);
          break;

        default:
          debugPrint('🟡 [WS] Unknown message type: $type');
      }
    } catch (e, stack) {
      debugPrint('🟡 WS Handle Message Error: $e');
      debugPrint('🟡 Event type was: $type');
      debugPrint('🟡 Payload was: $payload');
      debugPrint('🟡 Stack trace: $stack');
    }
  }

  @override
  Future<void> connect(String accessToken) async {}

  @override
  Future<void> disconnect() async {}

  @override
  void sendMessage(int conversationId, ChatMessageRequest request) {
    final messageData = request.toJson();
    messageData['conversationId'] = conversationId;
    final wsPayload = {'type': WebSocketEvents.chatMessage, 'payload': messageData};
    _webSocketService.send(wsPayload);
  }

  @override
  void sendTypingStart(int conversationId) {
    final payload = {
      'type': WebSocketEvents.typingStart,
      'payload': {'conversationId': conversationId},
    };
    _webSocketService.send(payload);
  }

  @override
  void sendTypingStop(int conversationId) {
    final payload = {
      'type': WebSocketEvents.typingStop,
      'payload': {'conversationId': conversationId},
    };
    _webSocketService.send(payload);
  }

  @override
  void sendGenericMessage(Map<String, dynamic> payload) {
    _webSocketService.send(payload);
  }

  @override
  Stream<Message> get messageStream => _messageController.stream;

  @override
  Stream<TypingIndicator> get typingStream => _typingController.stream;

  @override
  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;

  @override
  Stream<ConversationUpdate> get conversationUpdateStream => _conversationUpdateController.stream;

  Stream<Map<String, dynamic>> get conversationCreatedStream => _conversationCreatedController.stream;

  @override
  Stream<ScheduledMessageSentDto> get scheduledMessageSentStream => _scheduledMessageSentController.stream;

  @override
  Stream<ScheduledMessageFailedDto> get scheduledMessageFailedStream => _scheduledMessageFailedController.stream;

  @override
  Stream<Map<String, dynamic>> get pollEventStream => _pollEventController.stream;

  @override
  Stream<Map<String, dynamic>> get eventEventStream => _eventEventController.stream;

  @override
  Stream<Map<String, dynamic>> get messageIdUpdateStream => _messageIdUpdateController.stream;

  @override
  Stream<void> get heartbeatAckStream => _heartbeatAckController.stream;

  @override
  Stream<bool> get connectionStream => _webSocketService.connectionStream;

  @override
  Stream<Map<String, dynamic>> get rawMessageStream => _webSocketService.messageRouter.rawMessageStream;

  @override
  bool get isConnected => _webSocketService.isConnected;

  @override
  void dispose() {
    _subscription?.cancel();
    _messageController.close();
    _messageIdUpdateController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationCreatedController.close();
    _conversationUpdateController.close();
    _scheduledMessageSentController.close();
    _scheduledMessageFailedController.close();
    _pollEventController.close();
    _eventEventController.close();
    _heartbeatAckController.close();
  }
}
