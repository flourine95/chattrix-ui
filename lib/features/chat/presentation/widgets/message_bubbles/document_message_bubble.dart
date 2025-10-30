import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
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
    this.onReactionTap,
    this.onAddReaction,
    this.currentUserId,
    this.replyToMessage,
  });

  final Message message;
  final bool isMe;
  final VoidCallback? onReply;
  final Function(String emoji)? onReactionTap;
  final VoidCallback? onAddReaction;
  final int? currentUserId;
  final Message? replyToMessage;

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
      default:
        return FontAwesomeIcons.file;
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cannot open document')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open document: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor(context, isMe);
    final textTheme = Theme.of(context).textTheme;

    return BaseBubbleContainer(
      isMe: isMe,
      message: message,
      onReply: onReply,
      onReactionTap: onReactionTap,
      onAddReaction: onAddReaction,
      currentUserId: currentUserId,
      replyToMessage: replyToMessage,
      child: InkWell(
        onTap: () => _openDocument(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // File icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getFileIcon(message.fileName),
                  color: textColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // File info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File name
                    Text(
                      message.fileName ?? 'Document',
                      style: textTheme.bodyMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // File size
                    if (message.fileSize != null)
                      Text(
                        formatFileSize(message.fileSize!),
                        style: textTheme.bodySmall?.copyWith(
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                  ],
                ),
              ),

              // Download icon
              Icon(
                Icons.download,
                color: textColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

