import 'dart:async';

import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/hooks/chat_actions_controller.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/typing_indicator_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/attachment_picker.dart';
import 'package:chattrix_ui/features/chat/services/voice_recorder_provider.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

// ============================================================================
// EFFECTS (Custom Hooks)
// ============================================================================

/// Mark conversation as read when opening
void useMarkAsReadEffect(WidgetRef ref, int chatId) {
  useEffect(() {
    Future.microtask(() async {
      try {
        final markAsReadUseCase = ref.read(markConversationAsReadUsecaseProvider);
        final result = await markAsReadUseCase(conversationId: chatId);

        result.fold((failure) => debugPrint('❌ Failed to mark conversation as read: ${failure.message}'), (_) {
          debugPrint('✅ Marked conversation $chatId as read');
          ref.read(conversationsProvider.notifier).resetUnreadCount(chatId);
        });
      } catch (e) {
        debugPrint('❌ Error marking conversation as read: $e');
      }
    });
    return null;
  }, [chatId]);
}

/// Scroll to highlighted message
void useScrollToHighlightEffect(
  ValueNotifier<int?> highlightedMessageId,
  AsyncValue<List<Message>> messagesAsync,
  ScrollController scrollController,
  int chatId,
) {
  useEffect(() {
    if (highlightedMessageId.value != null && messagesAsync.hasValue) {
      final messages = messagesAsync.value!;
      final messageIndex = messages.indexWhere((m) => m.id == highlightedMessageId.value);

      debugPrint('🔍 [ChatView] Scroll to message ${highlightedMessageId.value}');
      debugPrint('🔍 [ChatView] Message index: $messageIndex / ${messages.length}');

      if (messageIndex != -1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (scrollController.hasClients) {
            final reversedIndex = messages.length - messageIndex;
            final targetPosition = reversedIndex * 100.0;

            debugPrint('🔍 [ChatView] Scrolling to position: $targetPosition');

            scrollController.animateTo(
              targetPosition,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );

            Future.delayed(const Duration(seconds: 2), () {
              highlightedMessageId.value = null;
            });
          }
        });
      }
    }
    return null;
  }, [highlightedMessageId.value, messagesAsync]);
}

/// Typing indicator logic
void useTypingIndicatorEffect(
  TextEditingController controller,
  ValueNotifier<bool> isTyping,
  WidgetRef ref,
  int chatId,
) {
  useEffect(() {
    Timer? debounceTimer;

    void onTextChanged() {
      final text = controller.text.trim();

      if (text.isNotEmpty && !isTyping.value) {
        debugPrint('⌨️ [Chat] User started typing in conversation: $chatId');
        isTyping.value = true;
        ref.read(typingIndicatorProvider(chatId).notifier).startTyping();
      }

      debounceTimer?.cancel();
      debounceTimer = Timer(const Duration(seconds: 2), () {
        if (isTyping.value) {
          debugPrint('⌨️ [Chat] User stopped typing (debounce) in conversation: $chatId');
          isTyping.value = false;
          ref.read(typingIndicatorProvider(chatId).notifier).stopTyping();
        }
      });
    }

    controller.addListener(onTextChanged);

    return () {
      controller.removeListener(onTextChanged);
      debounceTimer?.cancel();
      if (isTyping.value) {
        debugPrint('⌨️ [Chat] User left screen, stopping typing for conversation: $chatId');
        ref.read(typingIndicatorProvider(chatId).notifier).stopTyping();
      }
    };
  }, [controller, chatId]);
}

