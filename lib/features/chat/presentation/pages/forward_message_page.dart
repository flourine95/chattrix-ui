import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForwardMessagePage extends HookConsumerWidget {
  const ForwardMessagePage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedConversations = useState<Set<int>>({});
    final conversationsAsync = ref.watch(conversationsProvider);
    final me = ref.watch(currentUserProvider);
    final isForwarding = useState(false);
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    // Listen to search input
    useEffect(() {
      void listener() {
        searchQuery.value = searchController.text.toLowerCase();
      }
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    Future<void> handleForward() async {
      if (selectedConversations.value.isEmpty) return;

      isForwarding.value = true;

      try {
        // Forward message using forward API
        final usecase = ref.read(forwardMessageUsecaseProvider);
        final result = await usecase(
          conversationId: message.conversationId,
          messageId: message.id,
          targetConversationIds: selectedConversations.value.toList(),
        );

        result.fold(
          (failure) {
            if (!context.mounted) return;

            // Show error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Failed to forward: ${failure.message}', style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            );
          },
          (forwardedMessages) {
            if (!context.mounted) return;

            // Close forward screen
            context.pop();

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      'Forwarded to ${forwardedMessages.length} conversation(s)',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                backgroundColor: Colors.grey.shade900,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      } catch (e) {
        if (!context.mounted) return;

        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to forward: $e', style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      } finally {
        isForwarding.value = false;
      }
    }

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[850] : Colors.grey[200];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forward to...'),
        actions: [
          if (selectedConversations.value.isNotEmpty && !isForwarding.value)
            TextButton.icon(
              onPressed: handleForward,
              icon: const Icon(Icons.send),
              label: Text('Send (${selectedConversations.value.length})'),
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
              ),
            ),
          if (isForwarding.value)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search conversations',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  suffixIcon: searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () => searchController.clear(),
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),

          // Conversations list
          Expanded(
            child: conversationsAsync.when(
              data: (conversations) {
                if (conversations.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No conversations available', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  );
                }

                // Filter conversations based on search query
                final filteredConversations = searchQuery.value.isEmpty
                    ? conversations
                    : conversations.where((conv) {
                        final name = ConversationUtils.getConversationTitle(conv, me).toLowerCase();
                        return name.contains(searchQuery.value);
                      }).toList();

                if (filteredConversations.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'No conversations found',
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredConversations.length,
                  itemBuilder: (context, index) {
                    final conversation = filteredConversations[index];
                    final isSelected = selectedConversations.value.contains(conversation.id);
                    final conversationName = ConversationUtils.getConversationTitle(conversation, me);
                    final avatarUrl = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);

                    return ListTile(
                      enabled: !isForwarding.value,
                      onTap: isForwarding.value
                          ? null
                          : () {
                              if (isSelected) {
                                selectedConversations.value = {...selectedConversations.value}..remove(conversation.id);
                              } else {
                                selectedConversations.value = {...selectedConversations.value, conversation.id};
                              }
                            },
                      leading: UserAvatar(avatarUrl: avatarUrl, displayName: conversationName, radius: 24),
                      title: Text(
                        conversationName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: conversation.lastMessage != null
                          ? Text(
                              conversation.lastMessage!.content.isNotEmpty
                                  ? conversation.lastMessage!.content
                                  : _getMessageTypeLabel(conversation.lastMessage!.type),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: colors.onSurfaceVariant),
                            )
                          : null,
                      trailing: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? colors.primary : colors.outline,
                            width: 2,
                          ),
                          color: isSelected ? colors.primary : Colors.transparent,
                        ),
                        child: isSelected
                            ? Icon(Icons.check, size: 16, color: colors.onPrimary)
                            : null,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error loading conversations', style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMessageTypeLabel(String type) {
    switch (type.toUpperCase()) {
      case 'IMAGE':
        return '📷 Photo';
      case 'VIDEO':
        return '🎥 Video';
      case 'AUDIO':
      case 'VOICE':
        return '🎤 Voice message';
      case 'DOCUMENT':
      case 'FILE':
        return '📄 Document';
      case 'LOCATION':
        return '📍 Location';
      case 'EMOJI':
        return '😊 Emoji';
      case 'STICKER':
        return '🎭 Sticker';
      default:
        return 'Message';
    }
  }
}
