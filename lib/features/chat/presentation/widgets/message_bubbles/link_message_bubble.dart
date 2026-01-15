import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:url_launcher/url_launcher.dart';

// Global cache for link previews to avoid re-fetching
final Map<String, Map<String, dynamic>> _previewCache = {};

/// Link message bubble - displays link preview with custom implementation
/// Shows text + preview card with image and metadata (Messenger style)
class LinkMessageBubble extends StatefulWidget {
  const LinkMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onPin,
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
    this.onEdit,
    this.onDelete,
    this.onForward,
    this.onScrollToMessage,
    this.isGroup = false,
    this.isLastMessage = false,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onPin;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final ReplyToMessage? replyToMessage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onForward;
  final Function(int messageId)? onScrollToMessage;
  final bool isGroup;
  final bool isLastMessage;

  @override
  State<LinkMessageBubble> createState() => _LinkMessageBubbleState();
}

class _LinkMessageBubbleState extends State<LinkMessageBubble> {
  Map<String, dynamic>? _previewData;
  bool _isLoading = false;
  bool _hasFailed = false;

  @override
  void initState() {
    super.initState();
    // Extract URL and fetch preview safely
    try {
      final urlRegex = RegExp(r'https?://[^\s]+');
      final urlMatch = urlRegex.firstMatch(widget.message.content);
      if (urlMatch != null) {
        final extractedUrl = urlMatch.group(0)!;
        debugPrint('🔗 [LinkBubble] initState for URL: $extractedUrl');
        
        // Check cache first
        if (_previewCache.containsKey(extractedUrl)) {
          final cachedData = _previewCache[extractedUrl];
          debugPrint('📦 Using cached preview for: $extractedUrl');
          
          // Check if cache contains failure marker
          if (cachedData?['failed'] == true) {
            _previewData = null;
            _isLoading = false;
            _hasFailed = true;
            debugPrint('❌ Cache shows previous failure for: $extractedUrl');
          } else {
            _previewData = cachedData;
            _isLoading = false;
            _hasFailed = false;
            debugPrint('✅ Loaded from cache: ${cachedData?['title']}');
          }
        } else {
          // Start loading immediately
          debugPrint('🔄 Starting fetch for: $extractedUrl');
          _isLoading = true;
          _hasFailed = false;
          
          // Fetch preview asynchronously without blocking widget render
          _fetchPreview(extractedUrl);
        }
      } else {
        // No URL found, mark as failed
        debugPrint('❌ No URL found in content: ${widget.message.content}');
        _isLoading = false;
        _hasFailed = true;
      }
    } catch (e) {
      debugPrint('❌ Error in initState: $e');
      _isLoading = false;
      _hasFailed = true;
    }
  }

