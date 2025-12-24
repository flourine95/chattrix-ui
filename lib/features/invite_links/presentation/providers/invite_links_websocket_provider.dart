import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/constants/websocket_events.dart';
import '../../../../core/network/websocket_providers.dart';
import 'invite_links_list_provider.dart';

part 'invite_links_websocket_provider.g.dart';

/// Provider for listening to invite link WebSocket events
@Riverpod(keepAlive: true)
class InviteLinksWebSocketListener extends _$InviteLinksWebSocketListener {
  @override
  bool build() {
    _setupListeners();
    return true;
  }

  void _setupListeners() {
    final messageRouter = ref.read(webSocketMessageRouterProvider);

    // Listen for invite link created events
    final createdStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkCreated);
    createdStream.listen((data) {
      debugPrint('Invite link created: $data');
      _handleInviteLinkCreated(data);
    });

    // Listen for invite link revoked events
    final revokedStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkRevoked);
    revokedStream.listen((data) {
      debugPrint('Invite link revoked: $data');
      _handleInviteLinkRevoked(data);
    });

    // Listen for invite link used events
    final usedStream = messageRouter.getStreamForType(WebSocketEvents.inviteLinkUsed);
    usedStream.listen((data) {
      debugPrint('Invite link used: $data');
      _handleInviteLinkUsed(data);
    });

    debugPrint('Invite links WebSocket listeners set up');
  }

  void _handleInviteLinkCreated(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversationId'] as int?;
      if (conversationId != null) {
        // Invalidate the list to refresh
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
        // Invalidate the list to refresh
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
        // Invalidate the list to refresh
        ref.invalidate(inviteLinksListProvider(conversationId));
      }
    } catch (e) {
      debugPrint('Error handling invite link used event: $e');
    }
  }
}
