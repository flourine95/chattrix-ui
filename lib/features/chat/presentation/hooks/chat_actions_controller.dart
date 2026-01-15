import 'dart:async';
import 'dart:io';

import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/typing_indicator_provider.dart';
import 'package:chattrix_ui/features/chat/services/cloudinary_provider.dart';
import 'package:chattrix_ui/features/chat/services/media_picker_provider.dart';
import 'package:chattrix_ui/features/chat/services/media_upload_service.dart';
import 'package:chattrix_ui/features/chat/services/voice_recorder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

/// Controller for chat actions (send message, upload media, record voice, etc.)
/// This separates business logic from UI
class ChatActionsController {
  final WidgetRef ref;
  final int chatId;
  final BuildContext context;
  final TextEditingController textController;
  final ValueNotifier<Message?> replyToMessage;
  final ValueNotifier<List<AssetEntity>> selectedAssets;
  final VoidCallback scrollToBottom;
  final ValueNotifier<bool> isTyping;
  final ValueNotifier<bool> showGallery;

  ChatActionsController({
    required this.ref,
    required this.chatId,
    required this.context,
    required this.textController,
    required this.replyToMessage,
    required this.selectedAssets,
    required this.scrollToBottom,
    required this.isTyping,
    required this.showGallery,
  });

  // --- SEND MESSAGE ---

