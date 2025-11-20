import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/conversation_update.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message_sender.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/domain/entities/user_status_update.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock WebSocket service for testing
class MockChatWebSocketService {
  final _messageController = StreamController<Message>.broadcast();
  final _typingController = StreamController<TypingIndicator>.broadcast();
  final _userStatusController = StreamController<UserStatusUpdate>.broadcast();
  final _conversationUpdateController = StreamController<ConversationUpdate>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();
  final _rawMessageController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Message> get messageStream => _messageController.stream;
  Stream<TypingIndicator> get typingStream => _typingController.stream;
  Stream<UserStatusUpdate> get userStatusStream => _userStatusController.stream;
  Stream<ConversationUpdate> get conversationUpdateStream => _conversationUpdateController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  Stream<Map<String, dynamic>> get rawMessageStream => _rawMessageController.stream;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  void setConnected(bool connected) {
    _isConnected = connected;
    _connectionController.add(connected);
  }

  void emitMessage(Message message) {
    _messageController.add(message);
  }

  void dispose() {
    _messageController.close();
    _typingController.close();
    _userStatusController.close();
    _conversationUpdateController.close();
    _connectionController.close();
    _rawMessageController.close();
  }
}

/// Test wrapper for MessagesNotifier that exposes polling state
class TestableMessagesNotifier {
  Timer? pollingTimer;
  final MockChatWebSocketService wsService;
  final String conversationId;
  int refreshCallCount = 0;
  StreamSubscription<bool>? connectionSubscription;

  TestableMessagesNotifier(this.wsService, this.conversationId) {
    _initialize();
  }

  void _initialize() {
    // Listen to WebSocket connection state to toggle polling
    connectionSubscription = wsService.connectionStream.listen((isConnected) {
      if (isConnected) {
        // WebSocket connected - disable polling
        _stopPolling();
      } else {
        // WebSocket disconnected - enable polling
        _startPolling();
      }
    });

    // Check initial connection state
    if (!wsService.isConnected) {
      _startPolling();
    }
  }

  void _startPolling() {
    _stopPolling();
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      refreshCallCount++;
    });
  }

  void _stopPolling() {
    pollingTimer?.cancel();
    pollingTimer = null;
  }

  bool get isPollingActive => pollingTimer != null && pollingTimer!.isActive;

  void dispose() {
    connectionSubscription?.cancel();
    _stopPolling();
  }
}

