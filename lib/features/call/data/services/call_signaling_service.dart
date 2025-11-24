import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/chat/data/services/chat_websocket_service.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/data/services/call_logger.dart';
import 'package:chattrix_ui/features/call/data/services/channel_id_validator.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_invitation_data.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_accepted_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_accepted_data.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_rejected_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_rejected_data.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_ended_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_ended_data.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_timeout_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_timeout_data.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_quality_warning_message.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_quality_warning_data.dart';
import 'package:dartz/dartz.dart';

/// WebSocket events for call signaling (client to server)
class CallSignalingEvent {
  static const String callInvitation = 'call.invitation';
  static const String callResponse = 'call.response';
  static const String callEnded = 'call.ended';
}

/// WebSocket events for call signaling (server to client)
class CallSignalingResponse {
  static const String callInvitation = 'call_invitation';
  static const String callAccepted = 'call_accepted';
  static const String callRejected = 'call_rejected';
  static const String callEnded = 'call_ended';
  static const String callTimeout = 'call_timeout';
  static const String callQualityWarning = 'call_quality_warning';
}

/// Service for handling call signaling over WebSocket
class CallSignalingService {
  final ChatWebSocketService _webSocketService;

  // Stream controllers for call signaling events
  final _callInvitationController = StreamController<CallInvitationData>.broadcast();
  final _callAcceptedController = StreamController<CallAcceptedData>.broadcast();
  final _callRejectedController = StreamController<CallRejectedData>.broadcast();
  final _callTimeoutController = StreamController<CallTimeoutData>.broadcast();
  final _callEndedController = StreamController<CallEndedData>.broadcast();
  final _callQualityWarningController = StreamController<CallQualityWarningData>.broadcast();

  StreamSubscription<dynamic>? _messageSubscription;
  StreamSubscription<bool>? _connectionSubscription;

  CallSignalingService({required ChatWebSocketService webSocketService}) : _webSocketService = webSocketService {
    _listenToWebSocketMessages();
    _listenToWebSocketConnectionState();
  }

  /// Stream of incoming call invitations
  Stream<CallInvitationData> get callInvitationStream => _callInvitationController.stream;

  /// Stream of call accepted notifications
  Stream<CallAcceptedData> get callAcceptedStream => _callAcceptedController.stream;

  /// Stream of call rejected notifications
  Stream<CallRejectedData> get callRejectedStream => _callRejectedController.stream;

  /// Stream of call timeout notifications
  Stream<CallTimeoutData> get callTimeoutStream => _callTimeoutController.stream;

  /// Stream of call ended notifications
  Stream<CallEndedData> get callEndedStream => _callEndedController.stream;

  /// Stream of call quality warnings
  Stream<CallQualityWarningData> get callQualityWarningStream => _callQualityWarningController.stream;

  /// Check if WebSocket is connected
  bool get isConnected => _webSocketService.isConnected;

  /// Listen to WebSocket messages and filter call-related events
  void _listenToWebSocketMessages() {
    // Subscribe to raw message stream from WebSocket service
    _messageSubscription = _webSocketService.rawMessageStream.listen((data) {
      handleIncomingMessage(data);
    });
  }

  /// Listen to WebSocket connection state changes
  /// IMPORTANT: WebSocket disconnection does NOT affect Agora RTC connection
  /// This method only logs connection state for debugging purposes
  void _listenToWebSocketConnectionState() {
    _connectionSubscription = _webSocketService.connectionStream.listen((isConnected) {
      if (isConnected) {
        CallLogger.logInfo('WebSocket reconnected - call signaling resumed');
        CallLogger.logInfo('Note: Agora RTC connection remained active during WebSocket disconnection');
      } else {
        CallLogger.logWarning('WebSocket disconnected - call signaling temporarily unavailable');
        CallLogger.logInfo('Note: Agora RTC connection remains active, media streaming continues');
      }
    });
  }

