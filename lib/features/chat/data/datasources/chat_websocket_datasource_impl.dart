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
  final _conversationPermissionsUpdatedController = StreamController<Map<String, dynamic>>.broadcast();
  final _scheduledMessageSentController = StreamController<ScheduledMessageSentDto>.broadcast();
  final _scheduledMessageFailedController = StreamController<ScheduledMessageFailedDto>.broadcast();
  final _pollEventController = StreamController<Map<String, dynamic>>.broadcast();
  final _eventEventController = StreamController<Map<String, dynamic>>.broadcast();
  final _heartbeatAckController = StreamController<void>.broadcast();
  final _messageDeletedController = StreamController<Map<String, dynamic>>.broadcast();
  final _messageUpdatedController = StreamController<Map<String, dynamic>>.broadcast();
  final _messagePinController = StreamController<Map<String, dynamic>>.broadcast();
  final _messageReactionController = StreamController<Map<String, dynamic>>.broadcast();
  final _conversationMemberLeftController = StreamController<Map<String, dynamic>>.broadcast();
  final _conversationMemberAddedController = StreamController<Map<String, dynamic>>.broadcast();

  ChatWebSocketDataSourceImpl({required WebSocketService webSocketService}) : _webSocketService = webSocketService {
    _startListening();
  }

  void _startListening() {
    final chatMessageTypes = [
      WebSocketEvents.chatMessage,
      WebSocketEvents.messageIdUpdate,
      WebSocketEvents.messageDeleted,
      WebSocketEvents.messageUpdated,
      WebSocketEvents.messagePin,
      WebSocketEvents.typingIndicator,
      WebSocketEvents.userStatus,
      WebSocketEvents.conversationCreated,
      WebSocketEvents.conversationUpdate,
      WebSocketEvents.conversationUpdated,
      WebSocketEvents.conversationPermissionsUpdated,
      WebSocketEvents.conversationMemberLeft,
      WebSocketEvents.conversationMemberAdded,
      WebSocketEvents.conversationMemberRemoved,
      WebSocketEvents.scheduledMessageSent,
      WebSocketEvents.scheduledMessageFailed,
      WebSocketEvents.messageReaction,
      WebSocketEvents.pollEvent,
      WebSocketEvents.pollCreated,
      WebSocketEvents.pollVoted,
      WebSocketEvents.eventEvent,
      WebSocketEvents.eventRsvp,
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

        case WebSocketEvents.messageDeleted:
          final messageId = payload['messageId'] as int;
          final conversationId = payload['conversationId'] as int;
          _messageDeletedController.add({'messageId': messageId, 'conversationId': conversationId});
          break;

        case WebSocketEvents.messageUpdated:
          _messageUpdatedController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.messagePin:
          _messagePinController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.typingIndicator:
          final indicatorEntity = TypingIndicatorModel.fromJson(payload as Map<String, dynamic>).toEntity();
          _typingController.add(indicatorEntity);
          break;

        case WebSocketEvents.userStatus:
          final statusEntity = UserStatusUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();

          final cache = OnlineStatusCache();
          final userId = int.tryParse(statusEntity.userId);
          if (userId != null) {
            // Parse lastSeen as UTC and convert to local time
            DateTime? lastSeen;
            if (statusEntity.lastSeen != null) {
              try {
                lastSeen = DateTime.parse(statusEntity.lastSeen!).toLocal();
              } catch (e) {
                // Ignore parse errors
              }
            }
            cache.updateStatus(userId, statusEntity.isOnline, lastSeen: lastSeen);
          }

          _userStatusController.add(statusEntity);
          break;

        case WebSocketEvents.conversationCreated:
          _conversationCreatedController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.conversationUpdate:
          final updateEntity = ConversationUpdateModel.fromJson(payload as Map<String, dynamic>).toEntity();
          _conversationUpdateController.add(updateEntity);
          break;

        case WebSocketEvents.conversationUpdated:
          // Handle conversation metadata updates (name, avatar, description changes)
          // Parse and update the conversation in the list immediately
          final conversationData = payload as Map<String, dynamic>;
          final conversationId = conversationData['conversationId'] as int?;
          
          if (conversationId != null) {
            // Create a minimal update to trigger UI refresh
            final updateData = {
              'conversation': {
                'id': conversationId,
                'name': conversationData['name'],
                'avatarUrl': conversationData['avatarUrl'],
                'description': conversationData['description'],
                'updatedAt': conversationData['updatedAt'],
              }
            };
            _conversationCreatedController.add(updateData);
          }
          break;

        case WebSocketEvents.conversationPermissionsUpdated:
          // Handle group permissions updates
          _conversationPermissionsUpdatedController.add(payload as Map<String, dynamic>);
          debugPrint('🔧 [WS] Permissions updated event received');
          break;

        case WebSocketEvents.conversationMemberLeft:
          // Handle member leaving group
          _conversationMemberLeftController.add(payload as Map<String, dynamic>);
          debugPrint('👋 [WS] Member left event received');
          break;

        case WebSocketEvents.conversationMemberAdded:
          // Handle member added to group
          _conversationMemberAddedController.add(payload as Map<String, dynamic>);
          debugPrint('👤 [WS] Member added event received');
          break;

        case WebSocketEvents.conversationMemberRemoved:
          // Handle member removed by admin (same as member_left, just different reason)
          _conversationMemberLeftController.add(payload as Map<String, dynamic>);
          debugPrint('🚫 [WS] Member removed event received');
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
          _messageReactionController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.pollEvent:
          _pollEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.pollCreated:
          // Handle new poll.created event (same as poll.event but more specific)
          _pollEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.pollVoted:
          // Handle new poll.voted event (same as poll.event but more specific)
          _pollEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.eventEvent:
          _eventEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.eventRsvp:
          // Handle new event.rsvp event (same as event.event but more specific)
          _eventEventController.add(payload as Map<String, dynamic>);
          break;

        case WebSocketEvents.heartbeatAck:
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
  Stream<Map<String, dynamic>> get conversationPermissionsUpdatedStream => _conversationPermissionsUpdatedController.stream;

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

  Stream<Map<String, dynamic>> get messageDeletedStream => _messageDeletedController.stream;

  Stream<Map<String, dynamic>> get messageUpdatedStream => _messageUpdatedController.stream;

  Stream<Map<String, dynamic>> get messagePinStream => _messagePinController.stream;

  Stream<Map<String, dynamic>> get messageReactionStream => _messageReactionController.stream;

  Stream<Map<String, dynamic>> get conversationMemberLeftStream => _conversationMemberLeftController.stream;

  Stream<Map<String, dynamic>> get conversationMemberAddedStream => _conversationMemberAddedController.stream;

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
    _messageDeletedController.close();
    _messageUpdatedController.close();
    _messagePinController.close();
    _messageReactionController.close();
    _conversationMemberLeftController.close();
    _conversationMemberAddedController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationCreatedController.close();
    _conversationUpdateController.close();
    _conversationPermissionsUpdatedController.close();
    _scheduledMessageSentController.close();
    _scheduledMessageFailedController.close();
    _pollEventController.close();
    _eventEventController.close();
    _heartbeatAckController.close();
  }
}
