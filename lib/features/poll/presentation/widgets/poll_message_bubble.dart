import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/state/messages_notifier.dart';
import 'package:chattrix_ui/features/poll/presentation/providers/poll_actions_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'poll_card.dart';

class PollMessageBubble extends HookConsumerWidget {
  const PollMessageBubble({super.key, required this.message, required this.currentUserId});

  final Message message;
  final int currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poll = message.pollData;

    if (poll == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Poll data not available'),
              const SizedBox(height: 8),
              Text(
                'Message ID: ${message.id}, Type: ${message.type}',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: PollCard(
            key: ValueKey('poll_${poll.id}_${poll.currentUserVotedOptionIds.join('_')}_${poll.totalVoters}'),
            poll: poll,
            currentUserId: currentUserId,
            onVote: (optionIds) async {
              debugPrint('🗳️ [PollVote] Starting vote for poll ${poll.id}, options: $optionIds');
              
              final notifier = ref.read(pollActionsProvider.notifier);
              final result = await notifier.vote(
                conversationId: message.conversationId,
                pollId: poll.id,
                optionIds: optionIds,
              );

              debugPrint('🗳️ [PollVote] Vote result: ${result != null ? 'SUCCESS' : 'FAILED'}');
              
              if (result != null) {
                debugPrint('🗳️ [PollVote] Updating poll data in messages...');
                debugPrint('🗳️ [PollVote] Result currentUserVotedOptionIds: ${result.currentUserVotedOptionIds}');
                
                // ✅ Use the result from API which has correct currentUserVotedOptionIds
                // Update poll data in messages immediately
                ref.read(messagesProvider(message.conversationId).notifier).updatePollData(result);
                
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Voted successfully'), duration: Duration(seconds: 1)));
                }
              } else {
                debugPrint('🗳️ [PollVote] Vote failed!');
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Vote failed'), duration: Duration(seconds: 2)));
                }
              }
            },
            onViewDetail: () {
              context.push('/poll/${poll.conversationId}/${poll.id}');
            },
            onClose: poll.creator.id == currentUserId
                ? () async {
                    final notifier = ref.read(pollActionsProvider.notifier);
                    await notifier.close(conversationId: message.conversationId, pollId: poll.id);
                  }
                : null,
            onDelete: poll.creator.id == currentUserId
                ? () async {
                    final notifier = ref.read(pollActionsProvider.notifier);
                    final success = await notifier.delete(conversationId: message.conversationId, pollId: poll.id);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Poll deleted')));
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
