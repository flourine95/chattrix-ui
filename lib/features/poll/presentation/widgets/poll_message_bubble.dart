import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../chat/domain/entities/message.dart';
import '../providers/poll_actions_provider.dart';
import 'poll_card.dart';

/// Poll displayed as centered message in chat (like system message)
///
/// This widget wraps PollCard and centers it in the chat
class PollMessageBubble extends HookConsumerWidget {
  const PollMessageBubble({super.key, required this.message, required this.currentUserId});

  final Message message;
  final int currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poll = message.pollData;

    // If no poll data, show error
    if (poll == null) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(16), child: Text('Poll data not available')),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: PollCard(
            poll: poll,
            currentUserId: currentUserId,
            onVote: (optionIds) async {
              final notifier = ref.read(pollActionsProvider.notifier);
              await notifier.vote(pollId: poll.id, optionIds: optionIds);
            },
            onViewDetail: () {
              context.push('/poll/${poll.id}');
            },
            onClose: poll.creator.id == currentUserId
                ? () async {
                    final notifier = ref.read(pollActionsProvider.notifier);
                    await notifier.close(pollId: poll.id);
                  }
                : null,
            onDelete: poll.creator.id == currentUserId
                ? () async {
                    final notifier = ref.read(pollActionsProvider.notifier);
                    final success = await notifier.delete(pollId: poll.id);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Poll đã được xóa')));
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