  /// Send message (handles text, media, emoji, sticker, etc.)
  Future<void> sendMessage({
    String? specificContent,
    String type = 'TEXT',
    String? mediaUrl,
    int? duration,
    int? replyId,
  }) async {
    debugPrint('🔵 [SendMessage] ===== SENDING MESSAGE =====');
    debugPrint('🔵 [SendMessage] Type: $type');
    debugPrint('🔵 [SendMessage] ReplyToMessageId: ${replyId ?? replyToMessage.value?.id}');

    // Handle selected assets from gallery
    if (selectedAssets.value.isNotEmpty && mediaUrl == null) {
      await _sendSelectedAssets();
      return;
    }

    final content = specificContent ?? textController.text.trim();
    if (content.isEmpty && mediaUrl == null) return;

    debugPrint('🔵 [SendMessage] Content: "$content"');
    debugPrint('🔵 [SendMessage] MediaUrl: $mediaUrl');

    final finalReplyId = replyId ?? replyToMessage.value?.id;

    // Clear UI
    if (specificContent == null) textController.clear();
    
    // Only clear reply if this is not a recursive call (replyId not passed)
    if (replyId == null) {
      replyToMessage.value = null;
    }
    
    showGallery.value = false;
    scrollToBottom();

    // Stop typing indicator
    _stopTyping();

    // Create request
    final request = ChatMessageRequest(
      content: content,
      type: type,
      replyToMessageId: finalReplyId,
      mediaUrl: mediaUrl,
      duration: duration,
    );

    debugPrint('🔵 [SendMessage] Request created: ${request.toJson()}');

    // Send via UseCase (UseCase will handle WS vs API logic)
    final usecase = ref.read(sendMessageUsecaseProvider);
    await usecase(conversationId: chatId, request: request);

    // Refresh messages if reply (to get complete data)
    if (finalReplyId != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        ref.read(messagesProvider(chatId).notifier).refresh();
      });
    }

    debugPrint('🔵 [SendMessage] ===== MESSAGE SENT =====');
  }

  /// Send selected assets from gallery
  Future<void> _sendSelectedAssets() async {
    // Capture reply ID and text before clearing
    final capturedReplyId = replyToMessage.value?.id;
    final textContent = textController.text.trim();
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));

    try {
      final results = await uploadService.uploadAssets(selectedAssets.value);

      for (var i = 0; i < results.length; i++) {
        final result = results[i];
        
        // First asset gets the text content (caption), others are sent without text
        final caption = (i == 0 && textContent.isNotEmpty) ? textContent : '';
        
        await sendMessage(
          specificContent: caption,
          type: result.type,
          mediaUrl: result.url,
          duration: result.duration,
          replyId: capturedReplyId,  // Pass reply ID explicitly
        );
      }

      textController.clear();
      selectedAssets.value = [];
      replyToMessage.value = null;  // Clear reply after all messages sent
    } catch (e) {
      debugPrint('❌ [SendMessage] Failed to upload assets: $e');
      _showError('Failed to upload media: $e');
    }
  }

  // --- MEDIA HANDLERS ---

  Future<void> handleCamera({TextEditingController? textController}) async {
    try {
      final mediaPicker = ref.read(mediaPickerServiceProvider);
      final photoFile = await mediaPicker.takePhoto(context);

      if (photoFile != null) {
        final caption = textController?.text.trim();
        final capturedReplyId = replyToMessage.value?.id;
        await _uploadAndSendImage(photoFile, caption: caption, replyId: capturedReplyId);
        textController?.clear();
        replyToMessage.value = null;
      }
    } catch (e) {
      debugPrint('❌ [Camera] Error: $e');
      _showError('Không thể chụp ảnh: $e');
    }
  }

  Future<void> handleGallery({TextEditingController? textController}) async {
    try {
      final mediaPicker = ref.read(mediaPickerServiceProvider);
      final imageFile = await mediaPicker.pickImageFromGallery(context);

      if (imageFile != null) {
        final caption = textController?.text.trim();
        final capturedReplyId = replyToMessage.value?.id;
        await _uploadAndSendImage(imageFile, caption: caption, replyId: capturedReplyId);
        textController?.clear();
        replyToMessage.value = null;
      }
    } catch (e) {
      debugPrint('❌ [Gallery] Error: $e');
      _showError('Không thể chọn ảnh: $e');
    }
  }

  Future<void> handleVideo({TextEditingController? textController}) async {
    try {
      final mediaPicker = ref.read(mediaPickerServiceProvider);
      final videoFile = await mediaPicker.pickVideoFromGallery(context);

      if (videoFile != null) {
        final caption = textController?.text.trim();
        final capturedReplyId = replyToMessage.value?.id;
        await _uploadAndSendVideo(videoFile, caption: caption, replyId: capturedReplyId);
        textController?.clear();
        replyToMessage.value = null;
      }
    } catch (e) {
      debugPrint('❌ [Video] Error: $e');
      _showError('Không thể chọn video: $e');
    }
  }

  Future<void> handleFilePicker() async {
    try {
      final mediaPicker = ref.read(mediaPickerServiceProvider);
      final pickedFile = await mediaPicker.pickDocument();

      if (pickedFile != null) {
        final capturedReplyId = replyToMessage.value?.id;
        await _uploadAndSendDocument(pickedFile.file, pickedFile.name, replyId: capturedReplyId);
        replyToMessage.value = null;
      }
    } catch (e) {
      debugPrint('❌ [FilePicker] Error: $e');
      _showError('Không thể chọn file: $e');
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

      // Show loading
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading audio...'), duration: Duration(seconds: 30)),
      );

      final capturedReplyId = replyToMessage.value?.id;
      await _uploadAndSendAudio(audioFile, replyId: capturedReplyId);
      replyToMessage.value = null;

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio sent successfully'),
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

        String errorMessage = 'Unable to select audio';
        if (e.toString().contains('permission')) {
          errorMessage = 'No file access permission. Please grant permission in settings.';
        } else if (e.toString().contains('upload')) {
          errorMessage = 'Unable to upload audio. Please check your network connection.';
        } else if (e.toString().contains('size')) {
          errorMessage = 'Audio file is too large. Please select a smaller file.';
        } else {
          errorMessage = 'Error: ${e.toString()}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
          ),
        );
      }
    }
  }

  // --- VOICE RECORDING ---

  Future<void> handleVoiceRecording({
    required ValueNotifier<bool> isRecording,
    required ValueNotifier<Duration> recordingDuration,
  }) async {
    final voiceRecorder = ref.read(voiceRecorderServiceProvider);

    if (isRecording.value) {
      // Stop recording and send
      final duration = recordingDuration.value;
      final capturedReplyId = replyToMessage.value?.id;
      final file = await voiceRecorder.stopRecording();
      isRecording.value = false;
      recordingDuration.value = Duration.zero;

      if (file != null) {
        try {
          await _uploadAndSendVoice(file, duration.inSeconds, replyId: capturedReplyId);
          replyToMessage.value = null;
        } catch (e) {
          debugPrint('❌ [Voice] Error uploading: $e');
          _showError('Unable to send voice message: $e');
        }
      }
    } else {
      // Start recording
      try {
        final path = await voiceRecorder.startRecording();
        if (path != null) {
          isRecording.value = true;
        } else {
          _showError('Unable to start recording. Please grant microphone permission.');
        }
      } catch (e) {
        debugPrint('❌ [Voice] Error starting: $e');
        _showError('Recording error: $e');
      }
    }
  }

  Future<void> handleCancelRecording({
    required ValueNotifier<bool> isRecording,
    required ValueNotifier<Duration> recordingDuration,
  }) async {
    final voiceRecorder = ref.read(voiceRecorderServiceProvider);
    await voiceRecorder.cancelRecording();
    isRecording.value = false;
    recordingDuration.value = Duration.zero;
  }

  // --- UPLOAD HELPERS ---

  Future<void> _uploadAndSendImage(File file, {String? caption, int? replyId}) async {
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));
    final url = await uploadService.uploadImage(file);
    await sendMessage(specificContent: caption ?? '', type: 'IMAGE', mediaUrl: url, replyId: replyId);
  }

  Future<void> _uploadAndSendVideo(File file, {String? caption, int? replyId}) async {
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));
    final url = await uploadService.uploadVideo(file);
    await sendMessage(specificContent: caption ?? '', type: 'VIDEO', mediaUrl: url, replyId: replyId);
  }

  Future<void> _uploadAndSendAudio(File file, {int? replyId}) async {
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));
    final url = await uploadService.uploadAudio(file);
    await sendMessage(specificContent: '', type: 'AUDIO', mediaUrl: url, replyId: replyId);
  }

  Future<void> _uploadAndSendVoice(File file, int duration, {int? replyId}) async {
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));
    final url = await uploadService.uploadAudio(file);
    await sendMessage(specificContent: '', type: 'VOICE', mediaUrl: url, duration: duration, replyId: replyId);
  }

  Future<void> _uploadAndSendDocument(File file, String fileName, {int? replyId}) async {
    final uploadService = MediaUploadService(ref.read(cloudinaryServiceProvider));
    final url = await uploadService.uploadDocument(file, fileName: fileName);
    await sendMessage(specificContent: fileName, type: 'FILE', mediaUrl: url, replyId: replyId);
  }

  // --- TYPING INDICATOR ---

  void _stopTyping() {
    if (isTyping.value) {
      debugPrint('⌨️ [Chat] User sent message, stopping typing for conversation: $chatId');
      isTyping.value = false;
      ref.read(typingIndicatorProvider(chatId).notifier).stopTyping();
    }
  }

  // --- ERROR HANDLING ---

  void _showError(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}