/// Gallery loading effect
void useGalleryEffect(
  ValueNotifier<List<AssetPathEntity>> albums,
  ValueNotifier<AssetPathEntity?> currentAlbum,
  ValueNotifier<List<AssetEntity>> assets,
  AppLifecycleState? appLifecycleState,
) {
  Future<void> loadImages() async {
    if (kIsWeb) {
      debugPrint('⚠️ Photo gallery not supported on web platform');
      return;
    }

    final ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await PhotoManager.clearFileCache();
      final filter = FilterOptionGroup(orders: [OrderOption(type: OrderOptionType.createDate, asc: false)]);
      final paths = await PhotoManager.getAssetPathList(type: RequestType.common, filterOption: filter);

      albums.value = paths;
      if (paths.isNotEmpty) {
        final target = currentAlbum.value ?? paths.first;
        final validAlbum = paths.firstWhere((a) => a.id == target.id, orElse: () => paths.first);
        currentAlbum.value = validAlbum;
        assets.value = await validAlbum.getAssetListPaged(page: 0, size: 80);
      }
    }
  }

  useEffect(() {
    if (!kIsWeb) loadImages();
    return null;
  }, []);

  useEffect(() {
    if (!kIsWeb && appLifecycleState == AppLifecycleState.resumed) {
      loadImages();
    }
    return null;
  }, [appLifecycleState]);
}

/// Scroll button visibility effect
void useScrollButtonEffect(ScrollController scrollController, ValueNotifier<bool> showScrollButton) {
  useEffect(() {
    void scrollListener() {
      if (!scrollController.hasClients) return;
      if (scrollController.offset > 500) {
        if (!showScrollButton.value) showScrollButton.value = true;
      } else {
        if (showScrollButton.value) showScrollButton.value = false;
      }
    }

    scrollController.addListener(scrollListener);
    return () => scrollController.removeListener(scrollListener);
  }, [scrollController]);
}

/// Voice recording duration listener
void useVoiceRecordingEffect(
  ValueNotifier<bool> isRecording,
  ValueNotifier<Duration> recordingDuration,
  WidgetRef ref,
  ChatActionsController chatActions,
) {
  useEffect(() {
    if (isRecording.value) {
      final voiceRecorder = ref.read(voiceRecorderServiceProvider);
      final subscription = voiceRecorder.durationStream.listen((duration) {
        recordingDuration.value = duration;

        if (duration.inMinutes >= 5) {
          chatActions.handleVoiceRecording(isRecording: isRecording, recordingDuration: recordingDuration);
        }
      });
      return subscription.cancel;
    }
    return null;
  }, [isRecording.value]);
}

/// Hide pickers when keyboard shows
void useHidePickersOnKeyboardEffect(
  FocusNode focusNode,
  ValueNotifier<bool> showEmojiPicker,
  ValueNotifier<bool> showStickerPicker,
  ValueNotifier<bool> showAttachmentPicker,
) {
  useEffect(() {
    void onFocusChange() {
      if (focusNode.hasFocus) {
        if (showEmojiPicker.value) showEmojiPicker.value = false;
        if (showStickerPicker.value) showStickerPicker.value = false;
        if (showAttachmentPicker.value) showAttachmentPicker.value = false;
      }
    }

    focusNode.addListener(onFocusChange);
    return () => focusNode.removeListener(onFocusChange);
  }, [focusNode]);
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

void scrollToBottom(ScrollController scrollController) {
  if (scrollController.hasClients) {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}

Future<void> changeAlbum(
  AssetPathEntity album,
  ValueNotifier<AssetPathEntity?> currentAlbum,
  ValueNotifier<List<AssetEntity>> assets,
) async {
  currentAlbum.value = album;
  assets.value = await album.getAssetListPaged(page: 0, size: 80);
}

void toggleGallery(
  ValueNotifier<bool> showGallery,
  FocusNode focusNode,
  ValueNotifier<bool> showEmojiPicker,
  ValueNotifier<bool> showStickerPicker,
  ValueNotifier<bool> showAttachmentPicker,
  ValueNotifier<List<AssetPathEntity>> albums,
  ValueNotifier<AssetPathEntity?> currentAlbum,
  ValueNotifier<List<AssetEntity>> assets,
  BuildContext context,
) {
  if (kIsWeb) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thư viện ảnh chưa hỗ trợ trên web. Vui lòng sử dụng nút Camera hoặc Files.')),
    );
    return;
  }

  if (showGallery.value) {
    showGallery.value = false;
    focusNode.requestFocus();
  } else {
    focusNode.unfocus();
    showEmojiPicker.value = false;
    showStickerPicker.value = false;
    showAttachmentPicker.value = false;
    Future.delayed(const Duration(milliseconds: 100), () {
      showGallery.value = true;
    });
  }
}