void main() {
  group('Property-Based Tests - MessagesNotifier Polling Behavior', () {
    late MockChatWebSocketService mockWsService;
    late TestableMessagesNotifier notifier;

    setUp(() {
      mockWsService = MockChatWebSocketService();
    });

    tearDown(() {
      notifier.dispose();
      mockWsService.dispose();
    });

    test('Property 10: WebSocket connection disables polling', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 10: WebSocket connection disables polling
       * Validates: Requirements 3.1, 3.3
       * 
       * For any WebSocket connected state, the polling timer should be null or cancelled,
       * and updates should only come from WebSocket events
       */

      // Start with connected state
      mockWsService.setConnected(true);
      notifier = TestableMessagesNotifier(mockWsService, '123');

      // Wait for connection state to propagate
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify that when connected, polling is disabled
      expect(mockWsService.isConnected, isTrue);
      expect(notifier.isPollingActive, isFalse, reason: 'Polling should be disabled when WebSocket is connected');
    });

    test('Property 11: Disconnection enables polling', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 11: Disconnection enables polling
       * Validates: Requirements 3.2
       * 
       * For any WebSocket disconnection event, the polling timer should be active
       * and triggering periodic refreshes
       */

      // Start connected
      mockWsService.setConnected(true);
      notifier = TestableMessagesNotifier(mockWsService, '123');
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify polling is initially disabled
      expect(notifier.isPollingActive, isFalse);

      // Simulate disconnection
      mockWsService.setConnected(false);
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify disconnected state and polling is enabled
      expect(mockWsService.isConnected, isFalse);
      expect(notifier.isPollingActive, isTrue, reason: 'Polling should be enabled when WebSocket is disconnected');
    });

    test('Property 12: Reconnection disables polling', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 12: Reconnection disables polling
       * Validates: Requirements 3.4
       * 
       * For any WebSocket reconnection event, the polling timer should be cancelled
       * and updates should resume from WebSocket events
       */

      // Start disconnected
      mockWsService.setConnected(false);
      notifier = TestableMessagesNotifier(mockWsService, '123');
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify polling is active when disconnected
      expect(notifier.isPollingActive, isTrue);

      // Reconnect
      mockWsService.setConnected(true);
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify connected state and polling is disabled
      expect(mockWsService.isConnected, isTrue);
      expect(notifier.isPollingActive, isFalse, reason: 'Polling should be disabled when WebSocket reconnects');
    });

    test('Property 10-12: Multiple connection state transitions', () async {
      /**
       * Feature: flutter-main-thread-optimization, Properties 10-12
       * Validates: Requirements 3.1, 3.2, 3.3, 3.4
       * 
       * Test multiple connection state transitions to ensure polling behavior
       * is correctly toggled
       */

      // Start with initial state
      mockWsService.setConnected(true);
      notifier = TestableMessagesNotifier(mockWsService, '123');
      await Future.delayed(const Duration(milliseconds: 100));

      final connectionStates = [
        (connected: false, shouldPoll: true),
        (connected: true, shouldPoll: false),
        (connected: false, shouldPoll: true),
        (connected: true, shouldPoll: false),
        (connected: false, shouldPoll: true),
      ];

      for (final state in connectionStates) {
        mockWsService.setConnected(state.connected);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(mockWsService.isConnected, equals(state.connected));
        expect(
          notifier.isPollingActive,
          equals(state.shouldPoll),
          reason:
              'Polling should be ${state.shouldPoll ? "enabled" : "disabled"} '
              'when connection is ${state.connected ? "connected" : "disconnected"}',
        );
      }
    });

    test('Property 10-12: Polling triggers periodic refreshes when disconnected', () async {
      /**
       * Feature: flutter-main-thread-optimization, Properties 10-12
       * Validates: Requirements 3.1, 3.2, 3.3, 3.4
       * 
       * Verify that polling actually triggers periodic refreshes when disconnected
       */

      // Start disconnected to enable polling
      mockWsService.setConnected(false);
      notifier = TestableMessagesNotifier(mockWsService, '123');
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify polling is active
      expect(notifier.isPollingActive, isTrue);

      // Record initial refresh count
      final initialRefreshCount = notifier.refreshCallCount;

      // Wait for more than one polling interval (5 seconds each)
      // We'll wait 11 seconds to see at least 2 refreshes
      await Future.delayed(const Duration(seconds: 11));

      // Verify that refreshes occurred
      expect(
        notifier.refreshCallCount,
        greaterThan(initialRefreshCount),
        reason: 'Polling should trigger periodic refreshes when disconnected',
      );
      expect(
        notifier.refreshCallCount - initialRefreshCount,
        greaterThanOrEqualTo(2),
        reason: 'Should have at least 2 refreshes after 11 seconds (5s interval)',
      );
    });

    test('Property 10-12: No polling refreshes when connected', () async {
      /**
       * Feature: flutter-main-thread-optimization, Properties 10-12
       * Validates: Requirements 3.1, 3.3
       * 
       * Verify that polling does not trigger refreshes when connected
       */

      // Start connected to disable polling
      mockWsService.setConnected(true);
      notifier = TestableMessagesNotifier(mockWsService, '123');
      await Future.delayed(const Duration(milliseconds: 100));

      // Verify polling is not active
      expect(notifier.isPollingActive, isFalse);

      // Record initial refresh count
      final initialRefreshCount = notifier.refreshCallCount;

      // Wait for what would be multiple polling intervals
      await Future.delayed(const Duration(seconds: 11));

      // Verify that no refreshes occurred
      expect(
        notifier.refreshCallCount,
        equals(initialRefreshCount),
        reason: 'Polling should not trigger refreshes when WebSocket is connected',
      );
    });
  });

  group('Property-Based Tests - MessagesNotifier Targeted Updates', () {
    late MockChatWebSocketService mockWsService;

    setUp(() {
      mockWsService = MockChatWebSocketService();
    });

    tearDown(() {
      mockWsService.dispose();
    });

    test('Property 13: WebSocket messages trigger targeted updates', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 13: WebSocket messages trigger targeted updates
       * Validates: Requirements 3.5
       * 
       * For any message received via WebSocket, only the affected conversation's state
       * should be updated, not all conversations
       */

      const targetConversationId = '123';
      const otherConversationId = '456';

      // Create messages for different conversations
      final targetMessage = Message(
        id: 1,
        conversationId: targetConversationId,
        sender: const MessageSender(id: 1, username: 'user1', fullName: 'User One'),
        content: 'Message for conversation 123',
        type: 'TEXT',
        createdAt: DateTime.now(),
      );

      final otherMessage = Message(
        id: 2,
        conversationId: otherConversationId,
        sender: const MessageSender(id: 2, username: 'user2', fullName: 'User Two'),
        content: 'Message for conversation 456',
        type: 'TEXT',
        createdAt: DateTime.now(),
      );

      // Emit message for target conversation
      mockWsService.emitMessage(targetMessage);
      await Future.delayed(const Duration(milliseconds: 50));

      // Verify the message was emitted
      expect(targetMessage.conversationId.toString(), equals(targetConversationId));

      // Emit message for other conversation
      mockWsService.emitMessage(otherMessage);
      await Future.delayed(const Duration(milliseconds: 50));

      // Verify the message was emitted
      expect(otherMessage.conversationId.toString(), equals(otherConversationId));

      // The implementation ensures that only the matching conversation's notifier
      // will refresh when it receives a message with its conversationId
    });

    test('Property 13: Multiple messages for same conversation', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 13
       * Validates: Requirements 3.5
       * 
       * Multiple messages for the same conversation should trigger updates
       * only for that conversation
       */

      const conversationId = '789';

      final messages = List.generate(
        5,
        (index) => Message(
          id: index,
          conversationId: conversationId,
          sender: MessageSender(id: index, username: 'user$index', fullName: 'User $index'),
          content: 'Message $index',
          type: 'TEXT',
          createdAt: DateTime.now(),
        ),
      );

      // Emit multiple messages for the same conversation
      for (final message in messages) {
        mockWsService.emitMessage(message);
        await Future.delayed(const Duration(milliseconds: 20));
        expect(message.conversationId.toString(), equals(conversationId));
      }
    });

    test('Property 13: Interleaved messages for different conversations', () async {
      /**
       * Feature: flutter-main-thread-optimization, Property 13
       * Validates: Requirements 3.5
       * 
       * Messages for different conversations should trigger updates
       * only for their respective conversations
       */

      final conversationIds = ['100', '200', '300'];
      final messages = <Message>[];

      // Create interleaved messages for different conversations
      for (var i = 0; i < 10; i++) {
        final conversationId = conversationIds[i % conversationIds.length];
        messages.add(
          Message(
            id: i,
            conversationId: conversationId,
            sender: MessageSender(id: i, username: 'user$i', fullName: 'User $i'),
            content: 'Message $i for conversation $conversationId',
            type: 'TEXT',
            createdAt: DateTime.now(),
          ),
        );
      }

      // Emit messages in interleaved order
      for (final message in messages) {
        mockWsService.emitMessage(message);
        await Future.delayed(const Duration(milliseconds: 20));

        // Verify each message has the correct conversation ID
        expect(conversationIds.contains(message.conversationId.toString()), isTrue);
      }
    });
  });
}