  /// Send call invitation to a user
  /// NOTE: This is typically not used as REST API handles call initiation
  /// Returns Either<Failure, void> for proper error handling
  Either<Failure, void> sendCallInvitation({
    required String callId,
    required String channelId,
    required String callerId,
    required String callerName,
    required String recipientId,
    required CallType callType,
  }) {
    if (!_webSocketService.isConnected) {
      final failure = const Failure.webSocketNotConnected(
        message: 'Cannot send call invitation: WebSocket not connected',
      );
      CallLogger.logFailure(failure, context: 'sendCallInvitation');
      return Left(failure);
    }

    try {
      final invitationData = CallInvitationData(
        callId: callId,
        channelId: channelId,
        callerId: callerId,
        callerName: callerName,
        callType: callType == CallType.video ? 'VIDEO' : 'AUDIO',
      );

      final payload = {
        'type': CallSignalingEvent.callInvitation,
        'payload': {...invitationData.toJson(), 'recipientId': recipientId},
      };

      // Send message through WebSocket
      _sendMessage(payload);

      CallLogger.logInfo('Call invitation sent successfully: callId=$callId, recipientId=$recipientId');
      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.webSocketSendFailed(message: 'Failed to send call invitation: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'sendCallInvitation', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Send call accept message
  /// Returns Either<Failure, void> for proper error handling
  Either<Failure, void> sendCallAccept({required String callId}) {
    if (!_webSocketService.isConnected) {
      final failure = const Failure.webSocketNotConnected(message: 'Cannot send call accept: WebSocket not connected');
      CallLogger.logFailure(failure, context: 'sendCallAccept');
      return Left(failure);
    }

    try {
      final payload = {
        'type': 'call.accept',
        'payload': {'callId': callId},
      };

      _sendMessage(payload);

      CallLogger.logInfo('Call accept sent successfully: callId=$callId');
      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.webSocketSendFailed(message: 'Failed to send call accept: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'sendCallAccept', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Send call reject message
  /// Returns Either<Failure, void> for proper error handling
  Either<Failure, void> sendCallReject({required String callId, String? reason}) {
    if (!_webSocketService.isConnected) {
      final failure = const Failure.webSocketNotConnected(message: 'Cannot send call reject: WebSocket not connected');
      CallLogger.logFailure(failure, context: 'sendCallReject');
      return Left(failure);
    }

    try {
      final payload = {
        'type': 'call.reject',
        'payload': {'callId': callId, if (reason != null) 'reason': reason},
      };

      _sendMessage(payload);

      CallLogger.logInfo('Call reject sent successfully: callId=$callId, reason=$reason');
      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.webSocketSendFailed(message: 'Failed to send call reject: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'sendCallReject', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Send call ended notification
  /// Returns Either<Failure, void> for proper error handling
  Either<Failure, void> sendCallEnded({required String callId, int? durationSeconds}) {
    if (!_webSocketService.isConnected) {
      final failure = const Failure.webSocketNotConnected(message: 'Cannot send call ended: WebSocket not connected');
      CallLogger.logFailure(failure, context: 'sendCallEnded');
      return Left(failure);
    }

    try {
      final payload = {
        'type': 'call.end',
        'payload': {'callId': callId, if (durationSeconds != null) 'durationSeconds': durationSeconds},
      };

      _sendMessage(payload);

      CallLogger.logInfo('Call ended sent successfully: callId=$callId, duration=${durationSeconds}s');
      return const Right(null);
    } catch (e, stackTrace) {
      final failure = Failure.webSocketSendFailed(message: 'Failed to send call ended: ${e.toString()}');
      CallLogger.logFailure(failure, context: 'sendCallEnded', stackTrace: stackTrace);
      return Left(failure);
    }
  }

  /// Handle incoming call signaling message
  /// Filters and processes only call-related messages:
  /// - call_invitation
  /// - call_accepted
  /// - call_rejected
  /// - call_ended
  /// - call_timeout
  /// - call_quality_warning
  /// All other message types are ignored silently
  void handleIncomingMessage(Map<String, dynamic> data) {
    try {
      // DEBUG: Log ALL incoming WebSocket messages to diagnose call invitation issues
      debugPrint('🔍🔍🔍 [CALL DEBUG] ========================================');
      debugPrint('🔍 [CALL DEBUG] Received WebSocket message:');
      debugPrint('🔍 [CALL DEBUG] ${const JsonEncoder.withIndent('  ').convert(data)}');
      debugPrint('🔍🔍🔍 [CALL DEBUG] ========================================');

      final type = data['type'] as String?;
      if (type == null) {
        debugPrint('⚠️ [CALL DEBUG] Message has NO type field!');
        CallLogger.logDebug('Received WebSocket message with no type field, ignoring');
        return;
      }

      debugPrint('🔍 [CALL DEBUG] Message type: $type');

      // Check if this is a call-related message type
      if (!_isCallRelatedMessage(type)) {
        // Silently ignore non-call messages (e.g., chat.message, user.status, etc.)
        debugPrint('ℹ️ [CALL DEBUG] Not a call-related message, ignoring');
        CallLogger.logDebug('Ignoring non-call message type: $type');
        return;
      }

      debugPrint('✅ [CALL DEBUG] This IS a call-related message!');

      // Backend sends messages with 'data' field (server → client) according to FLUTTER_INTEGRATION_GUIDE.md
      // But we also check 'payload' field for backward compatibility
      // Client sends messages with 'payload' field (client → server)
      Map<String, dynamic>? messageData = data['data'] as Map<String, dynamic>?;

      // If 'data' field is null, try 'payload' field
      if (messageData == null) {
        debugPrint('⚠️ [CALL DEBUG] No "data" field found, trying "payload" field...');
        messageData = data['payload'] as Map<String, dynamic>?;
      }

      if (messageData == null) {
        debugPrint('❌ [CALL DEBUG] Call message has NEITHER "data" NOR "payload" field!');
        debugPrint('❌ [CALL DEBUG] Available keys: ${data.keys.toList()}');
        CallLogger.logWarning('Call message type "$type" has no data or payload field, ignoring');
        return;
      }

      debugPrint('✅ [CALL DEBUG] Message has data/payload field, processing...');

      // Normalize the message structure to always use 'data' field for processing
      final normalizedData = {
        'type': type,
        'data': messageData,
        if (data['timestamp'] != null) 'timestamp': data['timestamp'],
      };

      debugPrint('✅ [CALL DEBUG] Normalized message structure for processing');

      // Log the received call message
      CallLogger.logDebug('Processing call message: $type');

      // Filter and process only call-related messages
      switch (type) {
        case CallSignalingResponse.callInvitation:
          debugPrint('🎉🎉🎉 [CALL DEBUG] Processing CALL INVITATION!');
          try {
            // Use normalized data structure
            final message = CallInvitationMessage.fromJson(normalizedData);
            debugPrint('✅ [CALL DEBUG] Parsed CallInvitationMessage successfully');
            debugPrint('✅ [CALL DEBUG] Call ID: ${message.data.callId}');
            debugPrint('✅ [CALL DEBUG] Caller: ${message.data.callerName}');
            debugPrint('✅ [CALL DEBUG] Channel ID: ${message.data.channelId}');
            debugPrint('✅ [CALL DEBUG] Call Type: ${message.data.callType}');

            // Validate channel ID format
            ChannelIdValidator.validate(message.data.channelId);
            debugPrint('✅ [CALL DEBUG] Channel ID validated');

            CallLogger.logInfo('Received call invitation: ${message.data.callId} from ${message.data.callerName}');

            debugPrint('🔔 [CALL DEBUG] Adding invitation to stream controller...');
            _callInvitationController.add(message.data);
            debugPrint('🔔 [CALL DEBUG] Invitation added to stream! Listeners should receive it now.');
          } catch (e, stackTrace) {
            debugPrint('❌ [CALL DEBUG] Error processing call invitation: $e');
            debugPrint('❌ [CALL DEBUG] Stack trace: $stackTrace');
            rethrow;
          }
          break;

        case CallSignalingResponse.callAccepted:
          final message = CallAcceptedMessage.fromJson(normalizedData);
          CallLogger.logInfo('Call accepted: ${message.data.callId} by ${message.data.acceptedBy}');
          _callAcceptedController.add(message.data);
          break;

        case CallSignalingResponse.callRejected:
          final message = CallRejectedMessage.fromJson(normalizedData);
          CallLogger.logInfo(
            'Call rejected: ${message.data.callId} by ${message.data.rejectedBy}${message.data.reason != null ? ' (reason: ${message.data.reason})' : ''}',
          );
          _callRejectedController.add(message.data);
          break;

        case CallSignalingResponse.callTimeout:
          final message = CallTimeoutMessage.fromJson(normalizedData);
          CallLogger.logInfo('Call timeout: ${message.data.callId}');
          _callTimeoutController.add(message.data);
          break;

        case CallSignalingResponse.callEnded:
          final message = CallEndedMessage.fromJson(normalizedData);
          CallLogger.logInfo(
            'Call ended: ${message.data.callId} by ${message.data.endedBy}${message.data.durationSeconds != null ? ' (duration: ${message.data.durationSeconds}s)' : ''}',
          );
          _callEndedController.add(message.data);
          break;

        case CallSignalingResponse.callQualityWarning:
          final message = CallQualityWarningMessage.fromJson(normalizedData);
          CallLogger.logInfo('Call quality warning: ${message.data.callId} - quality: ${message.data.quality}');
          _callQualityWarningController.add(message.data);
          break;

        default:
          // This should not happen due to _isCallRelatedMessage check above
          // but keeping for safety
          CallLogger.logDebug('Unhandled call message type: $type');
          break;
      }
    } catch (e, stackTrace) {
      // Log parsing errors but don't crash
      CallLogger.logError('Error parsing call signaling message', error: e, stackTrace: stackTrace);
    }
  }

  /// Check if a message type is call-related
  /// Returns true only for call signaling message types
  bool _isCallRelatedMessage(String type) {
    return type == CallSignalingResponse.callInvitation ||
        type == CallSignalingResponse.callAccepted ||
        type == CallSignalingResponse.callRejected ||
        type == CallSignalingResponse.callEnded ||
        type == CallSignalingResponse.callTimeout ||
        type == CallSignalingResponse.callQualityWarning;
  }

  /// Send a message through the WebSocket
  void _sendMessage(Map<String, dynamic> payload) {
    // Use the generic send method from ChatWebSocketService
    _webSocketService.sendGenericMessage(payload);
  }

  /// Dispose resources
  void dispose() {
    _messageSubscription?.cancel();
    _connectionSubscription?.cancel();
    _callInvitationController.close();
    _callAcceptedController.close();
    _callRejectedController.close();
    _callTimeoutController.close();
    _callEndedController.close();
    _callQualityWarningController.close();
  }
}
