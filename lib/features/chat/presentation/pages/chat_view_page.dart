import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/providers/active_call_provider.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/active_call_banner.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/hooks/chat_actions_controller.dart';
import 'package:chattrix_ui/features/chat/presentation/hooks/use_websocket_error_listener.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/typing_indicator_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/chat_view_helpers.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/attachment_picker.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_gallery.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/edit_message_bottom_sheet.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/emoji_sticker_picker.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/input_bar_config.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/pinned_messages_banner.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';




class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId, this.highlightMessageId});

  final int chatId;
  final int? highlightMessageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Controllers & State ---
    final controller = useTextEditingController();
    useListenable(controller);
    final scrollController = useScrollController();
    final focusNode = useFocusNode();
    final appLifecycleState = useAppLifecycleState();

    // State
    final isTyping = useState(false);
    final showScrollButton = useState(false);
    final showGallery = useState(false);
    final showEmojiPicker = useState(false);
    final showStickerPicker = useState(false);
    final showAttachmentPicker = useState(false);
    final replyToMessage = useState<Message?>(null);
    final isRecording = useState(false);
    final recordingDuration = useState(Duration.zero);
    final selectedAssets = useState<List<AssetEntity>>([]);
    final highlightedMessageId = useState<int?>(highlightMessageId);

    // Gallery state
    final albums = useState<List<AssetPathEntity>>([]);
    final currentAlbum = useState<AssetPathEntity?>(null);
    final assets = useState<List<AssetEntity>>([]);

    // --- Data ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final backgroundColor = theme.scaffoldBackgroundColor;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.value?.lookup(chatId);
    final pinnedMessagesAsync = ref.watch(pinnedMessagesProvider(chatId));
    final typingIndicator = ref.watch(typingIndicatorProvider(chatId));

    // --- Chat Actions Controller (NEW!) ---
    final chatActions = useChatActions(
      ref: ref,
      chatId: chatId,
      context: context,
      textController: controller,
      replyToMessage: replyToMessage,
      selectedAssets: selectedAssets,
      scrollToBottom: () => scrollToBottom(scrollController),
      isTyping: isTyping,
      showGallery: showGallery,
    );

    // --- Effects ---
    useMarkAsReadEffect(ref, chatId);
    useScrollToHighlightEffect(highlightedMessageId, messagesAsync, scrollController, chatId);
    useTypingIndicatorEffect(controller, isTyping, ref, chatId);
    useGalleryEffect(albums, currentAlbum, assets, appLifecycleState);
    useScrollButtonEffect(scrollController, showScrollButton);
    useVoiceRecordingEffect(isRecording, recordingDuration, ref, chatActions);
    useHidePickersOnKeyboardEffect(focusNode, showEmojiPicker, showStickerPicker, showAttachmentPicker);
    useWebSocketErrorListener(context, ref); // Listen for WebSocket errors

    // --- UI ---
    return PopScope(
      canPop: !showGallery.value,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        showGallery.value = false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: ChatAppBar(
          conversation: conversation,
          me: me,
          onAudioCall: () => handleAudioCall(context, ref, conversation, me, chatId),
          onVideoCall: () => handleVideoCall(context, ref, conversation, me, chatId),
          onInfo: () => handleConversationInfo(context, conversation, chatId),
        ),
        body: _buildBody(
          context: context,
          ref: ref,
          chatId: chatId,
          controller: controller,
          focusNode: focusNode,
          scrollController: scrollController,
          me: me,
          conversation: conversation,
          messagesAsync: messagesAsync,
          pinnedMessagesAsync: pinnedMessagesAsync,
          typingIndicator: typingIndicator,
          highlightedMessageId: highlightedMessageId.value,
          replyToMessage: replyToMessage,
          showScrollButton: showScrollButton.value,
          showGallery: showGallery,
          showEmojiPicker: showEmojiPicker,
          showStickerPicker: showStickerPicker,
          showAttachmentPicker: showAttachmentPicker,
          isRecording: isRecording,
          recordingDuration: recordingDuration.value,
          selectedAssets: selectedAssets,
          albums: albums.value,
          currentAlbum: currentAlbum.value,
          assets: assets.value,
          chatActions: chatActions,
          onChangeAlbum: (album) => changeAlbum(album, currentAlbum, assets),
          onToggleGallery: () => toggleGallery(showGallery, focusNode, showEmojiPicker, showStickerPicker, showAttachmentPicker, albums, currentAlbum, assets, context),
          onToggleAttachmentPicker: () => toggleAttachmentPicker(showAttachmentPicker, focusNode, showGallery, showEmojiPicker, showStickerPicker),
          onAttachmentSelection: (type) => handleAttachmentSelection(type, showAttachmentPicker, showEmojiPicker, showStickerPicker, chatActions, context, chatId, controller, conversation),
          onEmojiSelected: (emoji) => onEmojiSelected(emoji, chatActions, showEmojiPicker),
          onStickerSelected: (sticker) => onStickerSelected(sticker, chatActions, showEmojiPicker),
          onPinMessage: (message) => handlePinMessage(message, ref, chatId, context),
        ),
      ),
    );
  }
}


