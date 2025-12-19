import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';

/// Debug page to inspect participant data
class ParticipantDebugPage extends ConsumerWidget {
  const ParticipantDebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Participant Data Debug'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(conversationsProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return const Center(child: Text('No conversations'));
          }

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text('Conversation ${conversation.id}'),
                  subtitle: Text('${conversation.participants.length} participants'),
                  children: conversation.participants.map((participant) {
                    return ListTile(
                      title: Text(participant.fullName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User ID: ${participant.userId}'),
                          Text('Username: ${participant.username}'),
                          Text('Online: ${participant.online}'),
                          Text('Last Seen: ${participant.lastSeen}'),
                          const SizedBox(height: 8),
                          // Raw data
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colors.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SelectableText(
                              'Participant(\n'
                              '  userId: ${participant.userId},\n'
                              '  username: ${participant.username},\n'
                              '  fullName: ${participant.fullName},\n'
                              '  online: ${participant.online},\n'
                              '  lastSeen: ${participant.lastSeen},\n'
                              ')',
                              style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text:
                                  'Participant(\n'
                                  '  userId: ${participant.userId},\n'
                                  '  username: ${participant.username},\n'
                                  '  fullName: ${participant.fullName},\n'
                                  '  online: ${participant.online},\n'
                                  '  lastSeen: ${participant.lastSeen},\n'
                                  ')',
                            ),
                          );
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
      ),
    );
  }
}
