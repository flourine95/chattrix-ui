import 'dart:async';
import 'dart:io';

import 'package:chattrix_ui/core/services/cloudinary_provider.dart';
import 'package:chattrix_ui/core/services/media_picker_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/attachment_picker_bottom_sheet.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/edit_message_dialog.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_reactions.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/voice_recorder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId, this.name, this.color});

  final String chatId;
  final String? name;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final scrollController = useScrollController();
    final showScrollButton = useState(false);
    final previousMessageCount = useRef(0);
    final previousFirstMessageId = useRef<int?>(
      null,
    ); // Track first message ID to detect changes
    final shouldAutoScroll = useRef(true); // Track if we should auto-scroll
    final hasNewMessages = useState(
      false,
    ); // Track if there are new messages while scrolled up
    final replyToMessage = useState<Message?>(
      null,
    ); // Track message being replied to

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final avatarColor = color ?? colors.primary;

    final r = (avatarColor.r * 255).round();
    final g = (avatarColor.g * 255).round();
    final b = (avatarColor.b * 255).round();

    final brightness = (r * 0.299 + g * 0.587 + b * 0.114) / 255;

    final onAvatarColor = brightness < 0.5 ? Colors.white : Colors.black;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));
    final wsConnection = ref.watch(webSocketConnectionProvider);
    final wsService = ref.watch(chatWebSocketServiceProvider);

    // Get conversation to show user status
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.value?.firstWhere(
      (c) => c.id.toString() == chatId,
      orElse: () => conversationsAsync.value!.first,
    );

    // WebSocket connection is automatically initialized by watching webSocketConnectionProvider above
    // No need for manual initialization

    // Listen to scroll position to show/hide scroll button
    // With reverse: true, position 0 is at bottom (newest), scrolling up increases position
    useEffect(() {
      void onScroll() {
        if (scrollController.hasClients) {
          final pixels = scrollController.position.pixels;
          // With reverse ListView, pixels = 0 means at bottom (newest messages)
          final isAtBottom = pixels <= 100;

          showScrollButton.value = !isAtBottom;

          // Update shouldAutoScroll based on scroll position
          shouldAutoScroll.value = isAtBottom;

          // Clear "new message" indicator when user scrolls to bottom
          if (isAtBottom && hasNewMessages.value) {
            hasNewMessages.value = false;
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    // Scroll to bottom when new message arrives
    useEffect(() {
      messagesAsync.whenData((messages) {
        final newCount = messages.length;
        final oldCount = previousMessageCount.value;
        final newFirstId = messages.isNotEmpty ? messages.first.id : null;
        final oldFirstId = previousFirstMessageId.value;

        // Detect new message by comparing first message ID (newest message)
        // This works even when message count stays the same (e.g., at page size limit)
        final hasNewMessage =
            (oldFirstId != null &&
                newFirstId != null &&
                newFirstId != oldFirstId) ||
            (newCount > oldCount && oldCount > 0);

        if (hasNewMessage) {
          if (shouldAutoScroll.value) {
            // User is at bottom - auto-scroll to new message
            hasNewMessages.value = false;

            // With reverse ListView, scroll to position 0 (bottom)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
            });
          } else {
            // User is reading old messages - show "New Message" indicator
            hasNewMessages.value = true;
          }
        }

        previousMessageCount.value = newCount;
        previousFirstMessageId.value = newFirstId;
      });
      return null;
    }, [messagesAsync]);

    Future<void> sendMessage() async {
      final text = controller.text.trim();
      if (text.isEmpty) return;

      final replyId = replyToMessage.value?.id;
      controller.clear();
      replyToMessage.value = null; // Clear reply after sending

      // Send via WebSocket if connected, otherwise use HTTP
      if (wsConnection.isConnected) {
        wsService.sendMessage(chatId, text, replyToMessageId: replyId);
        // WebSocket will broadcast the message back, triggering auto-refresh via MessagesNotifier
      } else {
        // Fallback to HTTP if WebSocket is not connected
        final usecase = ref.read(sendMessageUsecaseProvider);
        final result = await usecase(
          conversationId: chatId,
          content: text,
          replyToMessageId: replyId,
        );
        result.fold(
          (failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          },
          (_) {
            // Refresh messages after HTTP send
            ref.read(messagesProvider(chatId).notifier).refresh();
          },
        );
      }
    }

    Future<void> handleReaction(Message message, String emoji) async {
      final usecase = ref.read(toggleReactionUsecaseProvider);
      final result = await usecase(
        messageId: message.id.toString(),
        emoji: emoji,
      );
      result.fold(
        (failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        },
        (_) {
          // Refresh messages to show updated reactions
          ref.read(messagesProvider(chatId).notifier).refresh();
        },
      );
    }

    Future<void> handleEditMessage(Message message) async {
      final newContent = await showDialog<String>(
        context: context,
        builder: (context) =>
            EditMessageDialog(initialContent: message.content),
      );

      if (newContent != null && newContent.isNotEmpty) {
        final usecase = ref.read(editMessageUsecaseProvider);
        final result = await usecase(
          messageId: message.id.toString(),
          content: newContent,
        );

        result.fold(
          (failure) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
          (_) {
            // Refresh messages to show updated content
            ref.read(messagesProvider(chatId).notifier).refresh();
          },
        );
      }
    }

    Future<void> handleDeleteMessage(Message message) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final usecase = ref.read(deleteMessageUsecaseProvider);
        final result = await usecase(messageId: message.id.toString());

        result.fold(
          (failure) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
          (_) {
            // Refresh messages to remove deleted message
            ref.read(messagesProvider(chatId).notifier).refresh();
          },
        );
      }
    }

    void scrollToBottom() {
      if (scrollController.hasClients) {
        // With reverse ListView, position 0 is at bottom
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: InkWell(
          onTap: () {
            // Navigate to chat info page
            if (conversation != null) {
              context.push('/chat-info', extra: conversation);
            }
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: avatarColor,
                child: Text(
                  (name ?? 'User $chatId').substring(0, 1).toUpperCase(),
                  style: textTheme.titleMedium?.copyWith(color: onAvatarColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? 'User $chatId', style: textTheme.titleMedium),
                    // Show user status for DIRECT conversations
                    if (conversation != null &&
                        conversation.type.toUpperCase() == 'DIRECT')
                      Builder(
                        builder: (context) {
                          final isOnline = ConversationUtils.isUserOnline(
                            conversation,
                            me,
                          );
                          final lastSeen = ConversationUtils.getLastSeen(
                            conversation,
                            me,
                          );
                          final statusText = ConversationUtils.formatLastSeen(
                            isOnline,
                            lastSeen,
                          );

                          return Text(
                            statusText,
                            style: textTheme.bodySmall?.copyWith(
                              color: isOnline ? Colors.green : Colors.grey,
                            ),
                          );
                        },
                      )
                    else
                      // Fallback to WebSocket connection status for GROUP or when conversation not loaded
                      Text(
                        wsConnection.isConnected
                            ? 'Connected'
                            : 'Connecting...',
                        style: textTheme.bodySmall?.copyWith(
                          color: wsConnection.isConnected
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Navigate to chat info page
              if (conversation != null) {
                context.push('/chat-info', extra: conversation);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    // API returns DESC order (newest first)
                    // Use reverse: true to show newest at bottom naturally without scroll animation
                    return ListView.builder(
                      controller: scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: messages.length,
                      // Performance optimizations
                      addAutomaticKeepAlives: true, // Keep state of items
                      addRepaintBoundaries:
                          true, // Already added in MessageBubble
                      cacheExtent: 500, // Cache items 500px outside viewport
                      itemBuilder: (context, index) {
                        final m = messages[index];
                        final isMe = m.sender.id == me?.id;

                        // Find replied message if exists
                        Message? repliedMsg;
                        if (m.replyToMessageId != null) {
                          try {
                            repliedMsg = messages.firstWhere(
                              (msg) => msg.id == m.replyToMessageId,
                            );
                          } catch (e) {
                            // Message not found in current list
                            repliedMsg = null;
                          }
                        }

                        return Align(
                          key: ValueKey(m.id), // Add key for better performance
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: MessageBubble(
                            message: m,
                            isMe: isMe,
                            currentUserId: me?.id,
                            replyToMessage: repliedMsg,
                            onReply: () {
                              replyToMessage.value = m;
                            },
                            onReactionTap: (emoji) {
                              handleReaction(m, emoji);
                            },
                            onAddReaction: () {
                              showReactionPicker(context, (emoji) {
                                handleReaction(m, emoji);
                              });
                            },
                            onEdit: isMe ? () => handleEditMessage(m) : null,
                            onDelete: isMe
                                ? () => handleDeleteMessage(m)
                                : null,
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(
                    child: Text(
                      'Failed to load messages',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  // Reply preview
                  if (replyToMessage.value != null)
                    ReplyMessagePreview(
                      replyToMessage: replyToMessage.value!,
                      onCancel: () {
                        replyToMessage.value = null;
                      },
                    ),
                  _InputBar(
                    controller: controller,
                    onSend: sendMessage,
                    chatId: chatId,
                  ),
                ],
              ),
            ],
          ),
          // Floating scroll to bottom button (to see newest messages)
          if (showScrollButton.value)
            Positioned(
              right: 16,
              bottom: replyToMessage.value != null ? 160 : 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // "New Message" indicator
                  if (hasNewMessages.value)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 16,
                            color: colors.onPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'New',
                            style: textTheme.labelSmall?.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Scroll to bottom button
                  FloatingActionButton.small(
                    onPressed: () {
                      scrollToBottom();
                      hasNewMessages.value =
                          false; // Clear indicator when clicked
                    },
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InputBar extends HookConsumerWidget {
  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.chatId,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final String chatId;

  /// Show voice recorder widget
  Future<void> _showVoiceRecorder(BuildContext context, WidgetRef ref) async {
    final cloudinaryService = ref.read(cloudinaryServiceProvider);
    final sendMessageUsecase = ref.read(sendMessageUsecaseProvider);

    // Save the page context BEFORE opening modal
    // This ensures we use the correct ScaffoldMessenger
    final pageContext = context;
    final scaffoldMessenger = ScaffoldMessenger.of(pageContext);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => VoiceRecorderWidget(
        onRecordingComplete: (audioFile, duration) async {
          try {
            // Close modal using modal context
            if (modalContext.mounted) {
              Navigator.pop(modalContext);
            }

            // Use the page's ScaffoldMessenger (saved before modal was opened)
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text('Uploading audio...'),
                duration: Duration(hours: 1),
              ),
            );

            // Upload to Cloudinary
            final result = await cloudinaryService.uploadAudio(audioFile);

            // Send message
            final sendResult = await sendMessageUsecase(
              conversationId: chatId,
              content: 'Voice message',
              type: 'AUDIO',
              mediaUrl: result.url,
              fileSize: result.bytes,
              duration: duration.inSeconds,
            );

            // Remove upload snackbar immediately using the saved reference
            scaffoldMessenger.removeCurrentSnackBar();

            sendResult.fold(
              (failure) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text('Failed to send: ${failure.message}')),
                );
              },
              (message) {
                // Don't show success snackbar - user can see the message in chat
                // Manually trigger refresh since backend doesn't broadcast multimedia via WebSocket
                ref.read(messagesProvider(chatId).notifier).refresh();
              },
            );
          } catch (e) {
            scaffoldMessenger.removeCurrentSnackBar();
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
        },
        onCancel: () {
          Navigator.pop(modalContext);
        },
      ),
    );
  }

  Future<void> _handleAttachment(
    BuildContext context,
    WidgetRef ref,
    AttachmentType type,
  ) async {
    final mediaPickerService = ref.read(mediaPickerServiceProvider);
    final cloudinaryService = ref.read(cloudinaryServiceProvider);
    final sendMessageUsecase = ref.read(sendMessageUsecaseProvider);

    try {
      File? file;
      String? fileName;
      String messageType = 'TEXT';
      String content = '';

      switch (type) {
        case AttachmentType.camera:
          file = await mediaPickerService.takePhoto();
          if (file == null) return;

          messageType = 'IMAGE';
          content = 'Photo';
          fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Uploading $fileName...')),
                  ],
                ),
                duration: const Duration(
                  hours: 1,
                ), // Long duration, will dismiss manually
              ),
            );
          }
          break;
        case AttachmentType.gallery:
          // Pick multiple images
          final images = await mediaPickerService
              .pickMultipleImagesFromGallery();
          if (images.isEmpty) return;

          // Send each image as a separate message
          for (int i = 0; i < images.length; i++) {
            try {
              final imageFile = images[i];
              final imageName = 'Image ${i + 1}/${images.length}';

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: Text('Uploading $imageName...')),
                      ],
                    ),
                    duration: const Duration(hours: 1),
                  ),
                );
              }

              // Upload to Cloudinary
              final result = await cloudinaryService.uploadImage(imageFile);

              // Remove progress snackbar immediately
              if (context.mounted) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              }

              // Send message
              if (context.mounted) {
                final sendResult = await sendMessageUsecase(
                  conversationId: chatId,
                  content: imageName,
                  type: 'IMAGE',
                  mediaUrl: result.url,
                  fileSize: result.bytes,
                );

                // Manually trigger refresh for all participants
                // This is a workaround since backend doesn't broadcast multimedia messages via WebSocket
                sendResult.fold(
                  (failure) => null,
                  (_) => ref.read(messagesProvider(chatId).notifier).refresh(),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to upload image ${i + 1}: $e'),
                  ),
                );
              }
            }
          }

          // Remove any remaining snackbar and don't show success message
          // User can see the images in chat
          if (context.mounted) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ref.read(messagesProvider(chatId).notifier).refresh();
          }
          return;
        case AttachmentType.video:
          file = await mediaPickerService.pickVideoFromGallery();
          if (file == null) return;

          messageType = 'VIDEO';
          fileName = file.path.split('/').last;
          content = fileName;

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Uploading $fileName...')),
                  ],
                ),
                duration: const Duration(hours: 1),
              ),
            );
          }
          break;
        case AttachmentType.audio:
          // Show voice recorder widget instead of file picker
          if (context.mounted) {
            await _showVoiceRecorder(context, ref);
          }
          return;
        case AttachmentType.document:
          final pickedFile = await mediaPickerService.pickDocument();
          if (pickedFile == null) return;

          file = pickedFile.file;
          fileName = pickedFile.name;
          messageType = 'DOCUMENT';
          content = fileName;

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Uploading $fileName...')),
                  ],
                ),
                duration: const Duration(hours: 1),
              ),
            );
          }
          break;
        case AttachmentType.location:
          final location = await mediaPickerService.getCurrentLocation();
          if (location != null && context.mounted) {
            // Send location message directly
            final result = await sendMessageUsecase(
              conversationId: chatId,
              content: 'Shared location',
              type: 'LOCATION',
              latitude: location.latitude,
              longitude: location.longitude,
            );

            result.fold(
              (failure) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(failure.message)));
                }
              },
              (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Location shared')),
                  );
                }
                ref.read(messagesProvider(chatId).notifier).refresh();
              },
            );
          }
          return;
      }

      // Upload to Cloudinary
      String? mediaUrl;
      String? thumbnailUrl;
      int? fileSize;
      int? duration;

      if (messageType == 'IMAGE') {
        final result = await cloudinaryService.uploadImage(file);
        mediaUrl = result.url;
        fileSize = result.bytes;
      } else if (messageType == 'VIDEO') {
        final result = await cloudinaryService.uploadVideo(file);
        mediaUrl = result.url;
        thumbnailUrl = result.thumbnailUrl;
        fileSize = result.bytes;
        duration = result.duration?.toInt();
      } else if (messageType == 'AUDIO') {
        final result = await cloudinaryService.uploadAudio(file);
        mediaUrl = result.url;
        fileSize = result.bytes;
        duration = result.duration?.toInt();
      } else if (messageType == 'DOCUMENT') {
        final result = await cloudinaryService.uploadDocument(
          file,
          fileName: fileName,
        );
        mediaUrl = result.url;
        fileSize = result.bytes;
      }

      // Remove upload progress snackbar immediately
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }

      // Send message with media
      if (context.mounted) {
        final result = await sendMessageUsecase(
          conversationId: chatId,
          content: content,
          type: messageType,
          mediaUrl: mediaUrl,
          thumbnailUrl: thumbnailUrl,
          fileName: fileName,
          fileSize: fileSize,
          duration: duration,
        );

        result.fold(
          (failure) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
          (_) {
            // Don't show success snackbar - user can see the message in chat
            ref.read(messagesProvider(chatId).notifier).refresh();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: colors.onSurface.withValues(alpha: 0.08)),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                final type = await AttachmentPickerBottomSheet.show(context);
                if (type != null && context.mounted) {
                  await _handleAttachment(context, ref, type);
                }
              },
              icon: const FaIcon(FontAwesomeIcons.paperclip),
              color: colors.onSurface,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  filled: true,
                  fillColor: colors.surface.withValues(alpha: 0.6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onSend,
              icon: const FaIcon(FontAwesomeIcons.paperPlane),
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
