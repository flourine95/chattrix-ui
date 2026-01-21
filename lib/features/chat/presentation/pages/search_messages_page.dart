import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:async';
import '../providers/search_messages_provider.dart';

class SearchMessagesPage extends HookConsumerWidget {
  const SearchMessagesPage({super.key, required this.conversationId});

  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchFocus = useFocusNode();
    final searchQuery = useState('');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);

    // Auto focus search field
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchFocus.requestFocus();
      });
      return null;
    }, []);

    // Debounce timer for search
    useEffect(() {
      Timer? debounceTimer;

      void onSearchChanged() {
        debounceTimer?.cancel();
        debounceTimer = Timer(const Duration(milliseconds: 500), () {
          searchQuery.value = searchController.text.trim();
        });
      }

      searchController.addListener(onSearchChanged);

      return () {
        debounceTimer?.cancel();
        searchController.removeListener(onSearchChanged);
      };
    }, [searchController]);

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Search Messages', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchController,
                focusNode: searchFocus,
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            searchController.clear();
                            searchQuery.value = '';
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),

          // Results
          Expanded(
            child: _buildBody(context, ref, searchQuery.value, colors, textTheme, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, String query, ColorScheme colors, TextTheme textTheme, bool isDark) {
    if (query.trim().isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Search for messages',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Type to search in this conversation',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
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
                Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No messages found',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try a different search term',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: messages.length,
          separatorBuilder: (_, _) => Divider(
            height: 1,
            thickness: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
            indent: 64,
          ),
          itemBuilder: (context, index) => _buildResultItem(context, ref, messages[index], query, colors, textTheme),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Search failed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red[700]),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