// ============================================================================
// BUILD BODY
// ============================================================================

Widget _buildBody({
  required BuildContext context,
  required WidgetRef ref,
  required int chatId,
  required TextEditingController controller,
  required FocusNode focusNode,
  required ScrollController scrollController,
  required dynamic me,
  required dynamic conversation,
  required AsyncValue<List<Message>> messagesAsync,
  required AsyncValue<List<Message>> pinnedMessagesAsync,
  required TypingIndicator typingIndicator,
  required int? highlightedMessageId,
  required ValueNotifier<Message?> replyToMessage,
  required bool showScrollButton,
  required ValueNotifier<bool> showGallery,
  required ValueNotifier<bool> showEmojiPicker,
  required ValueNotifier<bool> showStickerPicker,
  required ValueNotifier<bool> showAttachmentPicker,
  required ValueNotifier<bool> isRecording,
  required Duration recordingDuration,
  required ValueNotifier<List<AssetEntity>> selectedAssets,
  required List<AssetPathEntity> albums,
  required AssetPathEntity? currentAlbum,
  required List<AssetEntity> assets,
  required ChatActionsController chatActions,
  required Function(AssetPathEntity) onChangeAlbum,
  required VoidCallback onToggleGallery,
  required VoidCallback onToggleAttachmentPicker,
  required Function(AttachmentType) onAttachmentSelection,
  required Function(String) onEmojiSelected,
  required Function(String) onStickerSelected,
  required Function(Message) onPinMessage,
}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  final primaryColor = theme.colorScheme.primary;
  return GestureDetector(
    onTap: () {
      if (showGallery.value) showGallery.value = false;
      if (showEmojiPicker.value) showEmojiPicker.value = false;
      if (showStickerPicker.value) showStickerPicker.value = false;
      if (showAttachmentPicker.value) showAttachmentPicker.value = false;
      focusNode.unfocus();
    },
    child: Column(
      children: [
        // Active Call Banner
        Consumer(
          builder: (context, ref, _) {
            final activeCallAsync = ref.watch(activeCallProvider(chatId));
            
            return activeCallAsync.when(
              data: (callInfo) {
                if (callInfo == null) return const SizedBox.shrink();
                
                return ActiveCallBanner(
                  callInfo: callInfo,
                  onJoinPressed: () {
                    final callNotifier = ref.read(callProvider.notifier);
                    callNotifier.joinCall(
                      callInfo.id,
                      callInfo.callType,
                    );
                  },
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          },
        ),
        
        // Pinned Messages Banner
        if (pinnedMessagesAsync.hasValue && pinnedMessagesAsync.value!.isNotEmpty)
          PinnedMessagesBanner(
            pinnedMessages: pinnedMessagesAsync.value!,
            conversationId: chatId,
          ),

        // Messages List
        Expanded(
          child: Stack(
            children: [
              _MessageList(
                messagesAsync: messagesAsync,
                me: me,
                conversation: conversation,
                scrollController: scrollController,
                typingIndicator: typingIndicator,
                highlightedMessageId: highlightedMessageId,
                onReply: (m) => replyToMessage.value = m,
                onPin: onPinMessage,
                onReactionTap: (m, e) async {
                  final result = await ref.read(toggleReactionUsecaseProvider)(
                    messageId: m.id,
                    emoji: e,
                  );
                  result.fold(
                    (failure) => debugPrint('Failed to toggle reaction: ${failure.message}'),
                    (_) => ref.read(messagesProvider(chatId).notifier).refresh(),
                  );
                },
                onAddReaction: (m) => showReactionPicker(context, (e) async {
                  final result = await ref.read(toggleReactionUsecaseProvider)(
                    messageId: m.id,
                    emoji: e,
                  );
                  result.fold(
                    (failure) => debugPrint('Failed to add reaction: ${failure.message}'),
                    (_) => ref.read(messagesProvider(chatId).notifier).refresh(),
                  );
                }),
                onEdit: (m) async {
                  if (m.type.toUpperCase() == 'TEXT') {
                    showEditMessageBottomSheet(
                      context: context,
                      initialContent: m.content,
                      onSave: (newContent) async {
                        final result = await ref.read(editMessageUsecaseProvider)(
                          conversationId: chatId,
                          messageId: m.id,
                          content: newContent,
                        );
                        result.fold(
                          (failure) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${failure.message}')),
                              );
                            }
                          },
                          (_) {
                            ref.read(messagesProvider(chatId).notifier).refresh();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Message updated'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
                onDelete: (m) async {
                  await ref.read(deleteMessageUsecaseProvider)(
                    conversationId: chatId,
                    messageId: m.id,
                  );
                  ref.read(messagesProvider(chatId).notifier).refresh();
                },
              ),

              // Scroll to bottom button
              if (showScrollButton)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: FloatingActionButton.small(
                      onPressed: () => scrollToBottom(scrollController),
                      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                      foregroundColor: primaryColor,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Reply Preview + Input Bar
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyToMessage.value != null)
              ReplyMessagePreview(
                replyToMessage: replyToMessage.value!,
                onCancel: () => replyToMessage.value = null,
              ),

            ChatInputBar(
              config: InputBarConfig(
                controller: controller,
                focusNode: focusNode,
                chatId: chatId,
                isDark: isDark,
                primaryColor: primaryColor,
                conversation: conversation,
              ),
              state: InputBarState(
                showGallery: showGallery.value,
                canSendMessage: controller.text.trim().isNotEmpty || selectedAssets.value.isNotEmpty,
                showAttachmentPicker: showAttachmentPicker.value,
                isRecording: isRecording.value,
                recordingDuration: recordingDuration,
              ),
              callbacks: InputBarCallbacks(
                onSend: () {
                  if (controller.text.trim().isNotEmpty) {
                    chatActions.sendMessage();
                  } else {
                    // Send like emoji
                    chatActions.sendMessage(specificContent: '👍', type: 'TEXT');
                  }
                },
                onToggleGallery: onToggleGallery,
                onToggleAttachmentPicker: onToggleAttachmentPicker,
                onVoiceRecord: () => chatActions.handleVoiceRecording(
                  isRecording: isRecording,
                  recordingDuration: ValueNotifier(recordingDuration),
                ),
                onCancelRecording: () => chatActions.handleCancelRecording(
                  isRecording: isRecording,
                  recordingDuration: ValueNotifier(recordingDuration),
                ),
              ),
            ),
          ],
        ),

        // Gallery
        GestureDetector(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutQuad,
            height: showGallery.value ? MediaQuery.of(context).size.height * 0.45 : 0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            ),
            child: showGallery.value
                ? ChatGallery(
                    albums: albums,
                    currentAlbum: currentAlbum,
                    assets: assets,
                    selectedAssets: selectedAssets.value,
                    onCameraTap: chatActions.handleCamera,
                    onAlbumChanged: onChangeAlbum,
                    onAssetSelect: (asset) {
                      final list = List<AssetEntity>.from(selectedAssets.value);
                      list.contains(asset) ? list.remove(asset) : list.add(asset);
                      selectedAssets.value = list;
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ),

        // Emoji/Sticker & Attachment Picker
        GestureDetector(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutQuad,
            height: (showEmojiPicker.value || showStickerPicker.value || showAttachmentPicker.value) ? 350 : 0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            ),
            child: (showEmojiPicker.value || showStickerPicker.value || showAttachmentPicker.value)
                ? IndexedStack(
                    index: showAttachmentPicker.value ? 0 : (showEmojiPicker.value ? 1 : 2),
                    children: [
                      AttachmentPicker(
                        key: const ValueKey('attachment_picker'),
                        onAttachmentSelected: onAttachmentSelection,
                      ),
                      EmojiOnlyPicker(
                        key: const ValueKey('emoji_only_picker'),
                        onEmojiSelected: onEmojiSelected,
                      ),
                      StickerOnlyPicker(
                        key: const ValueKey('sticker_only_picker'),
                        onStickerSelected: onStickerSelected,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MESSAGE LIST
// ============================================================================

class _MessageList extends HookConsumerWidget {
  final AsyncValue<List<Message>> messagesAsync;
  final dynamic me;
  final dynamic conversation;
  final ScrollController scrollController;
  final TypingIndicator typingIndicator;
  final int? highlightedMessageId;
  final Function(Message) onReply;
  final Function(Message) onPin;
  final Function(Message, String) onReactionTap;
  final Function(Message) onAddReaction;
  final Function(Message) onEdit;
  final Function(Message) onDelete;

  const _MessageList({
    required this.messagesAsync,
    required this.me,
    required this.conversation,
    required this.scrollController,
    required this.typingIndicator,
    this.highlightedMessageId,
    required this.onReply,
    required this.onPin,
    required this.onReactionTap,
    required this.onAddReaction,
    required this.onEdit,
    required this.onDelete,
  });

  String? _getSenderAvatar(int senderId) {
    if (conversation == null) return null;
    try {
      final participant = conversation.participants.firstWhere(
        (p) => p.userId == senderId,
        orElse: () => null,
      );
      return participant?.avatarUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return messagesAsync.when(
      data: (messages) {
        final isGroup = conversation?.type == ConversationType.group;

        int? lastMessageFromMeIndex;
        if (me != null) {
          for (int i = 0; i < messages.length; i++) {
            if (messages[i].senderId == me!.id) {
              lastMessageFromMeIndex = i;
              break;
            }
          }
        }

        return ListView.builder(
          controller: scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: messages.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return TypingIndicatorWidget(
                typingIndicator: typingIndicator,
                currentUserId: me?.id,
              );
            }

            final messageIndex = index - 1;
            final m = messages[messageIndex];
            final isMe = m.senderId == me?.id;
            final isLastMessageFromMe = isMe && messageIndex == lastMessageFromMeIndex;
            final isSystemMessage = m.type == 'SYSTEM';

            bool showAvatar = !isMe && !isSystemMessage;
            if (messageIndex > 0 && messages[messageIndex - 1].senderId == m.senderId) {
              showAvatar = false;
            }

            double marginBottom = (messageIndex > 0 && messages[messageIndex - 1].senderId != m.senderId) ? 8.0 : 0.0;

            return Padding(
              padding: EdgeInsets.only(bottom: marginBottom),
              child: Stack(
                children: [
                  if (!isMe && showAvatar)
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: UserAvatar(
                          displayName: m.senderFullName ?? 'U',
                          avatarUrl: _getSenderAvatar(m.senderId),
                          radius: 14,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: isMe || isSystemMessage ? 0 : 36),
                    child: Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : (isSystemMessage ? Alignment.center : Alignment.centerLeft),
                      child: m.scheduled
                          ? MessageBubble(
                              message: m,
                              isMe: isMe,
                              currentUserId: me?.id,
                              replyToMessage: m.replyToMessage,
                              onReply: () => onReply(m),
                              onPin: () => onPin(m),
                              onReactionTap: (e) => onReactionTap(m, e),
                              onAddReaction: () => onAddReaction(m),
                              onEdit: isMe ? () => onEdit(m) : null,
                              onDelete: isMe ? () => onDelete(m) : null,
                              onForward: () => handleForwardMessage(context, m),
                              isGroup: isGroup,
                              isLastMessage: isLastMessageFromMe,
                              isHighlighted: m.id == highlightedMessageId,
                            )
                          : AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: m.id == highlightedMessageId ? const EdgeInsets.all(3) : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: m.id == highlightedMessageId
                                    ? Border.all(color: Colors.blue, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: MessageBubble(
                                message: m,
                                isMe: isMe,
                                currentUserId: me?.id,
                                replyToMessage: m.replyToMessage,
                                onReply: () => onReply(m),
                                onPin: () => onPin(m),
                                onReactionTap: (e) => onReactionTap(m, e),
                                onAddReaction: () => onAddReaction(m),
                                onEdit: isMe ? () => onEdit(m) : null,
                                onDelete: isMe ? () => onDelete(m) : null,
                                onForward: () => handleForwardMessage(context, m),
                                isGroup: isGroup,
                                isLastMessage: isLastMessageFromMe,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const SizedBox(),
    );
  }
}