  Future<void> _fetchPreview(String linkUrl) async {
    debugPrint('🌐 [LinkBubble] Starting fetch for: $linkUrl');
    
    // Set loading state if widget is still mounted
    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      // Skip preview for known problematic domains
      final domain = _extractDomain(linkUrl).toLowerCase();
      if (domain.contains('facebook.com') || 
          domain.contains('fb.com') ||
          domain.contains('instagram.com') ||
          domain.contains('twitter.com') ||
          domain.contains('x.com')) {
        debugPrint('⚠️ Skipping preview for $domain (known to block scraping)');
        
        // Cache the failure BEFORE checking mounted
        _previewCache[linkUrl] = {'failed': true};
        
        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasFailed = true;
          });
        }
        return;
      }

      debugPrint('📡 [LinkBubble] Fetching HTML for: $linkUrl');
      final dio = Dio();
      final response = await dio.get(
        linkUrl,
        options: Options(
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
          },
          followRedirects: true,
          validateStatus: (status) => status! < 500,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      debugPrint('✅ [LinkBubble] Got response, parsing HTML...');
      final document = html_parser.parse(response.data);

      // Extract Open Graph tags
      String? title = document.querySelector('meta[property="og:title"]')?.attributes['content'];
      if (title == null || title.isEmpty) {
        title = document.querySelector('title')?.text;
      }

      String? description = document.querySelector('meta[property="og:description"]')?.attributes['content'];
      if (description == null || description.isEmpty) {
        description = document.querySelector('meta[name="description"]')?.attributes['content'];
      }

      String? image = document.querySelector('meta[property="og:image"]')?.attributes['content'];
      if (image == null || image.isEmpty) {
        image = document.querySelector('meta[name="twitter:image"]')?.attributes['content'];
      }

      final domainName = _extractDomain(linkUrl);

      debugPrint('📝 [LinkBubble] Extracted - Title: $title, Image: ${image != null ? "Yes" : "No"}');

      // Check if we got valid data (not a login page)
      if (title != null && 
          title.isNotEmpty &&
          !title.toLowerCase().contains('đăng nhập') && 
          !title.toLowerCase().contains('login') &&
          !title.toLowerCase().contains('sign in') &&
          !title.toLowerCase().contains('log in')) {
        
        final previewData = {
          'title': title,
          'description': description,
          'image': image,
          'domain': domainName,
        };
        
        // Cache the preview data BEFORE checking mounted
        // This ensures cache persists even if widget is disposed
        _previewCache[linkUrl] = previewData;
        debugPrint('✅ Preview fetched and cached: $title');
        
        // Update widget state only if still mounted
        if (mounted) {
          setState(() {
            _previewData = previewData;
            _isLoading = false;
            _hasFailed = false;
          });
          debugPrint('🎨 [LinkBubble] Updated widget state with preview');
        } else {
          debugPrint('⚠️ [LinkBubble] Widget disposed, but cache updated');
        }
      } else {
        throw Exception('Invalid preview data (login page detected)');
      }
    } catch (e) {
      debugPrint('❌ Error fetching preview for $linkUrl: $e');
      
      // Cache the failure BEFORE checking mounted
      _previewCache[linkUrl] = {'failed': true};
      
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasFailed = true;
        });
      }
    }
  }

  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (e) {
      return url;
    }
  }

  Future<void> _openLink(String url) async {
    try {
      debugPrint('🔗 Attempting to open URL: $url');
      
      // Ensure URL has protocol
      String finalUrl = url;
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        finalUrl = 'https://$url';
        debugPrint('🔗 Added https:// prefix: $finalUrl');
      }
      
      final uri = Uri.parse(finalUrl);
      debugPrint('🔗 Parsed URI: $uri');
      
      if (await canLaunchUrl(uri)) {
        debugPrint('🔗 Can launch URL, opening...');
        final result = await launchUrl(uri, mode: LaunchMode.externalApplication);
        debugPrint('🔗 Launch result: $result');
      } else {
        debugPrint('❌ Cannot launch URL: $uri');
        // Show error to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể mở link: $url')),
          );
        }
      }
    } catch (e) {
      debugPrint('❌ Error opening URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi mở link: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final textColor = FormatUtils.getTextColor(context, widget.isMe);
      final textTheme = Theme.of(context).textTheme;
      final isDark = Theme.of(context).brightness == Brightness.dark;

      // Extract URL from metadata or content
      final metadata = widget.message.metadata;
      String linkUrl = metadata?['url'] as String? ?? widget.message.content;
      
      // If content has both text and URL, extract the URL
      final urlRegex = RegExp(r'https?://[^\s]+');
      final urlMatch = urlRegex.firstMatch(widget.message.content);
      if (urlMatch != null) {
        linkUrl = urlMatch.group(0)!;
      }

      // Check if there's text content besides the URL
      final textWithoutUrl = widget.message.content.replaceAll(urlRegex, '').trim();
      final hasTextContent = textWithoutUrl.isNotEmpty;

    return BaseBubbleContainer(
      isMe: widget.isMe,
      maxWidth: 320,
      message: widget.message,
      onReply: widget.onReply,
      onPin: widget.onPin,
      onReactionTap: widget.onReactionTap,
      onAddReaction: widget.onAddReaction,
      currentUserId: widget.currentUserId,
      replyToMessage: widget.replyToMessage,
      onEdit: widget.onEdit,
      onDelete: widget.onDelete,
      onForward: widget.onForward,
      onScrollToMessage: widget.onScrollToMessage,
      isGroup: widget.isGroup,
      isLastMessage: widget.isLastMessage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text content in bubble (if different from URL)
          if (hasTextContent)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                textWithoutUrl,
                style: textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ),

          // URL display (always show)
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => _openLink(linkUrl),
              child: Text(
                linkUrl,
                style: textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

          // Link preview card
          if (_isLoading)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade900.withValues(alpha: 0.5)
                    : Colors.grey.shade200.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else if (_previewData != null && !_hasFailed)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade900.withValues(alpha: 0.5)
                    : Colors.grey.shade200.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: InkWell(
                onTap: () => _openLink(linkUrl),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Preview image
                    if (_previewData!['image'] != null && _previewData!['image'].toString().isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _previewData!['image'],
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 200,
                            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox.shrink(),
                        ),
                      ),

                    // Link metadata
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Domain
                          Text(
                            _previewData!['domain'] ?? '',
                            style: textTheme.labelSmall?.copyWith(
                              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Title
                          if (_previewData!['title'] != null && _previewData!['title'].toString().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              _previewData!['title'],
                              style: textTheme.bodySmall?.copyWith(
                                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],

                          // Description
                          if (_previewData!['description'] != null && _previewData!['description'].toString().isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              _previewData!['description'],
                              style: textTheme.bodySmall?.copyWith(
                                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                                fontSize: 11,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
    } catch (e, stackTrace) {
      debugPrint('❌ Error rendering LinkMessageBubble: $e');
      debugPrint('Stack trace: $stackTrace');
      // Fallback: Show simple text message
      return BaseBubbleContainer(
        isMe: widget.isMe,
        maxWidth: 320,
        message: widget.message,
        onReply: widget.onReply,
        onPin: widget.onPin,
        onReactionTap: widget.onReactionTap,
        onAddReaction: widget.onAddReaction,
        currentUserId: widget.currentUserId,
        replyToMessage: widget.replyToMessage,
        onEdit: widget.onEdit,
        onDelete: widget.onDelete,
        onForward: widget.onForward,
        onScrollToMessage: widget.onScrollToMessage,
        isGroup: widget.isGroup,
        isLastMessage: widget.isLastMessage,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            widget.message.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: FormatUtils.getTextColor(context, widget.isMe),
            ),
          ),
        ),
      );
    }
  }
}
