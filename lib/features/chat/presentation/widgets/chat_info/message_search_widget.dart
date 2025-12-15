import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageSearchWidget extends HookConsumerWidget {
  const MessageSearchWidget({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final selectedMessageType = useState<String?>('ALL');
    final sortOrder = useState<String>('DESC'); // DESC = newest first
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final messagesAsync = ref.watch(messagesProvider(conversationId));
    final me = ref.watch(currentUserProvider);

    // Debounce search
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        searchQuery.value = searchController.text;
      });
      return () {};
    }, [searchController.text]);

    return Column(
      children: [
        // Search bar and filters
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(bottom: BorderSide(color: colors.onSurface.withValues(alpha: 0.1))),
          ),
          child: Column(
            children: [
              // Search input
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            searchQuery.value = '';
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colors.surface.withValues(alpha: 0.6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Filters row
              Row(
                children: [
                  // Message type filter
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedMessageType.value,
                      decoration: InputDecoration(
                        labelText: 'Loại tin nhắn',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'ALL', child: Text('Tất cả')),
                        DropdownMenuItem(value: 'TEXT', child: Text('Văn bản')),
                        DropdownMenuItem(value: 'IMAGE', child: Text('Hình ảnh')),
                        DropdownMenuItem(value: 'VIDEO', child: Text('Video')),
                        DropdownMenuItem(value: 'AUDIO', child: Text('Audio')),
                        DropdownMenuItem(value: 'DOCUMENT', child: Text('Tài liệu')),
                        DropdownMenuItem(value: 'LOCATION', child: Text('Vị trí')),
                      ],
                      onChanged: (value) {
                        selectedMessageType.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Sort order
                  IconButton(
                    icon: Icon(sortOrder.value == 'DESC' ? Icons.arrow_downward : Icons.arrow_upward),
                    tooltip: sortOrder.value == 'DESC' ? 'Mới nhất trước' : 'Cũ nhất trước',
                    onPressed: () {
                      sortOrder.value = sortOrder.value == 'DESC' ? 'ASC' : 'DESC';
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // Search results
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              // Filter messages
              var filteredMessages = messages.where((m) {
                // Filter by search query
                if (searchQuery.value.isNotEmpty) {
                  final query = searchQuery.value.toLowerCase();
                  if (!m.content.toLowerCase().contains(query)) {
                    return false;
                  }
                }

                // Filter by message type
                if (selectedMessageType.value != null && selectedMessageType.value != 'ALL') {
                  if (m.type.toUpperCase() != selectedMessageType.value) {
                    return false;
                  }
                }

                return true;
              }).toList();

              // Sort messages
              if (sortOrder.value == 'ASC') {
                filteredMessages = filteredMessages.reversed.toList();
              }

              if (filteredMessages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        searchQuery.value.isEmpty ? 'Enter keywords to search' : 'No messages found',
                        style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  return _SearchResultItem(
                    message: message,
                    searchQuery: searchQuery.value,
                    isMe: message.senderId == me?.id,
                    onTap: () {
                      // Navigate back to chat and scroll to message
                      context.pop();
                      // TODO: Implement scroll to message
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Failed to load messages', style: textTheme.bodyMedium)),
          ),
        ),
      ],
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.message, required this.searchQuery, required this.isMe, required this.onTap});

  final Message message;
  final String searchQuery;
  final bool isMe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.onSurface.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender and date
            Row(
              children: [
                Expanded(
                  child: Text(
                    isMe ? 'Bạn' : (message.senderFullName ?? message.senderUsername ?? 'User'),
                    style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colors.primary),
                  ),
                ),
                Text(
                  FormatUtils.formatDateTime(message.createdAt),
                  style: textTheme.labelSmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Message content with highlight
            _buildHighlightedContent(context),

            // Message type badge
            if (message.type.toUpperCase() != 'TEXT') ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_getMessageTypeIcon(), size: 14, color: colors.primary),
                    const SizedBox(width: 4),
                    Text(_getMessageTypeLabel(), style: textTheme.labelSmall?.copyWith(color: colors.primary)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    if (searchQuery.isEmpty) {
      return Text(message.content, style: textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis);
    }

    // Highlight search query in content
    final content = message.content;
    final query = searchQuery.toLowerCase();
    final lowerContent = content.toLowerCase();
    final index = lowerContent.indexOf(query);

    if (index == -1) {
      return Text(content, style: textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis);
    }

    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: textTheme.bodyMedium,
        children: [
          TextSpan(text: content.substring(0, index)),
          TextSpan(
            text: content.substring(index, index + query.length),
            style: TextStyle(backgroundColor: colors.primary.withValues(alpha: 0.3), fontWeight: FontWeight.bold),
          ),
          TextSpan(text: content.substring(index + query.length)),
        ],
      ),
    );
  }

  IconData _getMessageTypeIcon() {
    switch (message.type.toUpperCase()) {
      case 'IMAGE':
        return Icons.image;
      case 'VIDEO':
        return Icons.videocam;
      case 'AUDIO':
        return Icons.audiotrack;
      case 'DOCUMENT':
        return Icons.insert_drive_file;
      case 'LOCATION':
        return Icons.location_on;
      default:
        return Icons.message;
    }
  }

  String _getMessageTypeLabel() {
    switch (message.type.toUpperCase()) {
      case 'IMAGE':
        return 'Hình ảnh';
      case 'VIDEO':
        return 'Video';
      case 'AUDIO':
        return 'Audio';
      case 'DOCUMENT':
        return 'Tài liệu';
      case 'LOCATION':
        return 'Vị trí';
      default:
        return message.type;
    }
  }
}
