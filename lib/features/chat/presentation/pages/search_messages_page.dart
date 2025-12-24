import 'package:flutter/material.dart';

class SearchMessagesPage extends StatefulWidget {
  const SearchMessagesPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<SearchMessagesPage> createState() => _SearchMessagesPageState();
}

class _SearchMessagesPageState extends State<SearchMessagesPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  List<SearchResult> _results = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Auto focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // TODO: Call API to search messages
    // Simulate search with demo data
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _results = _getDemoResults(query);
          _isSearching = false;
        });
      }
    });
  }

  List<SearchResult> _getDemoResults(String query) {
    return [
      SearchResult(
        messageId: '1',
        senderName: 'John Doe',
        senderAvatar: 'https://i.pravatar.cc/150?img=1',
        content: 'Hey, did you see the new design for the project? It looks amazing!',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        matchedText: query,
      ),
      SearchResult(
        messageId: '2',
        senderName: 'Jane Smith',
        senderAvatar: 'https://i.pravatar.cc/150?img=2',
        content: 'I think we should schedule a meeting to discuss the project timeline',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        matchedText: query,
      ),
      SearchResult(
        messageId: '3',
        senderName: 'Bob Wilson',
        senderAvatar: 'https://i.pravatar.cc/150?img=3',
        content: 'The project is coming along nicely. Great work everyone!',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        matchedText: query,
      ),
      SearchResult(
        messageId: '4',
        senderName: 'Alice Brown',
        senderAvatar: 'https://i.pravatar.cc/150?img=4',
        content: 'Can someone share the project files with me? Thanks!',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        matchedText: query,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocus,
          decoration: InputDecoration(
            hintText: 'Search messages...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
          ),
          style: textTheme.bodyLarge,
          onChanged: _performSearch,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: _buildBody(colors, textTheme),
    );
  }

  Widget _buildBody(ColorScheme colors, TextTheme textTheme) {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text(
              'Search for messages',
              style: textTheme.titleMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text(
              'No messages found',
              style: textTheme.titleMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) => _buildResultItem(_results[index], colors, textTheme),
    );
  }

  Widget _buildResultItem(SearchResult result, ColorScheme colors, TextTheme textTheme) {
    final query = _searchController.text.toLowerCase();
    final content = result.content;
    final lowerContent = content.toLowerCase();
    final matchIndex = lowerContent.indexOf(query);

    return InkWell(
      onTap: () {
        // TODO: Navigate to message and highlight it
        Navigator.pop(context, result.messageId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colors.outline.withValues(alpha: 0.2)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(result.senderAvatar),
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
                          result.senderName,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        _formatTimestamp(result.timestamp),
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Message content with highlight
                  RichText(
                    text: TextSpan(
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.8),
                      ),
                      children: _buildHighlightedText(
                        content,
                        matchIndex,
                        query.length,
                        colors,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colors.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(
    String text,
    int matchIndex,
    int matchLength,
    ColorScheme colors,
  ) {
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

class SearchResult {
  final String messageId;
  final String senderName;
  final String senderAvatar;
  final String content;
  final DateTime timestamp;
  final String matchedText;

  SearchResult({
    required this.messageId,
    required this.senderName,
    required this.senderAvatar,
    required this.content,
    required this.timestamp,
    required this.matchedText,
  });
}