/// Hook to create ChatActionsController
ChatActionsController useChatActions({
  required WidgetRef ref,
  required int chatId,
  required BuildContext context,
  required TextEditingController textController,
  required ValueNotifier<Message?> replyToMessage,
  required ValueNotifier<List<AssetEntity>> selectedAssets,
  required VoidCallback scrollToBottom,
  required ValueNotifier<bool> isTyping,
  required ValueNotifier<bool> showGallery,
}) {
  return use(
    _ChatActionsControllerHook(
      ref: ref,
      chatId: chatId,
      context: context,
      textController: textController,
      replyToMessage: replyToMessage,
      selectedAssets: selectedAssets,
      scrollToBottom: scrollToBottom,
      isTyping: isTyping,
      showGallery: showGallery,
    ),
  );
}

class _ChatActionsControllerHook extends Hook<ChatActionsController> {
  final WidgetRef ref;
  final int chatId;
  final BuildContext context;
  final TextEditingController textController;
  final ValueNotifier<Message?> replyToMessage;
  final ValueNotifier<List<AssetEntity>> selectedAssets;
  final VoidCallback scrollToBottom;
  final ValueNotifier<bool> isTyping;
  final ValueNotifier<bool> showGallery;

  const _ChatActionsControllerHook({
    required this.ref,
    required this.chatId,
    required this.context,
    required this.textController,
    required this.replyToMessage,
    required this.selectedAssets,
    required this.scrollToBottom,
    required this.isTyping,
    required this.showGallery,
  });

  @override
  _ChatActionsControllerHookState createState() => _ChatActionsControllerHookState();
}

class _ChatActionsControllerHookState extends HookState<ChatActionsController, _ChatActionsControllerHook> {
  late ChatActionsController _controller;

  @override
  void initHook() {
    _controller = ChatActionsController(
      ref: hook.ref,
      chatId: hook.chatId,
      context: hook.context,
      textController: hook.textController,
      replyToMessage: hook.replyToMessage,
      selectedAssets: hook.selectedAssets,
      scrollToBottom: hook.scrollToBottom,
      isTyping: hook.isTyping,
      showGallery: hook.showGallery,
    );
  }

  @override
  ChatActionsController build(BuildContext context) => _controller;

  @override
  void dispose() {
    // Cleanup if needed
  }

  @override
  String get debugLabel => 'useChatActions';
}
