import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/reply_to_message.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/format_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Document/File message bubble with download functionality
class DocumentMessageBubble extends StatelessWidget {
  const DocumentMessageBubble({
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
  final bool isGroup;
  final bool isLastMessage;

  bool _isUrl(String? text) {
    if (text == null) return false;
    return text.startsWith('http://') || text.startsWith('https://');
  }

  IconData _getFileIcon(String? fileName) {
    if (fileName == null) return FontAwesomeIcons.file;

    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return FontAwesomeIcons.filePdf;
      case 'doc':
      case 'docx':
        return FontAwesomeIcons.fileWord;
      case 'xls':
      case 'xlsx':
        return FontAwesomeIcons.fileExcel;
      case 'ppt':
      case 'pptx':
        return FontAwesomeIcons.filePowerpoint;
      case 'zip':
      case 'rar':
        return FontAwesomeIcons.fileZipper;
      case 'txt':
        return FontAwesomeIcons.fileLines;
      default:
        return FontAwesomeIcons.file;
    }
  }

  Color _getFileColor(String? fileName) {
    if (fileName == null) return Colors.grey;

    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      case 'zip':
      case 'rar':
        return Colors.purple;
      case 'txt':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Future<void> _openDocument(BuildContext context) async {
    if (message.mediaUrl == null) return;

    try {
      final uri = Uri.parse(message.mediaUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot open document')));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to open document: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = FormatUtils.getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Check if this is a link
    final isLink = _isUrl(message.content);

    return BaseBubbleContainer(
      isMe: isMe,
      message: message,
      maxWidth: isLink ? 320.0 : 280.0,
      onReply: onReply,
      onPin: onPin,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      onEdit: onEdit,
      onDelete: onDelete,
      isGroup: isGroup,
      isLastMessage: isLastMessage,
      child: InkWell(
        onTap: () => _openDocument(context),
        borderRadius: BorderRadius.circular(16),
        child: isLink
            ? _buildLinkPreview(context, textColor, textTheme, isDark)
            : _buildFilePreview(context, textColor, textTheme),
      ),
    );
  }

  Widget _buildFilePreview(BuildContext context, Color textColor, TextTheme textTheme) {
    final fileColor = _getFileColor(message.fileName);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // File icon with color
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: fileColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(_getFileIcon(message.fileName), color: fileColor, size: 24),
          ),
          const SizedBox(width: 12),

          // File info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File name
                Text(
                  message.content.isNotEmpty ? message.content : (message.fileName ?? 'Document'),
                  style: textTheme.bodyMedium?.copyWith(color: textColor, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // File size and type
                Row(
                  children: [
                    if (message.fileSize != null) ...[
                      Text(
                        FormatUtils.formatFileSize(message.fileSize!),
                        style: textTheme.bodySmall?.copyWith(color: textColor.withValues(alpha: 0.7)),
                      ),
                      if (message.fileName != null) ...[
                        Text(' • ', style: textTheme.bodySmall?.copyWith(color: textColor.withValues(alpha: 0.7))),
                        Text(
                          message.fileName!.split('.').last.toUpperCase(),
                          style: textTheme.bodySmall?.copyWith(
                            color: textColor.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ] else if (message.fileName != null)
                      Text(
                        message.fileName!.split('.').last.toUpperCase(),
                        style: textTheme.bodySmall?.copyWith(
                          color: textColor.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Download icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: fileColor.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(Icons.download_rounded, color: fileColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkPreview(BuildContext context, Color textColor, TextTheme textTheme, bool isDark) {
    final uri = Uri.tryParse(message.content);
    final domain = uri?.host ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Link preview image (if available from mediaUrl)
        if (message.mediaUrl != null && message.mediaUrl!.isNotEmpty)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: message.mediaUrl!,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 160,
                color: Colors.grey.shade300,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 160,
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                child: Icon(Icons.link, size: 48, color: textColor.withValues(alpha: 0.5)),
              ),
            ),
          ),

        // Link info
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Domain with icon
              Row(
                children: [
                  Icon(Icons.link, size: 16, color: textColor.withValues(alpha: 0.7)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      domain,
                      style: textTheme.bodySmall?.copyWith(
                        color: textColor.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Link URL
              Text(
                message.content,
                style: textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // File name if available
              if (message.fileName != null && message.fileName!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  message.fileName!,
                  style: textTheme.bodySmall?.copyWith(color: textColor.withValues(alpha: 0.7)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
