import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';

/// Debug page to monitor WebSocket events in real-time
class WebSocketDebugPage extends HookConsumerWidget {
  const WebSocketDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);
    final events = useState<List<DebugEvent>>([]);
    final isConnected = useState<bool>(wsDataSource.isConnected);
    final autoScroll = useState<bool>(true);
    final scrollController = useScrollController();

    // Listen to connection status
    useEffect(() {
      // Set initial connection state
      isConnected.value = wsDataSource.isConnected;

      final sub = wsDataSource.connectionStream.listen((connected) {
        isConnected.value = connected;
        events.value = [
          DebugEvent(
            timestamp: DateTime.now(),
            type: 'CONNECTION',
            data: {'connected': connected},
            raw: 'Connection: ${connected ? "CONNECTED" : "DISCONNECTED"}',
          ),
          ...events.value,
        ];
      });
      return sub.cancel;
    }, []);

    // Listen to raw WebSocket messages
    useEffect(() {
      final sub = wsDataSource.rawMessageStream.listen((message) {
        events.value = [
          DebugEvent(timestamp: DateTime.now(), type: 'RAW_MESSAGE', data: message, raw: jsonEncode(message)),
          ...events.value,
        ];

        // Auto scroll to top
        if (autoScroll.value && scrollController.hasClients) {
          scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
      return sub.cancel;
    }, []);

    // Listen to parsed user status events
    useEffect(() {
      final sub = wsDataSource.userStatusStream.listen((status) {
        events.value = [
          DebugEvent(
            timestamp: DateTime.now(),
            type: 'USER_STATUS',
            data: {
              'userId': status.userId,
              'username': status.username,
              'displayName': status.displayName,
              'isOnline': status.isOnline,
              'lastSeen': status.lastSeen,
            },
            raw: 'User ${status.username} is now ${status.isOnline ? "ONLINE" : "OFFLINE"}',
          ),
          ...events.value,
        ];
      });
      return sub.cancel;
    }, []);

    // Listen to message events
    useEffect(() {
      final sub = wsDataSource.messageStream.listen((message) {
        events.value = [
          DebugEvent(
            timestamp: DateTime.now(),
            type: 'MESSAGE',
            data: {
              'id': message.id,
              'conversationId': message.conversationId,
              'senderId': message.senderId,
              'content': message.content,
            },
            raw: 'Message from ${message.senderUsername}: ${message.content}',
          ),
          ...events.value,
        ];
      });
      return sub.cancel;
    }, []);

    // Listen to typing events
    useEffect(() {
      final sub = wsDataSource.typingStream.listen((typing) {
        events.value = [
          DebugEvent(
            timestamp: DateTime.now(),
            type: 'TYPING',
            data: {
              'conversationId': typing.conversationId,
              'typingUsers': typing.typingUsers.map((u) => u.username).toList(),
            },
            raw:
                'Typing in conversation ${typing.conversationId}: ${typing.typingUsers.map((u) => u.username).join(", ")}',
          ),
          ...events.value,
        ];
      });
      return sub.cancel;
    }, []);

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Debug'),
        actions: [
          // Connection status indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isConnected.value ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(isConnected.value ? 'Connected' : 'Disconnected', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          // Auto-scroll toggle
          IconButton(
            icon: Icon(autoScroll.value ? Icons.arrow_downward : Icons.arrow_downward_outlined),
            onPressed: () => autoScroll.value = !autoScroll.value,
            tooltip: 'Auto-scroll',
          ),
          // Clear events
          IconButton(icon: const Icon(Icons.clear_all), onPressed: () => events.value = [], tooltip: 'Clear'),
        ],
      ),
      body: events.value.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_tethering, size: 64, color: colors.outline),
                  const SizedBox(height: 16),
                  Text(
                    'Waiting for WebSocket events...',
                    style: theme.textTheme.bodyLarge?.copyWith(color: colors.outline),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Send a message or change user status to see events',
                    style: theme.textTheme.bodySmall?.copyWith(color: colors.outline),
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: events.value.length,
              itemBuilder: (context, index) {
                final event = events.value[index];
                return _EventCard(event: event);
              },
            ),
    );
  }
}

class DebugEvent {
  final DateTime timestamp;
  final String type;
  final Map<String, dynamic> data;
  final String raw;

  DebugEvent({required this.timestamp, required this.type, required this.data, required this.raw});
}

class _EventCard extends StatelessWidget {
  final DebugEvent event;

  const _EventCard({required this.event});

  Color _getTypeColor(String type) {
    switch (type) {
      case 'CONNECTION':
        return Colors.blue;
      case 'USER_STATUS':
        return Colors.green;
      case 'MESSAGE':
        return Colors.purple;
      case 'TYPING':
        return Colors.orange;
      case 'RAW_MESSAGE':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'CONNECTION':
        return Icons.wifi;
      case 'USER_STATUS':
        return Icons.person;
      case 'MESSAGE':
        return Icons.message;
      case 'TYPING':
        return Icons.keyboard;
      case 'RAW_MESSAGE':
        return Icons.code;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final typeColor = _getTypeColor(event.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: Icon(_getTypeIcon(event.type), color: typeColor),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: typeColor.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
              child: Text(
                event.type,
                style: theme.textTheme.labelSmall?.copyWith(color: typeColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(event.raw, style: theme.textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        subtitle: Text(
          _formatTimestamp(event.timestamp),
          style: theme.textTheme.bodySmall?.copyWith(color: colors.outline),
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: colors.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Raw text
                Row(
                  children: [
                    Expanded(child: SelectableText(event.raw, style: theme.textTheme.bodyMedium)),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: event.raw));
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                      },
                      tooltip: 'Copy',
                    ),
                  ],
                ),
                const Divider(),
                // JSON data
                Text('Data:', style: theme.textTheme.labelLarge),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.outline.withOpacity(0.2)),
                  ),
                  child: SelectableText(
                    const JsonEncoder.withIndent('  ').convert(event.data),
                    style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}.'
        '${timestamp.millisecond.toString().padLeft(3, '0')}';
  }
}