void toggleAttachmentPicker(
  ValueNotifier<bool> showAttachmentPicker,
  FocusNode focusNode,
  ValueNotifier<bool> showGallery,
  ValueNotifier<bool> showEmojiPicker,
  ValueNotifier<bool> showStickerPicker,
) {
  if (showAttachmentPicker.value) {
    showAttachmentPicker.value = false;
    focusNode.requestFocus();
  } else {
    focusNode.unfocus();
    showGallery.value = false;
    showEmojiPicker.value = false;
    showStickerPicker.value = false;
    showAttachmentPicker.value = true;
  }
}

void handleAttachmentSelection(
  AttachmentType type,
  ValueNotifier<bool> showAttachmentPicker,
  ValueNotifier<bool> showEmojiPicker,
  ValueNotifier<bool> showStickerPicker,
  ChatActionsController chatActions,
  BuildContext context,
  int chatId,
  TextEditingController textController,
  dynamic conversation, // ← Add conversation parameter
) {
  switch (type) {
    case AttachmentType.camera:
      showAttachmentPicker.value = false;
      chatActions.handleCamera(textController: textController);
      break;
    case AttachmentType.gallery:
      showAttachmentPicker.value = false;
      chatActions.handleGallery(textController: textController);
      break;
    case AttachmentType.video:
      showAttachmentPicker.value = false;
      chatActions.handleVideo(textController: textController);
      break;
    case AttachmentType.document:
      showAttachmentPicker.value = false;
      chatActions.handleFilePicker();
      break;
    case AttachmentType.emoji:
      showAttachmentPicker.value = false;
      showStickerPicker.value = false;
      showEmojiPicker.value = true;
      break;
    case AttachmentType.sticker:
      showAttachmentPicker.value = false;
      showEmojiPicker.value = false;
      showStickerPicker.value = true;
      break;
    case AttachmentType.poll:
      showAttachmentPicker.value = false;
      
      // ✅ Check if conversation is direct chat
      if (conversation?.type == 'DIRECT') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Polls are only available in group conversations'),
                ),
              ],
            ),
            backgroundColor: Colors.orange.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      
      context.push('/chat/$chatId/create-poll');
      break;
    case AttachmentType.event:
      showAttachmentPicker.value = false;
      
      // ✅ Check if conversation is direct chat
      if (conversation?.type == 'DIRECT') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Events are only available in group conversations'),
                ),
              ],
            ),
            backgroundColor: Colors.orange.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      
      context.push('/chat/$chatId/create-event');
      break;
    case AttachmentType.schedule:
      showAttachmentPicker.value = false;
      context.push('/chat/$chatId/schedule-message');
      break;
  }
}

void onEmojiSelected(String emoji, ChatActionsController chatActions, ValueNotifier<bool> showEmojiPicker) {
  chatActions.sendMessage(specificContent: emoji, type: 'EMOJI');
  showEmojiPicker.value = false;
}

void onStickerSelected(String stickerUrl, ChatActionsController chatActions, ValueNotifier<bool> showEmojiPicker) {
  chatActions.sendMessage(specificContent: '', type: 'STICKER', mediaUrl: stickerUrl);
  showEmojiPicker.value = false;
}

