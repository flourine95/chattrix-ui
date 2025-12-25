import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../providers/search_messages_provider.dart';

class SearchMessagesPage extends HookConsumerWidget {
  const SearchMessagesPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchFocus = useFocusNode();
    final searchQuery = useState('');

    // Auto focus search field
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocus.requestFocus();
      });
      return null;
    }, []);

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          focusNode: searchFocus,
          decoration: InputDecoration(
            hintText: 'Search messages...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
          ),
          style: textTheme.bodyLarge,
          onChanged: (value) {
            searchQuery.value = value;
          },
        ),
        actions: [
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                searchQuery.value = '';
              },
            ),
        ],
      ),
      body: _buildBody(context, ref, searchQuery.value, colors, textTheme),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, String query, ColorScheme colors, TextTheme textTheme) {
    if (query.trim().isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text(
              'Search for messages',
              style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
            ),
          ],
        ),
      );
    }

    // Watch the search provider
    final searchAsync = ref.watch(searchMessagesProvider(conversationId, query));

    return searchAsync.when(
      data: (messages) {
        if (messages.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text(
                  'No messages found',
                  style: textTheme.titleMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) => _buildResultItem(context, ref, messages[index], query, colors, textTheme),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text(
              'Error: ${error.toString()}',
              style: textTheme.bodyMedium?.copyWith(color: colors.error),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(
    BuildContext context,
    WidgetRef ref,
    dynamic message,
    String query,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    final content = message.content ?? '';
    final lowerContent = content.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final matchIndex = lowerContent.indexOf(lowerQuery);

    return InkWell(
      onTap: () {
        // Set message ID to scroll to
        setScrollToMessage(conversationId, message.id);

        // Navigate back to chat view
        context.pop();
        context.pop(); // Pop chat info page too
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.outline.withValues(alpha: 0.2))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            UserAvatar(
              displayName: message.senderFullName ?? message.senderUsername ?? 'Unknown',
              avatarUrl: null,
              radius: 20,
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name + timestamp
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.senderFullName ?? message.senderUsername ?? 'Unknown',
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        _formatTimestamp(message.sentAt ?? message.createdAt),
                        style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Message content with highlight
                  RichText(
                    text: TextSpan(
                      style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                      children: _buildHighlightedText(content, matchIndex, query.length, colors),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(Icons.arrow_forward_ios, size: 16, color: colors.onSurface.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String text, int matchIndex, int matchLength, ColorScheme colors) {
    if (matchIndex == -1) {
      return [TextSpan(text: text)];
    }

    final before = text.substring(0, matchIndex);
    final match = text.substring(matchIndex, matchIndex + matchLength);
    final after = text.substring(matchIndex + matchLength);

    return [
      TextSpan(text: before),
      TextSpan(
        text: match,
        style: TextStyle(
          backgroundColor: colors.primaryContainer,
          color: colors.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(text: after),
    ];
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
