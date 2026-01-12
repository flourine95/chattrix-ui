import 'package:chattrix_ui/core/constants/websocket_events.dart';
import 'package:chattrix_ui/core/network/websocket_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invite_links_list_provider.dart';

part 'invite_links_websocket_provider.g.dart';

@Riverpod(keepAlive: true)
class InviteLinksWebSocketListener extends _$InviteLinksWebSocketListener {
  @override
  bool build() {
    _setupListeners();
    return true;
  }

  void _setupListeners() {
    final messageRouter = ref.read(webSocketMessageRouterProvider);

    final createdStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkCreated);
    createdStream.listen((data) {
      _handleInviteLinkCreated(data);
    });

    final revokedStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkRevoked);
    revokedStream.listen((data) {
      _handleInviteLinkRevoked(data);
    });

    final usedStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkUsed);
    usedStream.listen((data) {
      _handleInviteLinkUsed(data);
    });
  }

  void _handleInviteLinkCreated(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      if (conversationId != null) {
        ref.invalidate(inviteLinksListProvider(conversationId));
      }
    } catch (e) {
      debugPrint('Error handling invite link created event: $e');
    }
  }

  void _handleInviteLinkRevoked(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      if (conversationId != null) {
        ref.invalidate(inviteLinksListProvider(conversationId));
      }
    } catch (e) {
      debugPrint('Error handling invite link revoked event: $e');
    }
  }

  void _handleInviteLinkUsed(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      if (conversationId != null) {
        ref.invalidate(inviteLinksListProvider(conversationId));
      }
    } catch (e) {
      debugPrint('Error handling invite link used event: $e');
    }
  }
}
