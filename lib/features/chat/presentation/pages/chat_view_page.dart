import 'dart:async';
import 'dart:io';

import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/typing_indicator.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/pinned_messages_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/typing_indicator_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/attachment_picker.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/edit_message_bottom_sheet.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/emoji_sticker_picker.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/mention_text_field.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/pinned_messages_banner.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/typing_indicator_widget.dart';
import 'package:chattrix_ui/features/chat/services/cloudinary_provider.dart';
import 'package:chattrix_ui/features/chat/services/media_picker_provider.dart';
import 'package:chattrix_ui/features/chat/services/voice_recorder_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId, this.highlightMessageId});

  final String chatId;
  final int? highlightMessageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Controller & State ---
    final controller = useTextEditingController();
    useListenable(controller);
    final scrollController = useScrollController();
    final focusNode = useFocusNode();
    final appLifecycleState = useAppLifecycleState();

    // Typing indicator state
    final isTyping = useState(false);
    final typingIndicator = ref.watch(typingIndicatorProvider(chatId));

    final showScrollButton = useState(false);

    // Gallery State
    final showGallery = useState(false);
    final albums = useState<List<AssetPathEntity>>([]);
    final currentAlbum = useState<AssetPathEntity?>(null);
    final assets = useState<List<AssetEntity>>([]);
    final selectedAssets = useState<List<AssetEntity>>([]);

    // Emoji/Sticker picker state
    final showEmojiPicker = useState(false);
    final showStickerPicker = useState(false);

    // Attachment picker state
    final showAttachmentPicker = useState(false);

    // Chat Logic State
    final replyToMessage = useState<Message?>(null);
    final isRecording = useState(false);
    final recordingDuration = useState(Duration.zero);

    // --- DATA ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final backgroundColor = theme.scaffoldBackgroundColor;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));
    final wsConnection = ref.watch(webSocketConnectionProvider);
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.value?.lookup(chatId);
    final pinnedMessagesAsync = ref.watch(pinnedMessagesProvider(chatId));

    // Highlight message state
    final highlightedMessageId = useState<int?>(highlightMessageId);

    // Check for scroll to message from search on every build
    final scrollToMessage = getScrollToMessage(chatId);
    if (scrollToMessage != null && highlightedMessageId.value != scrollToMessage) {
      debugPrint('🔍 [ChatView] Found scroll to message: $scrollToMessage');
      // Use post frame callback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        highlightedMessageId.value = scrollToMessage;
        clearScrollToMessage(chatId);
      });
    }

    // --- MARK AS READ WHEN OPENING CONVERSATION ---
    useEffect(() {
      Future.microtask(() async {
        final conversationId = int.tryParse(chatId);
        if (conversationId == null) return;

        try {
          // Call API to mark conversation as read
          final markAsReadUseCase = ref.read(markConversationAsReadUsecaseProvider);
          final result = await markAsReadUseCase(conversationId: conversationId);

          result.fold(
            (failure) {
              // Log error but don't show to user (non-critical)
              debugPrint('❌ Failed to mark conversation as read: ${failure.message}');
            },
            (_) {
              // Success - update local unread count
              debugPrint('✅ Marked conversation $conversationId as read');
              ref.read(conversationsProvider.notifier).resetUnreadCount(conversationId);
            },
          );
        } catch (e) {
          debugPrint('❌ Error marking conversation as read: $e');
        }
      });

      return null;
    }, [chatId]);

    // --- SCROLL TO HIGHLIGHTED MESSAGE ---
    useEffect(() {
      if (highlightedMessageId.value != null && messagesAsync.hasValue) {
        final messages = messagesAsync.value!;
        final messageIndex = messages.indexWhere((m) => m.id == highlightedMessageId.value);

        debugPrint('🔍 [ChatView] Scroll to message ${highlightedMessageId.value}');
        debugPrint('🔍 [ChatView] Message index: $messageIndex / ${messages.length}');

        if (messageIndex != -1) {
          // Wait for list to build, then scroll using itemScrollController
          Future.delayed(const Duration(milliseconds: 500), () {
            if (scrollController.hasClients) {
              // For reversed list, calculate from bottom
              final reversedIndex = messages.length - messageIndex;
              final targetPosition = reversedIndex * 100.0; // Approximate height

              debugPrint('🔍 [ChatView] Scrolling to position: $targetPosition (reversed index: $reversedIndex)');

              scrollController.animateTo(
                targetPosition,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );

              // Clear highlight after 2 seconds
              Future.delayed(const Duration(seconds: 2), () {
                highlightedMessageId.value = null;
              });
            }
          });
        }
      }
      return null;
    }, [highlightedMessageId.value, messagesAsync]);

    // --- TYPING INDICATOR LOGIC ---
    useEffect(() {
      Timer? debounceTimer;

      void onTextChanged() {
        final text = controller.text.trim();

        if (text.isNotEmpty && !isTyping.value) {
          // Start typing
          debugPrint('⌨️ [Chat] User started typing in conversation: $chatId');
          isTyping.value = true;
          ref.read(typingIndicatorProvider(chatId).notifier).startTyping();
        }

        // Debounce: stop typing after 2 seconds of no input
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
        // Stop typing when leaving the screen
        if (isTyping.value) {
          debugPrint('⌨️ [Chat] User left screen, stopping typing for conversation: $chatId');
          ref.read(typingIndicatorProvider(chatId).notifier).stopTyping();
        }
      };
    }, [controller, chatId]);

    // --- LOGIC LOAD ẢNH ---
    Future<void> loadImages() async {
      // Skip photo_manager on web platform (not supported)
      if (kIsWeb) {
        debugPrint('⚠️ Photo gallery not supported on web platform');
        return;
      }

      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth) {
        await PhotoManager.clearFileCache();
        final filter = FilterOptionGroup(orders: [OrderOption(type: OrderOptionType.createDate, asc: false)]);
        final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
          type: RequestType.common,
          filterOption: filter,
        );

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
      if (!kIsWeb) {
        loadImages();
      }
      return null;
    }, []);

    useEffect(() {
      if (!kIsWeb && appLifecycleState == AppLifecycleState.resumed) {
        loadImages();
      }
      return null;
    }, [appLifecycleState]);

    Future<void> changeAlbum(AssetPathEntity album) async {
      currentAlbum.value = album;
      assets.value = await album.getAssetListPaged(page: 0, size: 80);
    }

    // --- SCROLL LOGIC ---
    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }

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

    // --- HANDLERS ---
    void toggleGallery() {
      // Disable gallery on web platform
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
        showEmojiPicker.value = false; // Hide emoji picker if open
        showStickerPicker.value = false; // Hide sticker picker if open
        showAttachmentPicker.value = false; // Hide attachment picker if open
        Future.delayed(const Duration(milliseconds: 100), () {
          showGallery.value = true;
          loadImages();
        });
      }
    }

    Future<void> sendMessage({String? specificContent, String type = 'TEXT', String? mediaUrl, int? duration}) async {
      debugPrint('🔵 [SendMessage] Sending message - type: $type, replyToMessageId: ${replyToMessage.value?.id}');
      if (selectedAssets.value.isNotEmpty && mediaUrl == null) {
        final cloudinary = ref.read(cloudinaryServiceProvider);
        for (var asset in selectedAssets.value) {
          File? file = await asset.file;
          if (file != null) {
            try {
              final response = asset.type == AssetType.video
                  ? await cloudinary.uploadAudio(file)
                  : await cloudinary.uploadImage(file);

              sendMessage(
                specificContent: '',
                type: asset.type == AssetType.video ? 'VIDEO' : 'IMAGE',
                mediaUrl: response.url,
                duration: asset.duration,
              );
            } catch (_) {}
          }
        }
        selectedAssets.value = [];
        return;
      }

      final content = specificContent ?? controller.text.trim();
      if (content.isEmpty && mediaUrl == null) return;

      final replyId = replyToMessage.value?.id;
      if (specificContent == null) controller.clear();
      replyToMessage.value = null;
      showGallery.value = false;
      scrollToBottom();

      // Stop typing indicator when sending message
      if (isTyping.value) {
        debugPrint('⌨️ [Chat] User sent message, stopping typing for conversation: $chatId');
        isTyping.value = false;
        ref.read(typingIndicatorProvider(chatId).notifier).stopTyping();
      }

      final request = ChatMessageRequest(
        content: content,
        type: type,
        replyToMessageId: replyId,
        mediaUrl: mediaUrl,
        duration: duration,
      );

      if (wsConnection.isConnected) {
        wsDataSource.sendMessage(chatId, request);
        // Wait a moment for the message to be processed, then refresh to get complete data
        Future.delayed(const Duration(milliseconds: 500), () {
          if (replyId != null) {
            debugPrint('🔵 [SendMessage] Refreshing messages to get complete reply data...');
            ref.read(messagesProvider(chatId).notifier).refresh();
          }
        });
      } else {
        final usecase = ref.read(sendMessageUsecaseProvider);
        await usecase(conversationId: chatId, request: request);
        ref.read(messagesProvider(chatId).notifier).refresh();
      }
    }

    void toggleAttachmentPicker() {
      if (showAttachmentPicker.value) {
        // Hide attachment picker, show keyboard
        showAttachmentPicker.value = false;
        focusNode.requestFocus();
      } else {
        // Show attachment picker, hide keyboard
        focusNode.unfocus();
        showGallery.value = false; // Hide gallery if open
        showEmojiPicker.value = false; // Hide emoji picker if open
        showStickerPicker.value = false; // Hide sticker picker if open
        showAttachmentPicker.value = true;
      }
    }

    void onEmojiSelected(String emoji) {
      // Send emoji as EMOJI message type (standalone, displayed larger)
      sendMessage(specificContent: emoji, type: 'EMOJI');
      showEmojiPicker.value = false;
    }

    void onStickerSelected(String stickerUrl) {
      // Send sticker as STICKER message type
      sendMessage(specificContent: '', type: 'STICKER', mediaUrl: stickerUrl);
      showEmojiPicker.value = false;
    }

    Future<void> handleFilePicker() async {
      try {
        final mediaPicker = ref.read(mediaPickerServiceProvider);
        final pickedFile = await mediaPicker.pickDocument();

        if (pickedFile != null) {
          // Upload file to Cloudinary
          final cloudinary = ref.read(cloudinaryServiceProvider);
          final response = await cloudinary.uploadDocument(pickedFile.file, fileName: pickedFile.name);

          // Send file message with metadata
          sendMessage(specificContent: pickedFile.name, type: 'FILE', mediaUrl: response.url);
        }
      } catch (e) {
        debugPrint('Error picking file: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể chọn file: $e')));
        }
      }
    }

    Future<void> handleCamera() async {
      try {
        final mediaPicker = ref.read(mediaPickerServiceProvider);
        final photoFile = await mediaPicker.takePhoto(context);

        if (photoFile != null) {
          // Upload image to Cloudinary
          final cloudinary = ref.read(cloudinaryServiceProvider);
          final response = await cloudinary.uploadImage(photoFile);

          // Send image message
          sendMessage(specificContent: '', type: 'IMAGE', mediaUrl: response.url);
        }
      } catch (e) {
        debugPrint('Error taking photo: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể chụp ảnh: $e')));
        }
      }
    }

    Future<void> handleGallery() async {
      try {
        final mediaPicker = ref.read(mediaPickerServiceProvider);
        final imageFile = await mediaPicker.pickImageFromGallery(context);

        if (imageFile != null) {
          // Upload image to Cloudinary
          final cloudinary = ref.read(cloudinaryServiceProvider);
          final response = await cloudinary.uploadImage(imageFile);

          // Send image message
          sendMessage(specificContent: '', type: 'IMAGE', mediaUrl: response.url);
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể chọn ảnh: $e')));
        }
      }
    }

    Future<void> handleVideo() async {
      try {
        final mediaPicker = ref.read(mediaPickerServiceProvider);
        final videoFile = await mediaPicker.pickVideoFromGallery(context);

        if (videoFile != null) {
          // Upload video to Cloudinary
          final cloudinary = ref.read(cloudinaryServiceProvider);
          final response = await cloudinary.uploadVideo(videoFile);

          // Send video message
          sendMessage(specificContent: '', type: 'VIDEO', mediaUrl: response.url);
        }
      } catch (e) {
        debugPrint('Error picking video: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể chọn video: $e')));
        }
      }
    }

    Future<void> handleAudio() async {
      try {
        debugPrint('📁 [Audio] Starting audio picker...');
        final mediaPicker = ref.read(mediaPickerServiceProvider);
        final audioFile = await mediaPicker.pickAudioFile();

        if (audioFile == null) {
          debugPrint('📁 [Audio] No audio file selected');
          return;
        }

        debugPrint('📁 [Audio] Audio file selected: ${audioFile.path}');

        // Show loading indicator
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đang upload audio...'), duration: Duration(seconds: 30)));

        // Upload audio to Cloudinary
        debugPrint('☁️ [Audio] Uploading to Cloudinary...');
        final cloudinary = ref.read(cloudinaryServiceProvider);
        final response = await cloudinary.uploadAudio(audioFile);
        debugPrint('☁️ [Audio] Upload successful: ${response.url}');

        // Send audio message
        sendMessage(specificContent: '', type: 'AUDIO', mediaUrl: response.url);
        debugPrint('✅ [Audio] Audio message sent');

        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Audio đã được gửi'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e, stackTrace) {
        debugPrint('❌ [Audio] Error: $e');
        debugPrint('❌ [Audio] Stack trace: $stackTrace');

        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Provide more specific error messages
          String errorMessage = 'Không thể chọn audio';
          if (e.toString().contains('permission')) {
            errorMessage = 'Không có quyền truy cập file. Vui lòng cấp quyền trong cài đặt.';
          } else if (e.toString().contains('upload')) {
            errorMessage = 'Không thể upload audio. Vui lòng kiểm tra kết nối mạng.';
          } else if (e.toString().contains('size')) {
            errorMessage = 'File audio quá lớn. Vui lòng chọn file nhỏ hơn.';
          } else {
            errorMessage = 'Lỗi: ${e.toString()}';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: 'Đóng',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      }
    }

    void handleAttachmentSelection(AttachmentType type) {
      // Handle each attachment type
      switch (type) {
        case AttachmentType.camera:
          showAttachmentPicker.value = false;
          handleCamera();
          break;
        case AttachmentType.gallery:
          showAttachmentPicker.value = false;
          handleGallery();
          break;
        case AttachmentType.video:
          showAttachmentPicker.value = false;
          handleVideo();
          break;
        case AttachmentType.document:
          showAttachmentPicker.value = false;
          handleFilePicker();
          break;
        case AttachmentType.emoji:
          // Switch to emoji-only picker
          showAttachmentPicker.value = false;
          showStickerPicker.value = false;
          showEmojiPicker.value = true;
          break;
        case AttachmentType.sticker:
          // Switch to sticker-only picker
          showAttachmentPicker.value = false;
          showEmojiPicker.value = false;
          showStickerPicker.value = true;
          break;
        case AttachmentType.poll:
          // Navigate to create poll page
          showAttachmentPicker.value = false;
          context.push('/chat/$chatId/create-poll');
          break;
        case AttachmentType.schedule:
          // Navigate to schedule message page
          showAttachmentPicker.value = false;
          final conversationId = int.tryParse(chatId);
          if (conversationId != null) {
            context.push('/chat/$conversationId/schedule-message');
          }
          break;
      }
    }

    Future<void> handleVoiceRecording() async {
      final voiceRecorder = ref.read(voiceRecorderServiceProvider);

      if (isRecording.value) {
        // Stop recording and send
        final duration = recordingDuration.value; // Save duration before reset
        final file = await voiceRecorder.stopRecording();
        isRecording.value = false;
        recordingDuration.value = Duration.zero;

        if (file != null) {
          try {
            // Upload to Cloudinary
            final cloudinary = ref.read(cloudinaryServiceProvider);
            final response = await cloudinary.uploadAudio(file);

            // Send voice message
            sendMessage(specificContent: '', type: 'VOICE', mediaUrl: response.url, duration: duration.inSeconds);
          } catch (e) {
            debugPrint('Error uploading voice: $e');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Không thể gửi voice message: $e')));
            }
          }
        }
      } else {
        // Start recording
        try {
          final path = await voiceRecorder.startRecording();
          if (path != null) {
            isRecording.value = true;
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Không thể bắt đầu ghi âm. Vui lòng cấp quyền microphone.')));
            }
          }
        } catch (e) {
          debugPrint('Error starting recording: $e');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi ghi âm: $e')));
          }
        }
      }
    }

    Future<void> handleCancelRecording() async {
      final voiceRecorder = ref.read(voiceRecorderServiceProvider);
      await voiceRecorder.cancelRecording();
      isRecording.value = false;
      recordingDuration.value = Duration.zero;
    }

    // Listen to recording duration
    useEffect(() {
      if (isRecording.value) {
        final voiceRecorder = ref.read(voiceRecorderServiceProvider);
        final subscription = voiceRecorder.durationStream.listen((duration) {
          recordingDuration.value = duration;

          // Auto-stop at 5 minutes
          if (duration.inMinutes >= 5) {
            handleVoiceRecording();
          }
        });
        return subscription.cancel;
      }
      return null;
    }, [isRecording.value]);

    // Hide pickers when keyboard shows
    useEffect(() {
      void onFocusChange() {
        if (focusNode.hasFocus) {
          // Hide emoji picker when keyboard shows
          if (showEmojiPicker.value) {
            showEmojiPicker.value = false;
          }
          // Hide sticker picker when keyboard shows
          if (showStickerPicker.value) {
            showStickerPicker.value = false;
          }
          // Hide attachment picker when keyboard shows
          if (showAttachmentPicker.value) {
            showAttachmentPicker.value = false;
          }
        }
      }

      focusNode.addListener(onFocusChange);
      return () => focusNode.removeListener(onFocusChange);
    }, [focusNode]);

    void handleAudioCall() {
      if (conversation == null || me == null) return;

      // For group calls, show not supported message
      if (conversation.type == ConversationType.group) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Group calls are not supported yet')));
        return;
      }

      // Get the other participant's ID
      final otherParticipant = ConversationUtils.getOtherParticipant(conversation, me);
      if (otherParticipant == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot find participant to call')));
        return;
      }

      // Get callee name and avatar
      final calleeName = ConversationUtils.getConversationTitle(conversation, me);
      final calleeAvatar = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);

      // Initiate audio call
      ref
          .read(callProvider.notifier)
          .initiateCall(otherParticipant.userId, CallType.audio, calleeName: calleeName, calleeAvatar: calleeAvatar);
    }

    void handleVideoCall() {
      if (conversation == null || me == null) return;

      // For group calls, show not supported message
      if (conversation.type == ConversationType.group) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Group calls are not supported yet')));
        return;
      }

      // Get the other participant's ID
      final otherParticipant = ConversationUtils.getOtherParticipant(conversation, me);
      if (otherParticipant == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot find participant to call')));
        return;
      }

      // Get callee name and avatar
      final calleeName = ConversationUtils.getConversationTitle(conversation, me);
      final calleeAvatar = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);

      // Initiate video call
      ref
          .read(callProvider.notifier)
          .initiateCall(otherParticipant.userId, CallType.video, calleeName: calleeName, calleeAvatar: calleeAvatar);
    }

    void handleConversationInfo() {
      if (conversation == null) return;

      // Navigate to conversation info page
      context.push('/chat/$chatId/info', extra: conversation);
    }

    Future<void> handlePinMessage(Message message) async {
      try {
        if (message.pinned) {
          // Unpin message
          await ref.read(unpinMessageUsecaseProvider)(conversationId: chatId, messageId: message.id.toString());
        } else {
          // Pin message
          await ref.read(pinMessageUsecaseProvider)(conversationId: chatId, messageId: message.id.toString());
        }

        // Refresh both messages and pinned messages
        ref.read(messagesProvider(chatId).notifier).refresh();
        ref.invalidate(pinnedMessagesProvider(chatId));

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(message.pinned ? 'Message unpinned' : 'Message pinned', style: TextStyle(color: Colors.white)),
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
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed: $e', style: TextStyle(color: Colors.white)),
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

    // --- UI ---
    return PopScope(
      canPop: !showGallery.value,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        showGallery.value = false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        // HEADER
        appBar: _buildFullAppBar(
          context,
          conversation,
          me,
          isDark,
          onAudioCall: handleAudioCall,
          onVideoCall: handleVideoCall,
          onInfo: handleConversationInfo,
        ),
        body: GestureDetector(
          onTap: () {
            // Close all pickers when tapping outside
            if (showGallery.value) showGallery.value = false;
            if (showEmojiPicker.value) showEmojiPicker.value = false;
            if (showStickerPicker.value) showStickerPicker.value = false;
            if (showAttachmentPicker.value) showAttachmentPicker.value = false;
            focusNode.unfocus();
          },
          child: Column(
            children: [
              // Pinned Messages Banner
              if (pinnedMessagesAsync.hasValue && pinnedMessagesAsync.value!.isNotEmpty)
                PinnedMessagesBanner(pinnedMessages: pinnedMessagesAsync.value!, conversationId: chatId),
              Expanded(
                child: Stack(
                  children: [
                    _MessageList(
                      messagesAsync: messagesAsync,
                      me: me,
                      conversation: conversation,
                      scrollController: scrollController,
                      typingIndicator: typingIndicator,
                      highlightedMessageId: highlightedMessageId.value,
                      onReply: (m) => replyToMessage.value = m,
                      onPin: handlePinMessage,
                      onReactionTap: (m, e) async {
                        final result = await ref.read(toggleReactionUsecaseProvider)(
                          messageId: m.id.toString(),
                          emoji: e,
                        );
                        result.fold(
                          (failure) => debugPrint('Failed to toggle reaction: ${failure.message}'),
                          (_) => ref.read(messagesProvider(chatId).notifier).refresh(),
                        );
                      },
                      onAddReaction: (m) => showReactionPicker(context, (e) async {
                        final result = await ref.read(toggleReactionUsecaseProvider)(
                          messageId: m.id.toString(),
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
                                messageId: m.id.toString(),
                                content: newContent,
                              );
                              result.fold(
                                (failure) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(SnackBar(content: Text('Error: ${failure.message}')));
                                  }
                                },
                                (_) {
                                  ref.read(messagesProvider(chatId).notifier).refresh();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Message updated'), duration: Duration(seconds: 1)),
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
                          messageId: m.id.toString(),
                        );
                        ref.read(messagesProvider(chatId).notifier).refresh();
                      },
                    ),

                    if (showScrollButton.value)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: FloatingActionButton.small(
                            onPressed: scrollToBottom,
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

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (replyToMessage.value != null)
                    ReplyMessagePreview(
                      replyToMessage: replyToMessage.value!,
                      onCancel: () => replyToMessage.value = null,
                    ),

                  _InputBar(
                    controller: controller,
                    focusNode: focusNode,
                    onSend: sendMessage,
                    chatId: chatId,
                    isDark: isDark,
                    primaryColor: primaryColor,
                    showGallery: showGallery.value,
                    canSendMessage: controller.text.trim().isNotEmpty || selectedAssets.value.isNotEmpty,
                    onToggleGallery: toggleGallery,
                    isRecording: isRecording,
                    recordingDuration: recordingDuration.value,
                    onVoiceRecord: handleVoiceRecording,
                    onCancelRecording: handleCancelRecording,
                    onFilePick: handleFilePicker,
                    onCamera: handleCamera,
                    onGallery: handleGallery,
                    onVideo: handleVideo,
                    onAudio: handleAudio,
                    showAttachmentPicker: showAttachmentPicker.value,
                    onToggleAttachmentPicker: toggleAttachmentPicker,
                    conversation: conversation,
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {}, // Prevent closing when tapping inside gallery
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutQuad,
                  height: showGallery.value ? MediaQuery.of(context).size.height * 0.45 : 0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : Colors.white),
                  child: showGallery.value
                      ? _RealMediaGallery(
                          albums: albums.value,
                          currentAlbum: currentAlbum.value,
                          assets: assets.value,
                          selectedAssets: selectedAssets.value,
                          onCameraTap: handleCamera,
                          onAlbumChanged: changeAlbum,
                          onAssetSelect: (asset) {
                            final list = List<AssetEntity>.from(selectedAssets.value);
                            list.contains(asset) ? list.remove(asset) : list.add(asset);
                            selectedAssets.value = list;
                          },
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              // Emoji/Sticker & Attachment Picker (Combined for smooth animation)
              GestureDetector(
                onTap: () {}, // Prevent closing when tapping inside picker
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutQuad,
                  height: (showEmojiPicker.value || showStickerPicker.value || showAttachmentPicker.value) ? 350 : 0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(color: isDark ? const Color(0xFF1C1C1E) : Colors.white),
                  child: (showEmojiPicker.value || showStickerPicker.value || showAttachmentPicker.value)
                      ? IndexedStack(
                          index: showAttachmentPicker.value ? 0 : (showEmojiPicker.value ? 1 : 2),
                          children: [
                            // Attachment Picker
                            AttachmentPicker(
                              key: const ValueKey('attachment_picker'),
                              onAttachmentSelected: handleAttachmentSelection,
                              backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                              iconColor: primaryColor,
                            ),
                            // Emoji Only Picker
                            EmojiOnlyPicker(
                              key: const ValueKey('emoji_only_picker'),
                              onEmojiSelected: onEmojiSelected,
                              backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                              iconColor: primaryColor,
                            ),
                            // Sticker Only Picker
                            StickerOnlyPicker(
                              key: const ValueKey('sticker_only_picker'),
                              onStickerSelected: onStickerSelected,
                              backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                              iconColor: primaryColor,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildFullAppBar(
    BuildContext context,
    dynamic conversation,
    dynamic me,
    bool isDark, {
    required VoidCallback onAudioCall,
    required VoidCallback onVideoCall,
    required VoidCallback onInfo,
  }) {
    final color = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    if (conversation == null) {
      return AppBar(elevation: 0, backgroundColor: appBarColor, surfaceTintColor: Colors.transparent);
    }

    final title = ConversationUtils.getConversationTitle(conversation, me);

    // Check if it's a group conversation
    final bool isGroup = conversation.type == ConversationType.group;

    // Get avatar URL based on conversation type
    String? avatarUrl;
    if (isGroup) {
      // For group conversations, use the group avatar
      avatarUrl = conversation.avatarUrl;
    } else {
      // For direct conversations, get the other participant's avatar
      avatarUrl = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);
    }

    // Check online status only for direct conversations
    final bool isOnline = isGroup ? false : ConversationUtils.isUserOnline(conversation, me);

    return AppBar(
      backgroundColor: appBarColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      scrolledUnderElevation: 2,
      leadingWidth: 40,
      leading: BackButton(
        color: color,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
      ),
      title: Row(
        children: [
          UserAvatar(avatarUrl: avatarUrl, displayName: title, radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (!isGroup) ...[
                  const SizedBox(height: 2),
                  Text(
                    ConversationUtils.formatLastSeen(isOnline, ConversationUtils.getLastSeen(conversation, me)),
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Audio call button
        IconButton(
          icon: Icon(Icons.call_outlined, color: color, size: 24),
          onPressed: onAudioCall,
          tooltip: 'Audio call',
        ),
        // Video call button
        IconButton(
          icon: Icon(Icons.videocam_outlined, color: color, size: 26),
          onPressed: onVideoCall,
          tooltip: 'Video call',
        ),
        // Info button
        IconButton(
          icon: Icon(Icons.info_outline, color: color, size: 24),
          onPressed: onInfo,
          tooltip: 'Thông tin',
        ),
      ],
    );
  }
}

// ============================================================================
// MESSAGE LIST (GIỮ NGUYÊN)
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

  /// Get avatar URL for a sender from conversation participants
  String? _getSenderAvatar(int senderId) {
    if (conversation == null) return null;
    try {
      final participant = conversation.participants.firstWhere((p) => p.userId == senderId, orElse: () => null);
      return participant?.avatarUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return messagesAsync.when(
      data: (messages) {
        // Determine if this is a group conversation
        final isGroup = conversation?.type == ConversationType.group;

        // Find the last message from current user (for seen status display)
        int? lastMessageFromMeIndex;
        if (me != null) {
          for (int i = 0; i < messages.length; i++) {
            if (messages[i].senderId == me!.id) {
              lastMessageFromMeIndex = i;
              break; // Found the most recent message from me (list is reversed)
            }
          }
        }

        return ListView.builder(
          controller: scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: messages.length + 1,
          // +1 for typing indicator
          itemBuilder: (context, index) {
            // Show typing indicator at the bottom (index 0 in reversed list)
            if (index == 0) {
              return TypingIndicatorWidget(typingIndicator: typingIndicator, currentUserId: me?.id);
            }

            // Adjust index for messages (subtract 1 because of typing indicator)
            final messageIndex = index - 1;
            final m = messages[messageIndex];
            final isMe = m.senderId == me?.id;
            final isLastMessageFromMe = isMe && messageIndex == lastMessageFromMeIndex;
            final isSystemMessage = m.type == 'SYSTEM';

            bool showAvatar = !isMe && !isSystemMessage;
            if (messageIndex > 0 && messages[messageIndex - 1].senderId == m.senderId) showAvatar = false;
            // Khoảng cách giữa các tin nhắn
            double marginBottom = (messageIndex > 0 && messages[messageIndex - 1].senderId != m.senderId) ? 8.0 : 0.0;

            return Padding(
              padding: EdgeInsets.only(bottom: marginBottom),
              child: Stack(
                children: [
                  // Avatar (positioned absolutely for non-me messages)
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
                  // Message bubble with highlight border
                  Padding(
                    padding: EdgeInsets.only(left: isMe || isSystemMessage ? 0 : 36), // No space for system messages
                    child: Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : (isSystemMessage ? Alignment.center : Alignment.centerLeft),
                      child: m.scheduled
                          ? // Scheduled message - no border container, pass highlight directly
                            MessageBubble(
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
                              isGroup: isGroup,
                              isLastMessage: isLastMessageFromMe,
                              isHighlighted: m.id == highlightedMessageId,
                            )
                          : // Regular message - wrap with border container
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: m.id == highlightedMessageId ? const EdgeInsets.all(3) : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                border: m.id == highlightedMessageId ? Border.all(color: Colors.blue, width: 2) : null,
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

// ============================================================================
// GALLERY & INPUT BAR (GIỮ NGUYÊN)
// ============================================================================
class _RealMediaGallery extends StatelessWidget {
  final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  final List<AssetEntity> assets;
  final List<AssetEntity> selectedAssets;
  final VoidCallback onCameraTap;
  final Function(AssetPathEntity) onAlbumChanged;
  final Function(AssetEntity) onAssetSelect;

  const _RealMediaGallery({
    required this.albums,
    required this.currentAlbum,
    required this.assets,
    required this.selectedAssets,
    required this.onCameraTap,
    required this.onAlbumChanged,
    required this.onAssetSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDark ? Colors.black12 : Colors.grey[100],
            border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AssetPathEntity>(
              value: currentAlbum,
              isDense: true,
              isExpanded: true,
              dropdownColor: isDark ? const Color(0xFF2C2C2E) : Colors.white,
              items: albums
                  .map(
                    (album) => DropdownMenuItem(
                      value: album,
                      child: FutureBuilder<int>(
                        future: album.assetCountAsync,
                        initialData: 0,
                        builder: (ctx, snap) => Text(
                          "${album.name} (${snap.data})",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) onAlbumChanged(val);
              },
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            key: const PageStorageKey('media_gallery'),
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: assets.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: onCameraTap,
                  child: Container(
                    color: Colors.grey[800],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white),
                        Text("Camera", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }
              final asset = assets[index - 1];
              return _MediaGridItem(
                asset: asset,
                isSelected: selectedAssets.contains(asset),
                onTap: () => onAssetSelect(asset),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MediaGridItem extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final VoidCallback onTap;

  const _MediaGridItem({required this.asset, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _AssetThumbnail(asset: asset),
          if (isSelected) Container(color: Colors.white.withValues(alpha: 0.4)),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ),
          if (asset.type == AssetType.video)
            Positioned(
              bottom: 4,
              right: 4,
              child: Text(
                _formatDuration(asset.duration),
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDuration(int s) =>
      '${(Duration(seconds: s)).inMinutes}:${(Duration(seconds: s).inSeconds % 60).toString().padLeft(2, '0')}';
}

class _AssetThumbnail extends StatefulWidget {
  final AssetEntity asset;

  const _AssetThumbnail({required this.asset});

  @override
  State<_AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<_AssetThumbnail> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final bytes = await widget.asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
    if (mounted) setState(() => _bytes = bytes);
  }

  @override
  Widget build(BuildContext context) => _bytes == null
      ? Container(color: Colors.grey[300])
      : Image.memory(_bytes!, fit: BoxFit.cover, gaplessPlayback: true);
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.chatId,
    required this.isDark,
    required this.primaryColor,
    required this.showGallery,
    required this.canSendMessage,
    required this.onToggleGallery,
    required this.isRecording,
    required this.recordingDuration,
    required this.onVoiceRecord,
    required this.onCancelRecording,
    required this.onFilePick,
    required this.onCamera,
    required this.onGallery,
    required this.onVideo,
    required this.onAudio,
    required this.showAttachmentPicker,
    required this.onToggleAttachmentPicker,
    this.conversation,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function({String? specificContent, String type, String? mediaUrl, int? duration}) onSend;
  final String chatId;
  final bool isDark;
  final Color primaryColor;
  final bool showGallery;
  final bool canSendMessage;
  final VoidCallback onToggleGallery;
  final ValueNotifier<bool> isRecording;
  final Duration recordingDuration;
  final VoidCallback onVoiceRecord;
  final VoidCallback onCancelRecording;
  final VoidCallback onFilePick;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onVideo;
  final VoidCallback onAudio;
  final bool showAttachmentPicker;
  final VoidCallback onToggleAttachmentPicker;
  final dynamic conversation;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // Show recording overlay when recording
    if (isRecording.value) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5)),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            children: [
              // Recording indicator
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              // Duration and hint - use Expanded to take remaining space
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDuration(recordingDuration),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Recording...',
                      style: TextStyle(
                        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Cancel button
              TextButton(
                onPressed: onCancelRecording,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              // Send button - use simple ElevatedButton without icon
              ElevatedButton(
                onPressed: onVoiceRecord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  minimumSize: const Size(70, 40),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.send, size: 18), SizedBox(width: 6), Text('Send')],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // + button
            Container(
              decoration: BoxDecoration(
                color: showAttachmentPicker ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add_circle_outline, color: primaryColor, size: 28),
                onPressed: onToggleAttachmentPicker,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Gallery button
            Container(
              decoration: BoxDecoration(
                color: showGallery ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.image_outlined, color: primaryColor, size: 26),
                onPressed: onToggleGallery,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Mic button (when no text) - Long press to record
            if (!canSendMessage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: onVoiceRecord,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Icon(Icons.mic_none, color: primaryColor, size: 26),
                  ),
                ),
              ),
            // Text input
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 40, maxHeight: 120),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF303030) : const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MentionTextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: null,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16),
                  users:
                      conversation?.participants
                          .map<MentionableUser>(
                            (p) =>
                                MentionableUser(id: p.userId, name: p.fullName ?? p.username, avatarUrl: p.avatarUrl),
                          )
                          .toList() ??
                      [],
                  onMentionAdded: (user) {
                    debugPrint('Mentioned user: ${user.name}');
                  },
                  decoration: InputDecoration(
                    hintText: 'Aa',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ),
            // Like button (when no text)
            if (!canSendMessage)
              IconButton(
                icon: Icon(Icons.thumb_up_outlined, color: primaryColor, size: 24),
                onPressed: () {
                  // Send like emoji
                  onSend(specificContent: '👍', type: 'TEXT');
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            // Send button (when has text)
            if (canSendMessage)
              IconButton(
                icon: Icon(Icons.send, color: primaryColor),
                onPressed: () => onSend(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
          ],
        ),
      ),
    );
  }
}

extension ListLookup on List<dynamic> {
  dynamic lookup(String id) {
    if (isEmpty) return null;
    try {
      return firstWhere((e) => e.id.toString() == id);
    } catch (_) {
      return null;
    }
  }
}

void showReactionPicker(BuildContext context, Function(String) onReactionSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (c) => Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['👍', '❤️', '😂', '😮', '😢', '😡']
            .map(
              (e) => GestureDetector(
                onTap: () {
                  onReactionSelected(e);
                  Navigator.pop(c);
                },
                child: Text(e, style: const TextStyle(fontSize: 28)),
              ),
            )
            .toList(),
      ),
    ),
  );
}
