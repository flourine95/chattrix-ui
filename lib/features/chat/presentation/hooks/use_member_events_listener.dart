import 'dart:async';

import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Hook to listen for member join/leave events and add system messages
void useMemberEventsListener(WidgetRef ref, int conversationId) {
  useEffect(() {
    debugPrint('🎯 [MemberEvents] Hook initialized for conversation $conversationId');
    
    StreamSubscription? memberAddedSub;
    StreamSubscription? memberLeftSub;

    // Get WebSocket data source
    final wsDataSource = ref.read(chatWebSocketDataSourceProvider);
    debugPrint('🎯 [MemberEvents] WebSocket data source obtained');

    // Listen to member added events
    memberAddedSub = wsDataSource.conversationMemberAddedStream.listen((data) {
      try {
        debugPrint('📨 [MemberEvents] Received member added event: $data');
        
        final eventConversationId = data['conversationId'] as int?;
        debugPrint('📨 [MemberEvents] Event conversation ID: $eventConversationId, Current: $conversationId');
        
        if (eventConversationId != conversationId) {
          debugPrint('⏭️ [MemberEvents] Skipping - different conversation');
          return;
        }

        debugPrint('👤 [MemberEvents] Member added to conversation $conversationId');
        
        // Create system message
        final members = data['members'] as List?;
        debugPrint('👤 [MemberEvents] Members data: $members');
        
        if (members != null && members.isNotEmpty) {
          final member = members.first as Map<String, dynamic>;
          final username = member['username'] as String?;
          final fullName = member['fullName'] as String?;
          final memberName = fullName ?? username ?? 'Someone';
          
          debugPrint('👤 [MemberEvents] Creating system message for: $memberName');
          
          final systemMessage = Message(
            id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
            conversationId: conversationId,
            senderId: member['id'] as int? ?? 0,
            senderUsername: username,
            senderFullName: fullName,
            content: '$memberName joined the group',
            type: 'SYSTEM',
            metadata: {'systemType': 'MEMBER_JOINED'},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          // Add to messages list
          debugPrint('👤 [MemberEvents] Adding system message to messages provider');
          final messagesNotifier = ref.read(messagesProvider(conversationId).notifier);
          messagesNotifier.addSystemMessage(systemMessage);
          
          debugPrint('✅ [MemberEvents] Added system message for member join');
        } else {
          debugPrint('⚠️ [MemberEvents] No members data in event');
        }
      } catch (e, stackTrace) {
        debugPrint('❌ [MemberEvents] Error handling member added: $e');
        debugPrint('❌ [MemberEvents] Stack trace: $stackTrace');
      }
    });

    // Listen to member left events
    memberLeftSub = wsDataSource.conversationMemberLeftStream.listen((data) {
      try {
        debugPrint('📨 [MemberEvents] Received member left event: $data');
        
        final eventConversationId = data['conversationId'] as int?;
        debugPrint('📨 [MemberEvents] Event conversation ID: $eventConversationId, Current: $conversationId');
        
        if (eventConversationId != conversationId) {
          debugPrint('⏭️ [MemberEvents] Skipping - different conversation');
          return;
        }

        debugPrint('👋 [MemberEvents] Member left conversation $conversationId');
        
        // Create system message
        final member = data['member'] as Map<String, dynamic>?;
        debugPrint('👋 [MemberEvents] Member data: $member');
        
        if (member != null) {
          final username = member['username'] as String?;
          final fullName = member['fullName'] as String?;
          final memberName = fullName ?? username ?? 'Someone';
          
          debugPrint('👋 [MemberEvents] Creating system message for: $memberName');
          
          final systemMessage = Message(
            id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
            conversationId: conversationId,
            senderId: member['id'] as int? ?? 0,
            senderUsername: username,
            senderFullName: fullName,
            content: '$memberName left the group',
            type: 'SYSTEM',
            metadata: {'systemType': 'MEMBER_LEFT'},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          // Add to messages list
          debugPrint('👋 [MemberEvents] Adding system message to messages provider');
          final messagesNotifier = ref.read(messagesProvider(conversationId).notifier);
          messagesNotifier.addSystemMessage(systemMessage);
          
          debugPrint('✅ [MemberEvents] Added system message for member leave');
        } else {
          debugPrint('⚠️ [MemberEvents] No member data in event');
        }
      } catch (e, stackTrace) {
        debugPrint('❌ [MemberEvents] Error handling member left: $e');
        debugPrint('❌ [MemberEvents] Stack trace: $stackTrace');
      }
    });

    debugPrint('🎯 [MemberEvents] Listeners set up successfully');

    return () {
      debugPrint('🎯 [MemberEvents] Cleaning up listeners for conversation $conversationId');
      memberAddedSub?.cancel();
      memberLeftSub?.cancel();
    };
  }, [conversationId]);
}