Future<void> handlePinMessage(Message message, WidgetRef ref, int chatId, BuildContext context) async {
  try {
    if (message.pinned) {
      await ref.read(unpinMessageUsecaseProvider)(conversationId: chatId, messageId: message.id);
    } else {
      await ref.read(pinMessageUsecaseProvider)(conversationId: chatId, messageId: message.id);
    }

    ref.read(messagesProvider(chatId).notifier).refresh();
    ref.invalidate(pinnedMessagesProvider(chatId));

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(message.pinned ? 'Message unpinned' : 'Message pinned', style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Failed: $e', style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

void handleAudioCall(BuildContext context, WidgetRef ref, dynamic conversation, dynamic me, int chatId) {
  if (conversation == null || me == null) return;

  if (conversation.type == ConversationType.group) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Group calls are not supported yet')));
    return;
  }

  final conversationName = ConversationUtils.getConversationTitle(conversation, me);
  final conversationAvatar = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid conversation ID')));

  ref
      .read(callProvider.notifier)
      .initiateCall(chatId, CallType.audio, conversationName: conversationName, conversationAvatar: conversationAvatar);
}

void handleVideoCall(BuildContext context, WidgetRef ref, dynamic conversation, dynamic me, int chatId) {
  if (conversation == null || me == null) return;

  if (conversation.type == ConversationType.group) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Group calls are not supported yet')));
    return;
  }

  final conversationName = ConversationUtils.getConversationTitle(conversation, me);
  final conversationAvatar = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid conversation ID')));

  ref
      .read(callProvider.notifier)
      .initiateCall(chatId, CallType.video, conversationName: conversationName, conversationAvatar: conversationAvatar);
}

void handleConversationInfo(BuildContext context, dynamic conversation, int chatId) {
  if (conversation == null) return;
  context.push('/chat/$chatId/info', extra: conversation);
}

/// Show reaction picker bottom sheet with search
///
/// Uses emoji_picker_flutter v4.4.0 with custom styling for modern UI
void showReactionPicker(BuildContext context, Function(String) onReactionSelected) {
  final colors = Theme.of(context).colorScheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2)),
          ],
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Choose Reaction',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: colors.surfaceContainerHighest,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Emoji Picker
            Expanded(
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  onReactionSelected(emoji.emoji);
                  Navigator.pop(context);
                },
                config: Config(
                  checkPlatformCompatibility: false,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 32,
                    verticalSpacing: 8,
                    horizontalSpacing: 4,
                    gridPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: colors.surface,
                    columns: 8,
                    buttonMode: ButtonMode.MATERIAL,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: true,
                  ),
                  skinToneConfig: const SkinToneConfig(enabled: false),
                  categoryViewConfig: CategoryViewConfig(
                    backgroundColor: colors.surface,
                    indicatorColor: colors.primary,
                    iconColorSelected: colors.primary,
                    iconColor: colors.onSurfaceVariant.withValues(alpha: 0.6),
                    categoryIcons: const CategoryIcons(),
                    recentTabBehavior: RecentTabBehavior.RECENT,
                    tabIndicatorAnimDuration: const Duration(milliseconds: 300),
                    dividerColor: colors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  bottomActionBarConfig: BottomActionBarConfig(
                    enabled: true,
                    backgroundColor: colors.surface,
                    buttonColor: colors.surfaceContainerHighest,
                    buttonIconColor: colors.onSurfaceVariant,
                    showSearchViewButton: true,
                  ),
                  searchViewConfig: SearchViewConfig(
                    backgroundColor: colors.surface,
                    buttonIconColor: colors.onSurfaceVariant,
                    hintText: 'Search emoji...',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Extension for list lookup
extension ListLookup on List<dynamic> {
  dynamic lookup(dynamic id) {
    if (isEmpty) return null;
    try {
      // Support both int and String
      if (id is int) {
        return firstWhere((e) => e.id == id);
      } else {
        return firstWhere((e) => e.id.toString() == id.toString());
      }
    } catch (_) {
      return null;
    }
  }
}
